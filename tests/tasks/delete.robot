*** Settings ***
Documentation        Cenários de testes de atualização de tarefas
Resource             ../../resources/base.resource
Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve poder apagar uma tarefa indesejada
    ${data}        Get fixtures    tasks    delete 
    Create a new task from API    ${data}
    Do login    ${data}[user]
    Request removal    ${data}[task][name]
    Task should not exist    ${data}[task][name]