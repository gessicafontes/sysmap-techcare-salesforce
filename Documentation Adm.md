# Apps & tabs
**Explicação**: Foi criado um app chamado `TechCare Support` que contém as tabs `Solicitaçã de casos`, `Relatórios` e `Gráficos`.

**Teste**:
| Passos    | Ação      | Exemplo|
|-----------|-----------|-------|
|1. Pré-requisitos:| É necessário ter um user de administrador, ou já está atribuído a um dos permissionamentos, `Support Standard`ou `Support Premium`.| |
|2.| Clique no `App Launcher`| ![](./assets/images/App%20Launcher.jpg)
|3.| Selecione `TechCare Support`| ![](./assets/images/TechCare%20Support.jpg)|

# Objetos Customizados
## Objeto Case_Request__c 
**Explicação**: O objeto em questão é onde amarzenamos os nossos casos.

### Campos
| Label | Name| Data Type |
|-------|-----|----------|
|Asssunto|Subject_c|Text(255)|
|Caso ID| Name| Auto Number|
|Conta|Account__c|Lookup(Account)|
|Contato|Contact__c|Lookup(Contact)|
|Contato Emergencial|Emergency_Contact__c|Text(80)|
|Created By|CreatedById|Lookup(User)|
|Data e hora de fechamanento| ClosedDataTime__c|Date/Time|
|Descrição|Description__c|Long Text Area(32768)|
|Email Web|Email_Web__c|Email|
|Empresa Web|WebCompany__c|Text(80)|
|Evidências|Evidence__c|Long Text Area(32768)|
|Impacto|Impact__c|Picklist|
|Last Modified By|LastModifiedById|Lookup(User)|
|Nome Web|WebName__c|Text(80)|
|Notas de resolução|Resolution_Notes__c|Long Text Area(32768)|
|Origem do caso|CaseOrigin__c|Picklist|
|Owner|OwnerId|Lookup(User, Group)|
|Prazo SLA| SLA_Deadline__c | Date/Time|
|Prioridade|Priority__c|Picklist|
|Produto|Product__c|Picklist|
|Razão do caso|Case_Reason__c|Picklist|
|Record Type|RecordTypeId|Record Type|
|Sistema de terceiros envolvido|ThirdPartySystemInvolved__c|Text(80)|
|Status|Status__c|Picklist|
|Telefone Web|WebPhone__c|Text(40)|
|Tempo de resolução|Resolution_Time__c|Time|
|Tempo de resolução em número|Time_resolution_numebr__c|Formula(Number)|
|Tipo|Type__c|Picklist|
|Urgência|Urgency__c|Picklist|

**Resultado**: ![](./assets/images/Campos%20Objeto%20Request%20Case.jpg)

### Record Type e Page Layouts
**Explicação**: Temos dois record types, onde a diferença em si no layout é a obrigatoriedade em preencher a descrição. Já que normalmente apenas o assunto é necessário para compreender um caso.

#### Record Types
![](./assets/images/Record%20Types.jpg)
#### Page Layouts
![](./assets/images/Page%20Layouts.jpg)

### Validation Rules
**Explicação**: Temos regras de valições que seguem algumas regras de negócio.

#### Only_Premium_can_reopen_a_case	
**Explicação**: Apenas usuários do suporte premium podem reabrir o caso.
![](./assets/images/Only_Premium_can_reopen_a_case.jpg)

#### Prevent_Closed_On_Create
**Explicação**: Não pode colocar o status como fechado ao criar um novo registro.
![](./assets/images/Prevent_Closed_On_Create.jpg)

#### Status_closed_with_no_resolution_notes	
**Explicação**: A nota de resolução deve ser preenchida antes de o status ser closed.
![](./assets/images/Status_closed_with_no_resolution_notes.jpg)

### Path
**Explicação**: Foi criado um path para um facilidade visual maior do caminho para o suport.
![](./assets/images/Path.jpg)

**Resultado**: ![](./assets/images/Path%20Record.jpg)

