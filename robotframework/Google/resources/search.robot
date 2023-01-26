*** Settings ***

Library     SeleniumLibrary


*** Keywords ***

search something
    [Arguments]     ${search}
    Input Text    //input[@name='q']    ${search}
    Page Should Contain Element    //input[@name='q']   ${search}

    Sleep    3


search result should contains predictions
    Wait Until Page Contains Element    //div[@class='UUbT9']

    ${count}    Get Element Count    //ul[@role='listbox' and @class='G43f7e']/li    #//ul/li[@class='sbct' or @class='sbct sbre']

    Log To Console    predictions count ${count}


click on the first prediction

    Click Element    //ul/li[@class='sbct' or @class='sbct sbre'][1]

search result should contain search keyword
    [Arguments]     ${search}
    ${title}    Get Title
    Log To Console    ${title}
    Page Should Contain    ${search}