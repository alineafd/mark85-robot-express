*** Settings ***
Documentation        Ações e elementos da página de login
Library              Browser
Library              SeleniumLibrary

*** Keywords ***
Submit login form
    [Arguments]    ${user}
    Fill Text      css=input[placeholder$=mail]        ${user}[email]
    Fill Text      css=input[placeholder="Senha"]      ${user}[senha]
    Click          xpath=//button[text()="Entrar"]
