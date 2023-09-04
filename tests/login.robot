*** Settings ***
Documentation    Cenários de autenticação do usuário
Resource         ../resources/base.resource
Test Setup       Start Session
Test Teardown    Take Screenshot
Library          Collections

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado
    ${user}    Create Dictionary    
    ...    name=Aline Dias     
    ...    email=aline@teste.com.br
    ...    senha=teste123
    Submit login form    ${user}
    User should be logged in    ${user}[name]

Não deve logar com senha inválida
   ${user}    Create Dictionary    
    ...    name=Aline Dias     
    ...    email=aline@teste.com.br
    ...    senha=teste123
    Set To Dictionary    ${user}        senha=teste456
    Submit login form    ${user}
    Notice should be     Ocorreu um erro ao fazer login, verifique suas credenciais.
    