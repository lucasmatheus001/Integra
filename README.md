# Bem-vindo(a) ao Integra!

<h4 align="center"> 🚧 Integra Em construção... 🚧 </h4>

### Pré-requisitos 

Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas: [Git](https://git-scm.com), [Node.js](https://nodejs.org/en/), [Yarn](https://yarnpkg.com/), [Ruby On Rails](https://guides.rubyonrails.org/getting_started.html) e [PostgreSQL](https://www.postgresql.org/) . Além disto é bom ter um editor para trabalhar com o código como [VSCode](https://code.visualstudio.com/).

## Resumo

Este é uma sistema para gerenciamento de do seus negócio / E-commerce, onde você consegue realizar todas as operações que conseguiria realizar em qualquer loja virtual , como: pagamentos, dashboard/admin para gerenciamento de usuários, extrato de pagamentos e a própria consulta a aplicação.

## O que foi utilizado até o momento?

 1.  Rails 7
 2.  Yarn 1.22.22
 3.  Node 20.15.1
 4.  PostgreSQL
 5.  Bootstrap 5.3.3
 6.  Devise
 7.  Enum
 9.  Pundit
 10. Kaminari
 11. mercadopago-sdk
 
## Principais funcionalidades

 - [x] Cadastro de usuário (perfil padrão *read*);
 - [x] Login;
 - [x] CRUD de usuários ;
 - [x] CRUD de Accounts (*admin*);
 - [x] Realizar pagamentos ;
 - [x] Integração com o gateway de pagamento do mercado pago ;
 - [x] Consultar Extrato por data de início e fim ;
 - [x] Validações em Transferência;

## Pendências

 - [x] Documentação geral do sistema (README);
 - [] melhorar as seeds
 - [] melhorar os testes
 - [] regras de negócios
 - [] Aplicar corretamente a internacionalização na aplicação;
 - [] Melhorar ambientação para E-commerce ;

## Instalando o projeto

Altere as credenciais do banco em `config/database.yml`, em desenvolvimento e test já estão definidas as seguintes configurações:

 - Host: localhost
 - Porta: 5432
 - Usuário: `DATABASE_USER`
 - Senha: `DATABASE_PASSWORD`
 - Databases: *desafio_Ruby_development* e *desafio_Ruby_test*

Para executar o projeto localmente, execute os seguintes comandos:

    git clone git@github.com:lucasmatheus001/desafio-Ruby.git
    cd desafio-Ruby
    bundle install
    yarn install
    rails db:create
    rails db:migrate
    rails db:seed (para popular o banco de dados)

Serão cadastrados alguns Usuários e contas de banco para exemplificação . Credencias de acesso:

  - E-mail: admin@teste.com | senha: 123456
  - E-mail: teste@user.com  | senha: 123456

## Executando o projeto
Depois de instalar o projeto, execute os seguintes comandos:

    cd desafio-Ruby
    rails s ou bin/dev

Abra seu navegador e acesse http://localhost:3000/

A seguinte página será exibida:

![Tela de Login da aplicação](https://imgur.com/DFE7pxx.png)

![Home da aplicação](https://imgur.com/kpF8giR.gif)

![Tela de Operações da aplicação](https://imgur.com/TfKkSQS.gif)

Acesse o sistema com um dos usuários abaixo ou se preferir acesse a opção cadastrar e faça o cadastro de um novo usuário .
  - E-mail: admin@teste.com | senha: 123456
  - E-mail: admin2@teste.com | senha: 123456
  - E-mail: teste@user.com  | senha: 123456
  - E-mail: teste2@user.com  | senha: 123456
 
 
Por fim, a tela inicial do sistema fala um pouco sobre aplicação e os servições oferecidos . Na parte de Dashboard o cliente consegue ver os dados referents a sua conta e realizar operações no menu interativo, como (Acessar portal de operações,pagamentos,extrato de pagamentos, editar perfil).

