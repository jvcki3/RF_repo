*** Settings ***

Library     SeleniumLibrary

*** Keywords ***

im feeling lucky page
    Wait Until Page Contains Element    xpath:/html/body/div[1]/div[3]/form/div[1]/div[1]/div[4]/center/input[2]    #copy xpath from chrome
    Click Element    //div[@class='FPdoLc lJ9FBc']/center/input[@name='btnI']   #written xpath

    Wait Until Page Contains Element    //title
    Wait Until Page Contains Element    //div[@id='archive']
    sleep   3


    #//li[@class='doodle-thumb hide-card'] //div[normalize-space(@class)='date']  Doodles Date xpath
    #//div[normalize-space(@class)='date']
count doodles

    ${count2023}    SeleniumLibrary.Get Element Count    //div[@class='date' and contains(text(),'2023')]
    ${count2022}    SeleniumLibrary.Get Element Count    //div[@class='date' and contains(text(),'2022')]

    ${date}     Get Text    //div[translate(normalize-space(translate(@class, ',' , ' ')), ',' , ' ')='date']           #//div[@class=translate('date', ',' , ' ')]
    Log To Console    There are ${count2023} Doodles in 2023
    Log To Console    There are ${count2022} Doodles in 2022
    Log To Console      check date ${date}


    FOR    ${counter}    IN RANGE   ${count2023}+1    ${count2023}+${count2022}+1
        ${title}   Get Text    (//div[@class='info']//div[@class='title'])[${counter}]       #//(div[@class='date' and contains(text(),'2023')])[${counter}]
        ${date}    Get Text    (//div[@class='info']//div[@class=translate('date',',','')])[${counter}]
        Log To Console    ${title}, ${date}
    END

find element via scrolldown
    [Arguments]     ${doodle}
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Scroll Element Into View    ${doodle}