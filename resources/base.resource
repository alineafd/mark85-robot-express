*** Settings ***
Library     libs/database.py
Library     Browser
Library     JSONLibrary
Resource    env.resource
Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource
Resource    pages/components/Notice.resource
Resource    pages/components/Header.resource
Resource    pages/components/Alert.resource
Resource    pages/TaskCreatePage.robot
Resource    pages/TasksPage.resource
Resource    service.resource

*** Keywords ***
Start Session
    New Browser    browser=${BROWSER}    headless=false
    New Page       ${BASE_URL}
    
Short password
    [Arguments]    ${short_pass}   
    ${user}     Create Dictionary    
    ...    name=Aline Dias
    ...    email=aline@gmail.com
    ...    senha=${short_pass}
    Go to signup page
    Submit signup form    ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos

#Helpers

Get fixtures
    [Arguments]    ${file_name}    ${scenario}
     ${data}    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8
    [Return]    ${data}[${scenario}]

Create a new task from API
    [Arguments]    ${data}    
    Post user session    ${data}[user]
    Post a new task      ${data}[task]

Do login    
    [Arguments]    ${user}
    Submit login form    ${user}
    User should be logged in    ${user}[name]
    