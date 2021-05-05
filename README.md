*** Settings ***
Documentation  Login de acesso portal BPMN CAMUNDA
          ...  Projeto simples de apresentação da ferramenta
          ...  tentativa de realizar login no portal
Library  SeleniumLibrary

Resource        base.robot
Resource        credenciais.robot

Test Setup      Nova sessão
Test Teardown   Encerra sessão

*** Test Cases ***
01-Cenario: Fazer Login no Camunda

    [Tags]  Login
    E realizo Login
    Entao valido a mensagem de acesso    
    Clicar em Entrar

*** Keywords ***
    
    
E realizo Login
    
    Wait Until Element Is Visible   xpath://input[1]   
     
    Input text                  xpath://input[1]         ${user}
    Click Element               xpath://input[2]      
    Input text                  xpath://input[2]         ${pwd}
    Click Element               xpath://button[contains(text(),'Log in')]
    

Entao valido a mensagem de acesso
   Wait Until Element Is Visible  xpath://body/div[1]/div[1]/div[1]/div[1]/span[1]
   Click Element                 xpath://body/div[1]/div[1]/div[1]/div[1]/span[1]
   ${message}=                 Get WebElement      xpath://span[contains(text(),'Camunda Welcome')]
    Should Contain              ${message.text}     Camunda Welcome 
    Sleep    2

Clicar em Entrar
    Click Element                xpath://a[contains(text(),'Cockpit')]
    Wait Until Element Is Visible   xpath://section[2]/div[1]/div[1]/div[1]/a[1]
    Click Element                xpath://section[2]/div[1]/div[1]/div[1]/a[1]
    Click Element                xpath://a[contains(text(),'ExpandRome')]
    Sleep    2
    Click Element                xpath://tbody/tr[1]/td[2]
    Sleep   2
a
