*** Settings ***
Library     SeleniumLibrary
Suite setup  Open Browser Chrome in headless_mode
Suite teardown  Close All Browsers


*** Variables ***
${doc_index}                                             0
${BROWSER_chrome}                                        Chrome
${BROWSER_headless}                                      headlesschrome

#LOCATORS
${about_us_lctr}                                     xpath=//*[@id="__next"]/header/nav/div/ul/li[1]/a
${storinka ne znaidena lctr}                         xpath=//*[@id="__next"]/div/h1
${value from znaideno}                               xpath=//*[@id="__next"]/div[3]/div[1]/text()[2]
${value from znaideno_v2}                            xpath=//div[contains(@class,"cards-liststyles") and contains(text(),"Знайдено")]
${storika ne znaidena_str}                           Сторінка не знайдена

${msg_link_is}                                           Лінк має наступний вигляд:
${msg_identical}                                         Сторінки ідентичні
${msg_not_identical}                                     Сторінки не ідентичні
${text_znaideno}                                         Знайдено:
${msg}                                                   УРЛ вікна браузера:

${lctr_select_status_value="active.tendering"}            xpath=//*[@id="status"]/option[2]
${lctr_select_status_active.enquiries}                    xpath=//*[@id="status"]/option[3]
${lctr_is_zamovnik}                                       xpath=//*[@id="companies-is_seller"]/option[1]
${lctr_is_uchasnick}                                      xpath=//*[@id="companies-is_seller"]/option[2]
${lctr_select_zamovORuchasnick}                           xpath=//*[@id="registration-form"]/div[1]/div[1]/label
${lctr_is_seller}                                         xpath=//*[@id="companies-is_seller"]
${lctr_search_btn_magnifier}                           xpath=//*[@id="__next"]/div[2]/div/div[1]/div/button
${lctr_status_name_in_auct_page}  xpath=//aside[contains(@class,"meta-blockstyles__FixedBlock-v6fx5m-0 bNaTcU")]


${BROWSER_chrome}                                       Chrome
${BROWSER_headless}                                     headlesschrome


#перемінні із http://185.25.116.133:4242/
${main_page_4242}                                        http://185.25.116.133:4242/
#${about_page}                                           http://185.25.116.133:4242/about


#перемінні із https://prozorro.sale/
${main_page_prod}                                        https://prozorro.sale/


#статуси аукціонів на http://185.25.116.133:4242
${lnk_active_tendering_4242}   http://185.25.116.133:4242/?offset=10&status=active.tendering
${lnk_active.auction_4242}     http://185.25.116.133:4242/?offset=10&status=active.auction
${lnk_active.enquiry_4242}     http://185.25.116.133:4242/?offset=10&status=active.enquiry
${lnk_active.rectification_4242}  http://185.25.116.133:4242/?offset=10&status=active.rectification
${lnk_active.qualification_4242}   http://185.25.116.133:4242/?offset=10&status=active.qualification
${lnk_active.awarded_4242}   http://185.25.116.133:4242/?offset=10&status=active.awarded
${lnk_pending.admission_4242}   http://185.25.116.133:4242/?status=pending.admission&offset=10
${lnk_complete_4242}  http://185.25.116.133:4242/?status=complete&offset=10
${lnk_cancelled_4242}  http://185.25.116.133:4242/?status=cancelled&offset=10
${lnk_unsuccessful_4242}  http://185.25.116.133:4242/?status=unsuccessful&offset=10
${lnk_auction.search_4242}  http://185.25.116.133:4242/auction/search
#статуси аукціонів https://prozorro.sale
${lnk_active_tendering_prod}  https://prozorro.sale/?status=active.tendering
${lnk_active.auction_prod}  https://prozorro.sale/?offset=10&status=active.auction
${lnk_active.enquiry_prod}  https://prozorro.sale/?status=active.enquiry&offset=10
${lnk_active.rectification_prod}  https://prozorro.sale/?offset=10&status=active.rectification
${lnk_active.qualification_prod}  https://prozorro.sale/?status=active.qualification&offset=10
${lnk_active.awarded_prod}  https://prozorro.sale/?status=active.awarded&offset=10
${lnk_pending_admission_prod}  https://prozorro.sale/?status=pending.admission&offset=10
${lnk_complete_prod}  https://prozorro.sale/?status=complete&offset=10
${lnk_cancelled_prod}  https://prozorro.sale/?status=cancelled&offset=10
${lnk_unsuccessful_prod}  https://prozorro.sale/?status=unsuccessful&offset=10
${lnk_auction.search_prod}  https://prozorro.sale/auction/search

*** Keywords ***


Open Browser Chrome in headless_mode
    Open Browser  ${main_page_4242}   ${BROWSER_headless}
    Maximize Browser Window


*** Test Cases ***


TC1 Compare search status results active.tendering on http://185.25.116.133:4242 and https://prozorro.sale
    [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Прийняття заяв на участь
    [Tags]   пошук по статусам
    Go to   ${lnk_active_tendering_4242}
    Maximize Browser Window
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_active_tendering_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC2 Compare search status results active.auction on http://185.25.116.133:4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Аукціон
    [Tags]   пошук по статусам
    Go to   ${lnk_active.auction_4242}
    Maximize Browser Window
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
   log many  ${znaideno value from 4242}


    Go to  ${lnk_active.auction_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC3 Compare search status results active.enquiry on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Період уточнень
    [Tags]   пошук по статусам
    Go to   ${lnk_active.enquiry_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_active.enquiry_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC4 Compare search status results active.rectification on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Період редагування
   [Tags]   пошук по статусам
    Go to   ${lnk_active.rectification_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_active.rectification_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC5 Compare search status results active.qualification on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Очікується публікація протоколу
   [Tags]   пошук по статусам
    Go to   ${lnk_active.qualification_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_active.qualification_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC6 Compare search status results active.awarded on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Очікується публікація договору
   [Tags]   пошук по статусам
    Go to   ${lnk_active.awarded_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_active.awarded_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}

TC7 Compare search status results pending_admissions on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Очікується рішення про викуп
   [Tags]   пошук по статусам
    Go to   ${lnk_pending.admission_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_pending_admission_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC8 Compare search status results complete on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Аукціон завершено. Договір підписано
   [Tags]   пошук по статусам
    Go to   ${lnk_complete_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_complete_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC9 Compare search status results cancelled on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Аукціон скасовано
   [Tags]   пошук по статусам
    Go to   ${lnk_cancelled_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_cancelled_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC10 Compare auction search status results unsuccessful on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Аукціон не відбувся
   [Tags]   пошук по статусам
    Go to   ${lnk_unsuccessful_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}
TC11 Compare auction search status results unsuccessful on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусзагальна кількість аукціонів
   [Tags]   пошук позагальна кількості
    Go to   ${lnk_auction.search_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_auction.search_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


    Close All Browsers
