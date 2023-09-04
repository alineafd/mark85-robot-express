*** Settings ***
Documentation    Online
Resource        ../resources/base.resource

*** Test Cases ***
Webapp deve estar online
    Start Session
    Browser.Get Title      equal    Mark85 by QAx