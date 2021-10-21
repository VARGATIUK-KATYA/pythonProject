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


# напрямки роботи  http://185.25.116.133:4242
${lnk_aotherAssets_4242}   http://185.25.116.133:4242/?offset=10&stream=otherAssets
${lnk_sellout&offset_4242}     http://185.25.116.133:4242/?stream=sellout&offset=10
${lnk_legitimatePropertyLease_4242}     http://185.25.116.133:4242/?stream=legitimatePropertyLease&offset=10
${lnk_propertyLease&offset_4242}  http://185.25.116.133:4242/?stream=propertyLease&offset=10
${lnk_dgf&offset_4242}   http://185.25.116.133:4242/?stream=dgf&offset=10
${lnk_landRental_4242}   http://185.25.116.133:4242/?stream=landRental&offset=10
${lnk_landSell_4242}   http://185.25.116.133:4242/?stream=landSell&offset=10
${lnk_bankruptcy_4242}  http://185.25.116.133:4242/?stream=bankruptcy&offset=10
${lnk_timber_4242}  http://185.25.116.133:4242/?stream=timber&offset=10
${lnk_railwayCargo_4242}  http://185.25.116.133:4242/?stream=railwayCargo&offset=10




#статуси аукціонів https://prozorro.sale
${lnk_aotherAssets_prod}  https://prozorro.sale/?offset=10&stream=otherAssets
${lnk_sellout_prod}  https://prozorro.sale/?offset=10&stream=sellout
${lnk_legitimatePropertyLease_prod}  https://prozorro.sale/?offset=10&stream=legitimatePropertyLease
${lnk_propertyLease_prod}  https://prozorro.sale/?offset=10&stream=propertyLease
${lnk_dgf_prod}  https://prozorro.sale/?offset=10&stream=dgf
${lnk_landRental_prod}  https://prozorro.sale/?offset=10&stream=landRental
${lnk_landSell_prod}  https://prozorro.sale/?offset=10&stream=landSell
${lnk_bankruptcy_prod}  https://prozorro.sale/?offset=10&stream=bankruptcy
${lnk_timber_prod}  https://prozorro.sale/?offset=10&stream=timber
${lnk_railwayCargo_prod}  https://prozorro.sale/?offset=10&stream=railwayCargo




*** Keywords ***


Open Browser Chrome in headless_mode
    Open Browser  ${main_page_4242}   ${BROWSER_headless}
    Maximize Browser Window


*** Test Cases ***


TC1 Compare search status results active.tendering on http://185.25.116.133:4242 and https://prozorro.sale
    [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусуПродаж майна та активів
    [Tags]   пошук по статусам
    Go to   ${lnk_aotherAssets_4242}
    Maximize Browser Window
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_aotherAssets_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC2 Compare search status results active.auction on http://185.25.116.133:4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Мала приватизація
    [Tags]   пошук по статусам
    Go to   ${lnk_sellout&offset_4242}
    Maximize Browser Window
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
   log many  ${znaideno value from 4242}


    Go to  ${lnk_sellout_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC3 Compare search status results active.enquiry on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Оренда державного та комунального майна
    [Tags]   пошук по статусам
    Go to   ${lnk_legitimatePropertyLease_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_legitimatePropertyLease_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC4 Compare search status results active.rectification on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Оренда майна та активів
   [Tags]   пошук по статусам
    Go to   ${lnk_propertyLease&offset_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_propertyLease_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC5 Compare search status results active.qualification on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Продаж активів банків-банкрутів (ФГВФО)
   [Tags]   пошук по статусам
    Go to   ${lnk_dgf&offset_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_dgf_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC6 Compare search status results active.awarded on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Оренда землі
   [Tags]   пошук по статусам
    Go to   ${lnk_landRental_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_landRental_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}

TC7 Compare search status results pending_admissions on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Продаж землі
   [Tags]   пошук по статусам
    Go to   ${lnk_landSell_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_landSell_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC8 Compare search status results complete on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Банкрутство
   [Tags]   пошук по статусам
    Go to   ${lnk_bankruptcy_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_bankruptcy_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC9 Compare search status results cancelled on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Необроблена деревина
   [Tags]   пошук по статусам
    Go to   ${lnk_timber_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}


    Go to  ${lnk_timber_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


TC10 Compare auction search status results unsuccessful on dev/4242 and https://prozorro.sale
   [Documentation]  Зайти на дев і прод і порівляти результати пошуку по статусу Оренда вагонів
   [Tags]   пошук по статусам
    Go to   ${lnk_railwayCargo_4242}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from 4242}=  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from 4242}



    Go to  ${lnk_railwayCargo_prod}
    Maximize Browser Window
    Wait until element is visible  ${value from znaideno_v2}  timeout=20
    ${znaideno value from prod} =  Get text  ${value from znaideno_v2}
    log many  ${znaideno value from prod}
    Log Location

    should be equal as strings  ${znaideno value from 4242}   ${znaideno value from prod}


    Close All Browsers
