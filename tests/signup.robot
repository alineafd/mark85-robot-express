*** Settings ***
Documentation    Cenários de testes do cadastro de usuários
Library          FakerLibrary
Library          ../resources/libs/database.py
Resource         ../resources/base.resource
Suite Setup      Log    Tudo aqui ocorre antes da suite (antes de todos os testes)
Suite Teardown   Log    Tudo aqui ocorre depois da suite (depois de todos os testes)
Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve poder cadastrar um novo usuário
    ${name}     FakerLibrary.Name
    ${email}    FakerLibrary.Free Email
    ${user}     Create Dictionary    
    ...    name=${name}        
    ...    email=${email}
    ...    senha=teste567    
    # Checkpoint
    Go to signup page
    Submit signup form    ${user}
    Notice should be      Boas vindas ao Mark85, o seu gerenciador de tarefas. 
    
Não deve permitir o cadastro com e-mail duplicado
    [Tags]    dup
    ${user}     Create Dictionary    
    ...    name=Aline Dias
    ...    email=aline@gmail.com
    ...    senha=teste567
    Browser.Go To    url=http://localhost:3000/signup
    # Checkpoint
    Go to signup page
    Submit signup form    ${user}
    Notice should be      Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Tags]    required   
    ${user}     Create Dictionary    
    ...    name=${EMPTY}    
    ...    email=${EMPTY}
    ...    senha=${EMPTY}
    Go to signup page
    Submit signup form    ${user}
    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com e-mail incorreto
    [Tags]      inv_email
    ${name}     FakerLibrary.Name
    ${email}    FakerLibrary.Free Email
    ${user}     Create Dictionary    
    ...    name=${name}        
    ...    email=aline.com.br
    ...    senha=teste567  
    Go to signup page
    Submit signup form    ${user}
    Alert should be    Digite um e-mail válido

Não deve cadastrar com senha muito curta
    [Tags]    temp
    @{password_list}        Create List        1    12    123    1234    12345    
    FOR    ${password}    IN    @{password_list}
        ${user}     Create Dictionary    
        ...    name=Aline Dias
        ...    email=aline@gmail.com
        ...    senha=${password}
        Go to signup page
        Submit signup form    ${user}
        Alert should be    Informe uma senha com pelo menos 6 digitos        
    END
    
Não deve cadastrar com senha de 1 digíto
    [Tags]    short_pass   
    [Template]
    Short password    1

Não deve cadastrar com senha de 2 digítos
    [Tags]    short_pass   
    [Template]
    Short password    12

Não deve cadastrar com senha de 3 digítos
    [Tags]    short_pass   
    [Template]
    Short password    123

Não deve cadastrar com senha de 4 digítos
    [Tags]    short_pass   
    [Template]
    Short password    1234

Não deve cadastrar com senha de 5 digítos
    [Tags]    short_pass   
    [Template]
    Short password    12345

*** Keywords ***
#Short password
#    [Arguments]    ${short_pass}   
#    ${user}     Create Dictionary    
#    ...    name=Aline Dias
#    ...    email=aline@gmail.com
#    ...    senha=${short_pass}
#    Go to signup page
#    Submit signup form    ${user}
#    Alert should be    Informe uma senha com pelo menos 6 digitos