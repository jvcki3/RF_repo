*** Settings ***
Library     SeleniumLibrary
#Library     DataDriver      search_data.csv     dialect=excel

Resource    resources/BrowserHandling.robot
Resource    resources/settings.robot
Resource    resources/search.robot
Resource    resources/doodles.robot

#Test Setup      BrowserHandling.Open the browser
#Test Teardown   BrowserHandling.Close the browser
Suite Setup     BrowserHandling.Open the browser
Suite Teardown      BrowserHandling.Close the browser

#Test Template   Search results  #DDT

*** Variables ***



*** Test Cases ***
#DDT version script with ${search}

*** Test Cases ***

google images
    [Documentation]     check google image search page
    [Tags]      Browser
    BrowserHandling.google images    forsen

gmail
    [Documentation]     access gmail from google.com
    [Tags]      Browser
    BrowserHandling.go to gmail
google apps
    [Documentation]     google apps
    [Tags]      Browser
    BrowserHandling.google apps


dark mode
    [Documentation]     change to darkmode
    [Tags]      Browser
    BrowserHandling.dark mode

search by image
    [Documentation]     search by image
    [Tags]      Browser
    BrowserHandling.search by image - image    3x (1).webp

keyboard
    [Documentation]     check on-screen keyboard input
    [Tags]      Browser
    BrowserHandling.keyboard

settings
    [Documentation]     open settings from bottom right
    [Tags]      Settings
    settings.go to search settings

search settings
    [Documentation]     select search settings
    [Tags]      Settings
    settings.go to search settings
    settings.search result

Search result
    [Documentation]     search result
    [Tags]      search
    search.search something    xdding
    search.search result should contains predictions
    search.click on the first prediction
    search.search result should contain search keyword     xdding

switch to Google En
    [Documentation]     change google to Eng
    [Tags]      KDT
    BrowserHandling.change language to eng

Google doodles
    [Documentation]     Google Doodles page from I'm feeling lucky page
    [Tags]      doodles
    doodles.im feeling lucky page
    doodles.count doodles

scroll down to doodles
    [Documentation]     scrolls down to Uganda independence day 2022
    [Tags]      doodles
    doodles.im feeling lucky page
    Wait Until Keyword Succeeds    20    0.5    doodles.find element via scrolldown    //a[@title='Uganda Independence Day 2022']


*** Comments ***

accessibilities
    [Documentation]     check accessibilities options
    [Tags]      KDT
    BrowserHandling.accessibilities th
    BrowserHandling.voice recognition
    Go To    ${url}
    BrowserHandling.Search by image

Search results      #Keyword-driven
    BrowserHandling.search something    xdding
    BrowserHandling.search result should contains predictions
    BrowserHandling.click on the first prediction
    BrowserHandling.search result should contain search keyword     xdding






*** Keywords ***

Search results
    [Documentation]     Applying Data-driven test to search result
    [Tags]  DDT
    [Arguments]     ${search}
    
    search.search something    ${search}
    search.search result should contains predictions
    search.click on the first prediction
    search.search result should contain search keyword     ${search}