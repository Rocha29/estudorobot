*** Settings ***
Resource        base.robot

Test Setup      Nova sessão
Test Teardown   Encerra sessão

*** Test Cases ***
Login com sucesso
    Go To                   ${url}/login
    Input text              css:input[name=username]    stark
    Input text              css:input[name=password]    jarvis!
    Click Element           class:btn-login

    Page Should Contain     Olá, Tony Stark. Você acessou a área logada!

Senha invalida
    [Tags]                      login_error
    Go To                       ${url}/login
    Input text                  css:input[name=username]    stark
    Input text                  css:input[name=password]    123!
    Sleep                       5
    Click Element               class:btn-login

    ${message}=                 Get WebElement      id:flash
    Should Contain              ${message.text}     Senha é invalida!


Usuário não existe
     [Tags]                      login_user404
    Go To                       ${url}/login
    Input text                  css:input[name=username]    robson
    Input text                  css:input[name=password]    123!
    Sleep                       5
    Click Element               class:btn-login

    ${message}=                 Get WebElement      id:flash
    Should Contain              ${message.text}     O usuário informado não está cadastrado!


    