**Teste**:
| Passos    | Ação      | Exemplo|
|-----------|-----------|-------|
|1. Pré-requisitos:| É necessário ter um user de administrador, ou já está atribuído a um dos permissionamentos, `Support Standard`ou `Support Premium`.| |
|2.| Clique no `App Launcher`| ![](./assets/images/App%20Launcher.jpg)
|3.| Selecione `TechCare Support`| ![](./assets/images/TechCare%20Support.jpg)|
|4.| Clique no botão `new`ou `novo` | ![](./assets/images/Case%20Request%20New%20Record.jpg) |
|5.| Escolha um tipo de record type (Premium ou Standard)| ![](./assets/images/Case%20Request%20Choice%20Record%20Type.jpg) |
|6.| Preencha todos os campos obrigatórios e crie o registro| ![](./assets/images/Creating%20a%20record.jpg) |
|7.| Mude o status para `Closed`| ![](./assets/images/status%20closed.jpg)|


## Objeto Case_History__c
**Explicação**: O objeto em questão armazena os casos e se o SLA dos mesmo foram cumpridos ou não.

### Campos
| Label | Name| Data Type |
|-------|-----|----------|
|Caso|Case__c|Lookup(Solicitação de caso)|
|Created By|CreatedById|Lookup(User)|
|Last Modified By|LastModifiedById|Lookup(User)|
|Nome|Name|Auto Number|
|Owner|OwnerId|Lookup(User, Group)|
|SLA Atendido|SLA_Met__c|Checkbox|
|Tempo de fechamento|Time_Closed__c|Time|

# Permissions sets e Roles
## Roles
**Explicação**: Dois Roles foram criados dentro de SVP, Customer Service & Support, `Premium Support` e `Standard Support`, para ajudar na atribuição, como o role é algo atribuído na criação do usuário, se tem um controle maior de quem pode usar aquilo ou não. 
![](./assets/images/Roles.jpg)

## Public Groups
**Explicação**: Existem dois grupos públicos `Premium Support` e `Standard Support`, ambos foram criados para uma maior facilidade ao compartilhamento de conteúdo como relatórios e gráficos. E ambos tem roles designadas, também visando uma maior facilidade na hora de atribuição de conteúdos.

![](./assets/images/Public%20Groups.jpg)

## Permission Sets
**Objetivo**: Garantir acesso e layout diferentes dependendo do permission set aplicado.

### Support Standard
#### Objeto Case_Request__c
![](./assets/images/Permission%20set%20support%20standard.jpg)

**Explicação**: O objeto é visível, tendo permissão até de deletar o registro do mesmo e também é permitido a criação dos dois tipos de registro (Premium e Standard).
Quase todos os campos estão liberados para visualizar ou editar, menos o SLA_Deadline__c e Time_resolution_number__c.

### Support Premium
#### Objeto Case_Request__c
![](./assets/images/Permission%20set%20support%20premium.jpg)

**Explicação**: O objeto é visível, tendo permissão até de deletar o registro do mesmo e também é permitido a criação dos dois tipos de registro (Premium e Standard).
Quase todos os campos estão liberados para visualizar ou editar, menos o Time_resolution_number__c.

### Support Standard e Support Premium
#### Objeto Case_History__c
![](./assets/images/Permission%20set%20support%20standard%20history%20case.jpg)

**Explicação**: O objeto em sí é apenas visível, isso por conta da automação de criação que ocorre sempre que o status do caso é `Closed`.

**Teste**:
| Passos    | Ação      | Exemplo|
|-----------|-----------|-------|
|1. Pré-requisitos:| É necessário ter um user de administrador (para se atribuir a uns dos permissions) ou já está atribuído ao permissionamento.| |
|2.| Clique no `App Launcher`| ![](./assets/images/App%20Launcher.jpg)
|3.| Selecione `View All` ou `Ver todos`| ![](./assets/images/App%20Launcher%20More%20Informations.jpg)
|4.| Na barra de pesquisa, escreva `Solicitação de casos` e clique na mesma.| ![](./assets/images/App%20Launcher%20Search%20Bar.jpg) |
|5.| Clique no botão `new`ou `novo` | ![](./assets/images/Case%20Request%20New%20Record.jpg) |
|6.| Escolha um tipo de record type (Premium ou Standard)| ![](./assets/images/Case%20Request%20Choice%20Record%20Type.jpg) |

# Page layout dinamics
**Explicação**: Foi criado uma lightning page no app builder para tanto a parte de UX quanto para suprir algumas demandas.

![](./assets/images/Lightning%20App%20Builder.jpg)

Grande parte da obrigariedade foi deixada na responsibilidade da lightning page, por se tratar de dois record pages, ela cobre os dois.

![](./assets/images/Lightning%20App%20Builder%20Filtros.jpg)

Foram colocados filtros para visualização de determinadas seções.

