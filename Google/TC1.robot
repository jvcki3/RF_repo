*** Settings ***
Library     SeleniumLibrary
#Library     DataDriver      search_data.csv     dialect=excel

Resource    resources/BrowserHandling.robot
Resource    resources/settings.robot
Resource    resources/search.robot
Resource    resources/doodles.robot


Suite Setup     BrowserHandling.Open the browser
Suite Teardown      BrowserHandling.Close the browser

#Test Template   Search results  #for DDT test case

*** Variables ***



*** Test Cases ***
#DDT version script with ${search}

*** Test Cases ***

Search result
    [Documentation]     search result
    [Tags]      browser-homepage
    search.search something    forsen
    search.search result should contains predictions
    search.click on the first prediction
    search.search result should contain search keyword     forsen
    Capture Page Screenshot     TC1.png

switch to Google En
    [Documentation]     change google to Eng
    [Tags]      browser-homepage
    BrowserHandling.change language to eng
    Capture Page Screenshot     TC2.png

google images
    [Documentation]     check google image search page
    [Tags]      browser-homepage
    BrowserHandling.google images    forsen
    Capture Page Screenshot     TC3.png

gmail
    [Documentation]     access gmail from google.com
    [Tags]      Browser-google apps
    BrowserHandling.go to gmail
    Capture Page Screenshot     TC4.png

google apps
    [Documentation]     click on google apps and go to first app on google apps
    [Tags]      Browser-google apps
    BrowserHandling.google apps
    Capture Page Screenshot     TC5.png

settings
    [Documentation]     open settings from bottom right
    [Tags]      Settings
    settings.go to search settings
    Capture Page Screenshot     TC6.png

search settings
    [Documentation]     select search settings
    [Tags]      Settings
    settings.go to search settings
    settings.search result
    Capture Page Screenshot     TC7.png

dark mode
    [Documentation]     change to darkmode
    [Tags]      Settings
    BrowserHandling.dark mode
    Capture Page Screenshot     TC8.png


accessibilities
    [Documentation]     check accessibilities options
    [Tags]      browser-accessibilities
    BrowserHandling.accessibilities th
    Capture Page Screenshot     TC9.png


search by upload image
    [Documentation]     search by image with upload option
    [Tags]      browser-accessibilities
    BrowserHandling.search by image - upload image    3x (1).webp
    Capture Page Screenshot     TC10.png

keyboard
    [Documentation]     check on-screen keyboard input
    [Tags]      browser-accessibilities
    BrowserHandling.keyboard
    Capture Page Screenshot     TC11.png



Google doodles
    [Documentation]     Google Doodles page from I'm feeling lucky page
    [Tags]      homepage-doodles
    doodles.im feeling lucky page
    doodles.count doodles
    Capture Page Screenshot     TC12.png

scroll down to doodles
    [Documentation]     scrolls down to Uganda independence day 2022
    [Tags]      homepage-doodles
    doodles.im feeling lucky page
    Wait Until Keyword Succeeds    20    0.5    doodles.find element via scrolldown    //a[@title='Uganda Independence Day 2022']
    Execute Javascript      window.scrollTo(document.body.scrollHeight, document.body.scrollHeight + 200)
    sleep   2
    Capture Page Screenshot     TC13.png


*** Keywords ***

Search results
    [Documentation]     Applying Data-driven test to search result
    [Tags]  DDT
    [Arguments]     ${search}
    
    search.search something    ${search}
    search.search result should contains predictions
    search.click on the first prediction
    search.search result should contain search keyword     ${search}