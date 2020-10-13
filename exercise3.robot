*** Settings ***
Library     RequestsLibrary

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

*** Test Cases ***
# success test
API Test with POST method and success created
    Create Session    my_session    ${urlHost}     verify=true
    ${headers}=       Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=      Post Request    my_session    /v2/5e4e6fc42f00001f2016a761    headers=${headers}    data={"prefix": "${prefix}", "name": "${name}", "suffix": "${suffix}", "industry_id": "${industry_id}", "employee_size": "${employee_size}", "street": "${street}", "place": "${place}", "geograph_id": ${geograph_id}, "phone": "${phone}"}
    Should Be Equal As Strings        ${response.status_code}     201

API Test with POST method and success OK
    Create Session    my_session    ${urlHost}     verify=true
    ${headers}=       Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=      Post Request    my_session    /v3/2ce2279f-ef6c-450b-a510-48c7051c73cb    headers=${headers}    data={"prefix": "${prefix}", "name": "${name}", "suffix": "${suffix}", "industry_id": "${industry_id}", "employee_size": "${employee_size}", "street": "${street}", "place": "${place}", "geograph_id": ${geograph_id}, "phone": "${phone}"}
    Should Be Equal As Strings        ${response.status_code}     200

# failure test
API Test with POST method but get Bad Request
    Create Session    my_session    ${urlHost}     verify=true
    ${headers}=       Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=      Post Request    my_session    /v3/293a6542-fc59-44c6-a58b-a683e9055663    headers=${headers}    data={"prefix": "${prefix}", "name": "${name}", "suffix": "${suffix}", "industry_id": "${industry_id}", "employee_size": "${employee_size}", "street": "${street}", "place": "${place}", "geograph_id": ${geograph_id}, "phone": "${phone}"}
    Should Be Equal As Strings        ${response.status_code}     400

API Test with POST method but get Not Found
    Create Session    my_session    ${urlHost}     verify=true
    ${headers}=       Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=      Post Request    my_session    /v3/a1010957-2d10-48c1-bc8c-ad8535e7a3a1    headers=${headers}    data={"prefix": "${prefix}", "name": "${name}", "suffix": "${suffix}", "industry_id": "${industry_id}", "employee_size": "${employee_size}", "street": "${street}", "place": "${place}", "geograph_id": ${geograph_id}, "phone": "${phone}"}
    Should Be Equal As Strings        ${response.status_code}     404

API Test with POST method but get Internal Server Error
    Create Session    my_session    ${urlHost}     verify=true
    ${headers}=       Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=      Post Request    my_session    /v3/e494e0da-52c0-482f-9a86-ec479ba2364c    headers=${headers}    data={"prefix": "${prefix}", "name": "${name}", "suffix": "${suffix}", "industry_id": "${industry_id}", "employee_size": "${employee_size}", "street": "${street}", "place": "${place}", "geograph_id": ${geograph_id}, "phone": "${phone}"}
    Should Be Equal As Strings        ${response.status_code}     500