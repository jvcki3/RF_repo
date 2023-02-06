*** Settings ***

Library     RequestsLibrary
Library     Collections
Library     JSONLibrary
Library     String

*** Variables ***

${url}      https://reqres.in/
${respond_path}      $
@{post_api}     /api/users     /api/register
*** Test Cases ***
POST user
    &{data}     Create Dictionary       name=Poro       job=Sad
    ${resp}     post user req    ${data}
    post user req valid    ${resp}
    #respond should not be empty    ${resp}
    Log    ${resp.url}

POST register
    &{data}     Create Dictionary     email=eva.holt@reqres.in        password=porosad    #email=sydney@fife
    ${resp}     post register req    ${data}
    post register req valid    ${resp}
    respond should not be empty    ${resp}

*** Keywords ***

post user req
    [Arguments]     ${data}
    Create Session    post req    ${url}    disable_warnings=1
    ${resp}     POST On Session     post req      ${post_api}[0]    data=${data}      expected_status=any

    RETURN      ${resp}

post register req
    [Arguments]     ${data}
    Create Session    post regis    ${url}     disable_warnings=1
    ${resp}     POST On Session     post regis      ${post_api}[1]    data=${data}    expected_status=any

    RETURN      ${resp}


respond should not be empty
    [Arguments]     ${resp}
    ${json_resp}    Convert String To Json    ${resp.content}
    ${content}     Get Value From Json    ${json_resp}    ${respond_path}
    ${content}     Convert Json To String    ${content}
    ${content}     Remove String    ${content}  [   ]   "   '   {   }
    Should Not Be Empty    ${content}
    Log     ${content}


post user req valid
    [Arguments]     ${resp}
    ${isTrue}    Run Keyword And Return Status      Should Be Equal As Strings    ${resp.status_code}    201
    IF    ${isTrue} == True
         Log    ${resp.ok}
    ELSE
         Log Many    ${resp.status_code}    ${resp.reason}
    END

post register req valid
    [Arguments]     ${resp}
    ${isTrue}    Run Keyword And Return Status      Should Be Equal As Strings     ${resp.status_code}    200
     IF    ${isTrue} == True
         Log    ${resp.ok}
     ELSE
         Log Many     ${resp.status_code}   ${resp.reason}

     END
