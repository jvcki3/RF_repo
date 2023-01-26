*** Settings ***

Library     SeleniumLibrary
Library     XML

*** Variables ***

${url}       https://www.google.com
@{browser}  gc  headlesschrome


*** Keywords ***
Open the browser
    Open Browser    ${url}  ${browser}[0]
    Maximize Browser Window
    Set Selenium Speed    0.5

Close the browser
    Close All Browsers



change language to eng
    Page Should Contain Element    //html[@lang='th']
    Wait Until Page Contains Element    //div[@id='SIvCob']
    Click Element     //*[@id="SIvCob"]/a               #//div[@id='SIvCob']/a
    
    Wait Until Keyword Succeeds    10    2    Page Should Contain Element    //html[@lang='en-TH']

    

accessibilities th
    Page Should Contain Element    //html[@lang='th']
    Page Should Contain Element    //span[@class='ly0Ckb']      #keyboard
    Page Should Contain Element    //div[@class='XDyW0e']       #voice recognition
    Page Should Contain Element    //div[@class='nDcEnd']       #search my image

On-screen keyboard

    Click Element    //span[@class='ly0Ckb']    #click keyboard
    Wait Until Page Contains Element    //div[@id='kbd']    #show on-screen keyboard
    Click Element    //button[@id='K82']//span      #click keyboard button
    #Sleep    3
    Page Should Contain Element    //button[@id='K82']//span[text()]    #check if key is on page
    Wait Until Page Contains Element    //div[@class='BKRPef']  #x button
    #Sleep    3
    Click Element    //div[@class='BKRPef']     #click x button to clear searchbox
    #Sleep    2

    Wait Until Page Contains Element    //div[@class='vOY7J']    #check if x button disappeared

keyboard
    Click Element    //span[@class='ly0Ckb']    #click keyboard
    Wait Until Page Contains Element    //div[@id='kbd']    #show on-screen keyboard
    ${count}    SeleniumLibrary.Get Element Count    //div[@style="white-space: nowrap; user-select: none;"]/button[not(contains(@style,"visibility: hidden;"))]
    Log To Console    ${count}
    FOR    ${counter}    IN RANGE    1    ${count}+1
        Click Element    (//div[@style="white-space: nowrap; user-select: none;"]/button[not(contains(@style,"visibility: hidden;"))])[${counter}]

    END

voice recognition
    Click Element    //div[@class='XDyW0e']
    Wait Until Page Contains Element    //div[@class='spch s2fp']

Search by image

    Click Element    //div[@class='nDcEnd']
    Wait Until Page Contains Element    //div[@class='ea0Lbe']
    Page Should Contain Element    //input[@class='cB9M7']
    Input Text    //input[@class='cB9M7']    https://cdn.7tv.app/emote/618a9c26f1ae15abc7ec7ad1/4x.webp
    Click Element    //div[@class='Qwbd3']
    Wait Until Page Contains    Google Lens

go to gmail
    Page Should Contain Element    //a[@class='gb_n' and @data-pid='23']
    Click Element    //a[@class='gb_n' and @data-pid='23' ]
    Page Should Contain    Gmail
    ${title}    Get Title
    Log To Console    ${title}

google images

    [Arguments]     ${search}
    Page Should Contain Element    //a[@class='gb_n' and @data-pid='2']
    Click Element    //a[@class='gb_n' and @data-pid='2']
    Title Should Be    Google Photos
    Input Text    //input[@name='q']    ${search}
    Click Element    //button[@class='Tg7LZd']
    Page Should Contain    forsen - Google Search

google apps
    
    Page Should Contain Element    //*[@id="gbwa"]
    Click Element    //*[@id="gbwa"]
    Select Frame    name:app
    Wait Until Page Contains Element    //*[@id='yDmH0d']


    ${count}    SeleniumLibrary.Get Element Count    //*[@class='j1ei8c']
    ${count_loaded}     SeleniumLibrary.Get Element Count    //ul[@jsname='k77Iif']//li[@class='j1ei8c']
    FOR    ${counter}    IN RANGE    1    ${count_loaded}
        ${title}    Get Text   (//ul[@jsname='k77Iif']/li[@class='j1ei8c']//span[@class='Rq5Gcb'])[${counter}]
        Log To Console    ${title}

    END

    Log To Console    there are ${count} apps in Google apps
    Click Element    //ul[@jsname='k77Iif']/*[@class='j1ei8c'][1]      #click on first apps, google account
    Wait Until Page Contains    Google Account

settings
    Wait Until Page Contains Element    //*[@jsname='LgbsSe']
    Click Element    //*[@jsname='ZnuYW']
    Click Element    //*[@jsname='LgbsSe']
    Wait Until Page Contains Element    //div[@class='gTMtLb fp-nh']/*[@jsname='V68bde']


    #${count}    SeleniumLibrary.Get Element Count    //*[@jsname='xl07Ob']/*[@jsname and not(contains(@aria-disabled,'true'))]
    #Log To Console    there are ${count} options from settings
    #Log    ${count}
    #FOR    ${counter}    IN RANGE    1    ${count}+1
    #    Mouse Over      (//*[@jsname='xl07Ob']/*[@jsname and not(contains(@aria-disabled,'true'))])[${counter}]       #//*[@class='y0fQ9c']

    #END

dark mode

    settings
    Click Element    //*[@class='y0fQ9c']
    Wait Until Page Contains Element    //meta[@content='dark' and @name='color-scheme']

search by image - image
    [Arguments]     ${image}
    Click Element    //div[@class='nDcEnd']
    #Click Element    //*[@jsname='tAPGc']

    ${filetypes}     Run Keyword And Return Status      Should Contain Any    ${image}   .jpg    .png    .bmp    .tif    .webp     ignore_case=True
    Log To Console    input contains .png is ${filetypes}
    ${file_exist}    Run Keyword And Return Status    Choose File    //*[@type='file']         C:\\Users\\ake_s\\Desktop\\bot\\${image}
    Log To Console    file exist in local machine: ${file_exist}



    IF    ${filetypes} == True
        IF    ${file_exist} == True

            Wait Until Page Contains Element    //*[@jscontroller="W2Shsb"]

        END


    ELSE

        Page Should Contain Element    //div[@class='OHzWjb']
        Log To Console    invalid file type

    END



    















