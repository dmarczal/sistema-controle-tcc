# Sistema para controle do TCC

Sistema para controle do TCC de TSI da UTFPR

##Funcionalidades
* Professor responsável
    * ;
    * .

* Professor orientador
    * ;
    * .

* Orientando
    * ;
    * .

* Público
    * ;
    * .

##Instalação
1. Faça o download no repositório do [Projeto](https://github.com/dmarczal/sistema-controle-tcc) ou clone o repositório do projeto utilizando o comando 
    * `git clone git@github.com:dmarczal/sistema-controle-tcc.git`
2. Instalar as gems necessárias
    * Executar  `bundle install`
3. Configure as seguintes variáveis de ambiente
```
    export TCC_DROPBOX_APP_KEY=
    export TCC_DROPBOX_APP_SECRET=
    export TCC_DROPBOX_ACCESS_TOKEN=
    export TCC_DROPBOX_TOKEN_SECRET=
    export TCC_DROPBOX_USER_ID=

    export TCC_DB_USERNAME=
    export TCC_DB_PASSWORD=
```
4. Crie as tabelas do banco de dados
    * Executar `rake db:create`
    * Executar `rake db:migrate`


##Configuração
1.

##Demo
1.

##Documentação

##Suporte

