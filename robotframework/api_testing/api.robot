*** Settings ***

Library     RequestsLibrary
Library     Collections
Library     JSONLibrary
Library     String

*** Variables ***

${url}      https://data.tmd.go.th/api/
@{province}     กรุงเทพมหานคร   สระบุรี

*** Test Cases ***

request json
    &{params}   Create Dictionary   type=json
    ${resp}   get Weather3Hours    ${params}
    Log    ${resp.content}
    respond status should success    ${resp}

request bangkok
    &{params}   Create Dictionary   province=${province}[0]
    ${resp}   get Weather3Hours    ${params}
    respond status should success    ${resp}
    content is in json format    ${resp}
    verify content inside    ${resp}    $.Stations[0].Province     ${province}[0]
    #Log    ${resp.headers}
    #Log    ${resp.content}
    #Log    ${resp.url}
    #Log    ${resp.ok}
    #Log    ${resp.reason}


request saraburi json
    &{params}   Create Dictionary   province=${province}[1]
    ${resp}   get Weather3Hours    ${params}
    respond status should success    ${resp}
    content is in json format    ${resp}
    verify content inside    ${resp}    $.Stations[0].Province     ${province}[1]
    #Log    ${resp.headers}
    #Log    ${resp.content}
    #Log    ${resp.url}
    #Log    ${resp.ok}
    #Log    ${resp.reason}


*** Keywords ***

respond status should success
    [Arguments]     ${resp}
    Should Be Equal As Strings    ${resp.status_code}      200

get Weather3Hours
    [Arguments]     ${params}
    Create Session    test api    ${url}
    ${resp}    GET On Session    test api    url=Weather3Hours/V1/      params=${params}
    RETURN     ${resp}

content is in json format
    [Arguments]     ${resp}
    ${header}       Get From Dictionary    ${resp.headers}    Content-Type
    Should Be Equal As Strings    ${header}    application/json; charset=utf-8

verify content inside
    [Arguments]     ${resp}    ${path}      ${province}
    ${json_resp}    Convert String To Json    ${resp.content}
    ${content}      Get Value From Json    ${json_resp}    ${path}
    ${content}      Convert To String    ${content}
    ${content}      Remove String    ${content}     [   ]   '
    ${isTrue}       Run Keyword And Return Status      Should Be Equal    ${content}    ${province}


    IF    ${isTrue} == True
         Log    Data fetched from the request
    ELSE
         Log    Province not available
    END

