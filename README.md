# estudorobot
Estudo do framework
*** Settings ***
Library     CamundaLibrary    http://localhost:8080
Library     RequestsLibrary
Library    Collections
Library    String
**Variables
${my_process_definition_key}  ExpandRome
*** Test case ***
Start my process
   Start my process
*** Keywords ***
Start my process
    Post with JSON String
    Post with dictionary
    Post with CamundaLibrary
Post with JSON String
    ${body}     Catenate
    ...    {
    ...    "variables": {
    ...        "data": {
    ...            "value": "[{\\"CNPJ\\": \\"99999999999999\\",\\"name\\":\\"Robert String \\"}]",
    ...            "type": "String",
    ...            "valueInfo": {
    ...                "objectTypeName": "com.fasterxml.jackson.databind.node.ArrayNode",
    ...                "serializationDataFormat": "application/json"
    ...            }
    ...        }
    ...   }
    ...    }
    ${headers}    Create Dictionary
    ...    Content-Type=application/json
    Create Session    camunda     http://localhost:8080
    Post On Session
    ...    alias=camunda
    ...    url=/engine-rest/process-definition/key/${my_process_definition_key}/start
    ...    data=${body}
    ...    headers=${headers}
Post with dictionary
    ${value}    Set Variable    [{"CNPJ": "99999999999999","name":"Robert Dictionary"}]
    ${data}    Create Dictionary    value=${value}    type=String
    ${variables}    Create Dictionary    data=${data}
    ${body}    Create Dictionary     variables=${variables}
    ${headers}    Create Dictionary
    ...    Content-Type=application/json
    Create Session    camunda     http://localhost:8080
    Post On Session
    ...    alias=camunda
    ...    url=/engine-rest/process-definition/key/${my_process_definition_key}/start
    ...    json=${body}
    ...    headers=${headers}
    [Return]    ${body}
Post with CamundaLibrary
    ${variables}     Create Dictionary    data=[{"CNPJ": "99999999999999","name":"Robert CamundaLibrary"}]
    Start process    ${my_process_definition_key}    ${variables}