## Informações Críticas
**Explicação**: Essa seção só irá aparecer quando a prioridade do registro for alto, demonstrando uma mair importância nos detalhes para a solução do caso.

![](./assets/images/Lightning%20App%20Builder%20informacao%20critica.jpg)

## Seção Web
**Explicação**: Nesse caso, essa seção só irá aparecer quando a forma de contato for web, demandando informações especiais para o tipo de contato específico.

![](./assets/images/Lightning%20App%20Builder%20secao%20web.jpg)

# Relatório e Dashboard
**Explicação**: Foram criados 3 relátorios a espera de atender a demanda, onde os 3 foram colocados em uma pasta `Case Request` pública com acesso dispoível para os grupos públicos `Premium Support` e `Standard Support`.

![](./assets/images/Sharing%20folder%20report.jpg)

## Relatórios

### Cases opened by priority and status
**Explicação**: Casos abertos em uma tabela, baseados em prioridade e status.

![](./assets/images/Cases%20opened%20by%20priority%20and%20status.jpg)

### Open vs. closed cases in the last 7 days
**Explicação**: Casos abertos e fechados na última semana. 

![](./assets/images/Open%20vs.%20closed%20cases%20in%20the%20last%207%20days.jpg)
![](./assets/images/Open%20vs.%20closed%20cases%20in%20the%20last%207%20days%202.jpg)

### Resolution case per type
**Explicação**: Casos resolvidos com bate no tipo e a média de hora de cada que levou para resolver.

![](./assets/images/Resolution%20case%20per%20type.jpg)

## Gráficos

### Gráfico de Solicitação de Caso
**Explicação**: Aqui temos dois gráficos, um do report de casos abertos e fechados nos últimos 7 dias e o de tempo médio fechamento de tipo de caso.
![](./assets/images/grafico%20de%20solicitacao%20de%20caso.jpg)

# Flows
## Assigning SLA Date and Time
**Explicação**: Esse flow irá preencher o campo de SLA após a criação de um caso, determinando pelo tipo de registro que foi selecionado. Se for premium, é SLA de 8 horas, caso seja Standard, o SLA será de 24 horas.

![](./assets/images/Assigning%20SLA%20Date%20and%20Time.jpg)

## Case Request Escalation
**Explicação**: Esse flow schedule irá rodar diariamente as 00:00 e irá verificar se um caso passou do seu SLA determinado e caso isso seja verdadeiro, ele irá mudar o status para `Escalado`.

![](./assets/images/Case%20Request%20Escalation.jpg)

## Change Request Case Closed Date/Time
**Explicação**: Esse flow irá ser acionado quando o caso muda para o status `Fechado`, inserindo a data e hora atual ao campo `Data e hora de fechamento`.

![](./assets/images/Change%20Request%20Case%20Closed%20Date%20Time.jpg)

## Request Case Queue Attribution
**Explicação**: Esse é um flow autolaunched onde é necessário a inserção de um botão na página de registro para chamar o mesmo.

### Queues
**Explicação**: Foram criadas 6 filas com base no nível de severidade de um caso e também tipo de registro.
![](./assets/images/Queues.jpg)

### Flow
**Explicação**: O flow determina qual o tipo de record e também sua severidade, enviando para a fila designada.

![](./assets/images/Request%20Case%20Queue%20Attribution.jpg)

### Botão
**Explicação**: Foi criado um botão no objeto que se referencia ao flow, onde que toda vez que for clicado, ocorrerá a atribuição de fila para registro.

![](./assets/images/button%20queue.jpg)

| Passos    | Ação      | Exemplo|
|-----------|-----------|-------|
|1. Pré-requisitos:| É necessário ter um user de administrador, ou já está atribuído a um dos permissionamentos, `Support Standard`ou `Support Premium`.| |
|2.| Clique no `App Launcher`| ![](./assets/images/App%20Launcher.jpg)
|3.| Selecione `TechCare Support`| ![](./assets/images/TechCare%20Support.jpg)|
|4.| Clique no botão `new`ou `novo` | ![](./assets/images/Case%20Request%20New%20Record.jpg) |
|5.| Escolha um tipo de record type (Premium ou Standard)| ![](./assets/images/Case%20Request%20Choice%20Record%20Type.jpg) |
|6.| Preencha todos os campos obrigatórios e crie o registro| ![](./assets/images/Creating%20a%20record.jpg) |
|7.| Clique no botão de atribuição de fila. |![](./assets/images/assign%20to%20queue.jpg)|
