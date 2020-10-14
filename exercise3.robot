*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary

*** Variables ***
${urlHost}            https://www.mocky.io
${prefix}             PT
${name}               Sejahtera
${suffix}             Tbk
${industry_id}        1
${employee_size}      500
${street}             Jl.Sudirman kav. 21
${place}              Sudirman Tower
${geograph_id}        100
${phone}              08561290092
${endpointCreated}    /v3/f7f69cfc-0319-46e4-9b8a-0f3bd146ac84
${endpointSuccess}    /v3/a06a8835-9c81-401c-8c43-3bc1d330f8e2
${endpointBadRequest}    /v3/d5395a07-df31-42aa-a7ae-946369cfa3de
${endpointNotFound}        /v3/92d58715-f5a4-4a3f-83ce-a2e7be27896c
${endpointInternalServerError}    /v3/dd2385a3-fbe0-435d-a6a2-f608e0bc3ed3

*** Test Cases ***
# success test
API Test with POST method and success created
    Create Session    my_session    ${urlHost}     verify=true
    ${headers}=       Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=      Post Request    my_session    ${endpointCreated}    headers=${headers}    data={"prefix": "${prefix}", "name": "${name}", "suffix": "${suffix}", "industry_id": "${industry_id}", "employee_size": "${employee_size}", "street": "${street}", "place": "${place}", "geograph_id": ${geograph_id}, "phone": "${phone}"}
    Should Be Equal As Strings        ${response.status_code}     201
    ${code}=	Get Value From Json	${response.json()}	$..code
    Should Contain    ${code}     201 Created
    # This response code is returned from PUT or POST, and indicates that a new resource was created successfully.

API Test with POST method and success OK
    Create Session    my_session    ${urlHost}     verify=true
    ${headers}=       Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=      Post Request    my_session    ${endpointSuccess}    headers=${headers}    data={"prefix": "${prefix}", "name": "${name}", "suffix": "${suffix}", "industry_id": "${industry_id}", "employee_size": "${employee_size}", "street": "${street}", "place": "${place}", "geograph_id": ${geograph_id}, "phone": "${phone}"}
    Should Be Equal As Strings        ${response.status_code}     200
    ${code}=	Get Value From Json	${response.json()}	$..code
    Should Contain    ${code}     200 OK
    # Request accepted, response contains result. This is a general purpose response code that can be returned from any request.
    # For GET requests, the requested resource or data is in the response body.
    # For PUT or DELETE requests, the request was successful and information about the result (such as new resource identifiers, or changes in resource status) can be found in the response body.

# failure test
API Test with POST method but get Bad Request
    Create Session    my_session    ${urlHost}     verify=true
    ${headers}=       Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=      Post Request    my_session    ${endpointBadRequest}    headers=${headers}    data={"prefix": "${prefix}", "name": "${name}", "suffix": "${suffix}", "industry_id": "${industry_id}", "employee_size": "${employee_size}", "street": "${street}", "place": "${place}", "geograph_id": ${geograph_id}, "phone": "${phone}"}
    Should Not Be Equal As Strings        ${response.status_code}     200
    ${code}=	Get Value From Json	${response.json()}	$..code
    Should Contain    ${code}     400 Bad Request
    # The request was not valid. This code is returned when the server has attempted to process the request, but some aspect of the request is not valid

API Test with POST method but get Not Found
    Create Session    my_session    ${urlHost}     verify=true
    ${headers}=       Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=      Post Request    my_session    ${endpointNotFound}     headers=${headers}    data={"prefix": "${prefix}", "name": "${name}", "suffix": "${suffix}", "industry_id": "${industry_id}", "employee_size": "${employee_size}", "street": "${street}", "place": "${place}", "geograph_id": ${geograph_id}, "phone": "${phone}"}
    Should Not Be Equal As Strings        ${response.status_code}     200
    ${code}=	Get Value From Json	${response.json()}	$..code
    Should Contain    ${code}     404 Not Found
    # Indicates that the targeted resource does not exist. This might be because the URI is malformed, or the resource has been deleted.

API Test with POST method but get Internal Server Error
    Create Session    my_session    ${urlHost}     verify=true
    ${headers}=       Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=      Post Request    my_session    ${endpointInternalServerError}    headers=${headers}    data={"prefix": "${prefix}", "name": "${name}", "suffix": "${suffix}", "industry_id": "${industry_id}", "employee_size": "${employee_size}", "street": "${street}", "place": "${place}", "geograph_id": ${geograph_id}, "phone": "${phone}"}
    Should Not Be Equal As Strings        ${response.status_code}     200
    ${code}=	Get Value From Json	${response.json()}	$..code
    Should Contain    ${code}     500 Internal Server Error
    # This might indicate a problem with the request, or might indicate a problem in the server side code. Error information can be found in the response body.