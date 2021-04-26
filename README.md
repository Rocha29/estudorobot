# estudorobot
Estudo do framework

*** Settings ***
Documentation    Projeto E2E start Processo do camunda
Library     CamundaLibrary    ${camunda_host}     
Library     RequestsLibrary
Library    Collections
Library    String
**Variables ***
${camunda_host}               http://localhost:8080
${my_process_definition_key}  ExpandRome

###proxys
${false}=          Convert To Boolean       false
${proxies}=        Create Dictionary        http=http://proxyad.venti:8989
${headersAPI}=     Create dictionary        authorization=${token}          id_process=1      x-apigw-api-id=asdfghr  x-venti-apikey=fsdf    x-venti-flowID=tetettrte    Content-Type=application/json
${proxies}      Create Dictionary     http=coloca_a_url_para_http_aqui      https=coloca_a_url_para_https_aqui

*** Test case ***
#Historia XXX
Cenario 01: Start my process
   Start my process
*** Keywords ***
Start my process
    #Post with JSON String
    Post with dictionary
    Consultar processo
    Conferir o status code   200
    #Conferir o reason        OK

Post with dictionary
    ${value}    Set Variable    [{"CNPJ": "99999999999999","name":"Robert Dictionary"}]
    ${data}    Create Dictionary    value=${value}    type=String
    ${variables}    Create Dictionary    data=${data}
    ${body}    Create Dictionary     variables=${variables}
    ${headers}    Create Dictionary
    ...    Content-Type=application/json
    Create Session    camunda     ${camunda_host}   proxies=${proxies}         disable_warnings=1   verify=${false}
    ${RESPOSTA}       Post On Session
    ...    alias=camunda
    ...    url=/engine-rest/process-definition/key/${my_process_definition_key}/start
    ...    json=${body}
    ...    headers=${headers}
    [Return]    ${body}
    Log            ${RESPOSTA.json()["id"]}         
    Set Test Variable  ${RESPOSTA}
    
    
      
   
Consultar processo  
    ${RESPOSTA}    GET On Session         camunda    engine-rest/process-instance/${RESPOSTA.json()["id"]}
    Log            ${RESPOSTA.text}
    Set Test Variable  ${RESPOSTA} 

Conferir o status code
    [Arguments]                     ${STATUS_DESEJADO}       
    Should Be Equal As Strings      ${RESPOSTA.status_code}     ${STATUS_DESEJADO}

Conferir o reason
    [Arguments]                     ${REASON_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.reason}          ${REASON_DESEJADO}       
