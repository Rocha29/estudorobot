
*** Settings ***
Library     app.py


*** Test Cases ***
Deve retornar mensagem de boas vindas
    ${result}=          welcome     Robson
    Should Be Equal     ${result}   Olá Robson, bem vindo ao curso básico de Robot Frameworke!