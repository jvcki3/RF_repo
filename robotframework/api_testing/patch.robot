*** Settings ***

Library     RequestsLibrary
Library     Collections
Library     JSONLibrary
Library     String

*** Variables ***

@{url}      https://reqres.in/      https://gorest.co.in/
${respond_path}      $
${patch}    /public/v2/users/
@{post_api}     /api/users     /api/register    /api/users/2    /public/v2/users/
#${id}       205604

*** Comments ***
patch user
    ${data}    Create Dictionary    name=poro   job=sad
    ${resp}    patch user req    ${data}
    content should not be empty    ${resp}
    user req valid    ${resp}
    Log     ${resp.content}

*** Test Cases ***

create user
    ${data}     Create Dictionary       name=forsen     email=forsen_lo@poro3.com        gender=male         status=active
    ${auth}     Create Dictionary       Authorization=Bearer ccaf4c78dc4d09c1ae7518204426a896c7b270ccf9451acfdd05c0cb435a0417
    ${resp}     create user with auth       ${data}     ${auth}
    content should not be empty    ${resp}
    get user id    ${resp}
    user req valid    ${resp}

get user
    ${data}     Create Dictionary       name=forsen     email=forsen_lo@poro2x.com        gender=male         status=active
    ${auth}     Create Dictionary       Authorization=Bearer ccaf4c78dc4d09c1ae7518204426a896c7b270ccf9451acfdd05c0cb435a0417
    ${resp}     create user with auth       ${data}     ${auth}
    ${id}       get user id    ${resp}
    ${resp}     get user with auth    ${auth}    ${id}
    content should not be empty    ${resp}
    user req valid      ${resp}



patch with auth
    ${data1}     Create Dictionary   name=poroE   email=poro_sad@poro.pls44  gender=male    status=active
    ${data2}     Create Dictionary   name=poroPls   email=poro_sad@poro.pls  gender=male    status=active
    ${auth}     Create Dictionary   Authorization=Bearer ccaf4c78dc4d09c1ae7518204426a896c7b270ccf9451acfdd05c0cb435a0417
    ${resp}     create user with auth    ${data1}    ${auth}
    ${id}       get user id    ${resp}
    ${resp}     patch user with auth    ${data2}    ${auth}     ${id}
    content should not be empty    ${resp}
    user req valid    ${resp}


*** Keywords ***

patch user req
    [Arguments]     ${data}
    Create Session    patch user    ${url}[0]
    ${resp}     PATCH On Session    patch user      ${post_api}[2]      data=${data}       expected_status=any
    RETURN      ${resp}

get user with auth
    [Arguments]     ${auth}     ${id}
    Create Session    get user info    ${url}[1]
    ${resp}     GET On Session      get user info       ${post_api}[3]/${id}   headers=${auth}
    RETURN      ${resp}

create user with auth
    [Arguments]     ${data}     ${auth}
    Create Session    create user    ${url}[1]
    ${resp}     POST On Session      create user     ${post_api}[3]    data=${data}     headers=${auth}     expected_status=any
    RETURN      ${resp}

patch user with auth
    [Arguments]     ${data}    ${auth}     ${id}
    Create Session    patch user auth    ${url}[1]
    ${resp}     PATCH On Session    patch user auth      ${post_api}[3]/${id}     headers=${auth}     data=${data}    expected_status=any
    RETURN      ${resp}



content should not be empty
    [Arguments]     ${resp}
    ${json_patch}   Convert String To Json      ${resp.content}
    ${content}      Get Value From Json    ${json_patch}    ${respond_path}

get user id
    [Arguments]     ${resp}
    ${json_content}   Convert String To Json      ${resp.content}
    ${id}     Get Value From Json    ${json_content}    $.id
    ${id}     Convert To String    ${id}
    ${id}     Remove String    ${id}    [   ]
    RETURN  ${id}


user req valid
    [Arguments]     ${resp}
    ${status_code}  Convert To String    ${resp.status_code}
    IF         ${status_code} == 200
        Log    ${resp.reason}

    ELSE IF     ${status_code} == 201
        Log    ${resp.reason}
    ELSE
        Log    ${resp.reason}
        ${content}      Convert String To Json    ${resp.content}
        ${content}      Get Value From Json    ${content}    ${respond_path}
        Log     ${content}
    END





    #${isTrue}       Run Keyword And Return Status        Should Be Equal As Strings       ${resp.status_code}    200
    #${isTrue}       Run Keyword And Return Status                Should Be Equal As Strings       ${resp.status_code}    201