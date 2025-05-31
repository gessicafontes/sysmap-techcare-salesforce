import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import SLA_DEADLINE from '@salesforce/schema/Case_Request__c.SLA_Deadline__c';
import STATUS_PATH from '@salesforce/schema/Case_Request__c.Status__c';
import CLOSED_DATETIME from '@salesforce/schema/Case_Request__c.ClosedDateTime__c';
import ID_FIELD from '@salesforce/schema/Case_Request__c.Id';
import USER_ID from '@salesforce/user/Id';
import USER_ROLE_NAME from '@salesforce/schema/User.UserRole.Name';

export default class CaseRequestCountDown extends LightningElement {
    @api recordId;
    deadline;
    time;
    error;
    status;
    userRole;
    closedDateTime;
    setTimeInterval;

    @wire(getRecord, { recordId: "$recordId", fields: [SLA_DEADLINE, STATUS_PATH, CLOSED_DATETIME] })
    wireMilestone({ data, error }) {
        if (data) {
            this.deadline = getFieldValue(data, SLA_DEADLINE);
            this.status = getFieldValue(data, STATUS_PATH);
            this.closedDateTime = getFieldValue(data, CLOSED_DATETIME);

            if (this.status === 'Closed') {
                this.time = this.formatFixedTime(this.deadline, this.closedDateTime);
            } else {
                this.startCountdown();
            }
        } else if (error) {
            this.error = error;
        }
    }

    @wire(getRecord, { recordId: USER_ID, fields: [USER_ROLE_NAME] })
    wireUser({ data }) {
        if (data) {
            this.userRole = getFieldValue(data, USER_ROLE_NAME);
        }
    }

    get canReopen() {
        return this.status === 'Closed' && this.userRole === 'Premium Support';
    }

    formatFixedTime(deadline, closedTime) {
        const deadlineTime = new Date(deadline).getTime();
        const closedDate = new Date(closedTime).getTime();
        const timeDiff = deadlineTime - closedDate;

        if (isNaN(deadlineTime) || isNaN(closedDate)) return 'Tempo inválido';

        if (timeDiff < 0) return 'Expirado';

        const days = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
        const hours = Math.floor((timeDiff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((timeDiff % (1000 * 60)) / 1000);

        return `${days}d ${hours}h ${minutes}m ${seconds}s`;
    }

    startCountdown() {
        clearInterval(this.setTimeInterval);

        this.setTimeInterval = setInterval(() => {
            if (this.status === 'Closed') {
                clearInterval(this.setTimeInterval);
                return;
            }

            const deadlineTime = new Date(this.deadline).getTime();
            const currentTime = new Date().getTime();
            const timeDiff = deadlineTime - currentTime;

            if (timeDiff < 0) {
                clearInterval(this.setTimeInterval);
                this.time = 'Expirado';
            } else {
                const days = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
                const hours = Math.floor((timeDiff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((timeDiff % (1000 * 60)) / 1000);

                this.time = `${days}d ${hours}h ${minutes}m ${seconds}s`;
            }
        }, 1000);
    }

    handleReopen() {
        console.log(this.userRole);
        if (!this.canReopen) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Acesso negado',
                    message: 'Apenas usuários com a role Premium podem reabrir.',
                    variant: 'error',
                })
            );
            return;
        }

        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[STATUS_PATH.fieldApiName] = 'In Progress';

        updateRecord({ fields })
            .then(() => {
                this.status = 'In Progress';
                this.closedDateTime = null;
                this.startCountdown();
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Sucesso',
                        message: 'Status reaberto e cronômetro reiniciado.',
                        variant: 'success',
                    })
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Erro',
                        message: error.body.message,
                        variant: 'error',
                    })
                );
            });
    }

    disconnectedCallback() {
        clearInterval(this.setTimeInterval);
    }
}