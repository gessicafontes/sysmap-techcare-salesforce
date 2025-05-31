# TechCare Support
A TechCare é uma empresa de suporte a clientes que lançou um Portal de Atendimento em Salesforce. 

# 📋 Documentações
[Documentação Adm](./Documentation%20Adm.md) </ br>
[Documentação Dev](./Documentation%20Dev.md)

# 🔧 Instalação

Copie o repositório para uma pasta vazia
```git clone {link}```

Autorize a Org em que irá instalar o projeto
```CTRL + ALT + P```
```SFDX: Authorize an Org```

Faça o deploy para sua Org
```SFDX: Deploy This Source to Org```

# ⚙️ Execução dos Testes
Abra a extensão testing e clique no botão de iniciar todos os testes. O coverage de toda a org está em 98%.

# 📦 Implantação
Caso seja necessário fazer a implantação em production.

1. Pré-requisitos: Ter a conexão com a production configurada e perfil com permissão
2. Vá em: `Setup -> Outbound Change Sets`
3. Clique em `new` e dê um nome
4. Adicione os componentes que quer fazer a exportação
5. Envie o change set para production
6. Em Production, vá em `Inboud Change Sets`
7. Clique em `Deploy`

