*** Settings ***
Documentation        Ações e elementos da página de cadastro de tarefas
Library              Browser
Library    SeleniumLibrary

*** Keywords ***
Submit task form
    [Arguments]        ${tasks}
    Fill Text    css=input[name="name"]    ${tasks}[name]
    ${tags_element}        Set Variable        css=input[name=tags] 
    FOR    ${tag}    IN    @{tasks}[tags]
        Fill Text    css=input[name=tags]      ${tag}
        Sleep    1
        Browser.Press Keys   css=input[name=tags]      Enter
    END
    Sleep    10
    Click        xpath=//button[text()="Cadastrar"]
    