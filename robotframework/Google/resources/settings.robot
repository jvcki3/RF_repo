*** Settings ***
Library     SeleniumLibrary
Resource    BrowserHandling.robot


*** Keywords ***

go to search settings
    BrowserHandling.settings
    Mouse Over    //*[@jsname='xl07Ob']/*[@jsname and not(contains(@aria-disabled,'true'))][1]
    Click Element    //*[@jsname='xl07Ob']/*[@jsname and not(contains(@aria-disabled,'true'))][1]
    Page Should Contain    การตั้งค่าการค้นหา

search result

    Wait Until Page Contains Element    //div[@id='srhSec']
    Click Element    //div[@id='ssc']//child::span[@role='checkbox']    #safe search
    Click Element    //div[@class="URIeEf" and @id='B9FV7d']//span[text()='เปิด']   #continuous scrolling
    Click Element    //div[@class="URIeEf" and @id='Z7WJjd']//span[text()='อย่าแสดงการค้นหายอดนิยม']    #not showing popular search
    Click Element    //div[@class="URIeEf"]//span[text()='เปิดผลการค้นหาที่เลือกแต่ละรายการในหน้าต่างเบราว์เซอร์ใหม่']
    Execute Javascript      window.scrollTo(0, document.body.scrollHeight)
    Sleep    2
    Click Element    //*[@id='regionanchormore']//span[text()='แสดงเพิ่มเติม']
    Scroll Element Into View    //div[@id='regionoTH']
    Click Element    //div[@id='regionoTH']
    Scroll Element Into View    //div[@role='button' and text()='บันทึก']
    Click Element    //div[@role='button' and text()='บันทึก']
    Alert Should Be Present     การกำหนดค่าของคุณถูกบันทึกไว้แล้ว       ACCEPT
    Sleep    2
    Page Should Contain Element    //html[@lang="th"]

