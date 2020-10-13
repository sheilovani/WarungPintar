*** Settings ***
Library     Collections
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
API Test with POST method
    Create Session    my_session    ${urlHost}
    ${headers}=       Create Dictionary      Content-Type=application/json    charset=utf-8
    ${response}=      Post Request    my_session    /v2/5e4e6fc42f00001f2016a761    headers=${headers}    data={"prefix": "${prefix}", "name": "${name}", "suffix": "${suffix}", "industry_id": "${industry_id}", "employee_size": "${employee_size}", "street": "${street}", "place": "${place}", "geograph_id": ${geograph_id}, "phone": "${phone}"}
    Should Be Equal As Strings        ${response.status_code}     201