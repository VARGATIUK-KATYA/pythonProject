*** Settings ***
Library     SeleniumLibrary
Library    String
Library    BuiltIn
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


${msg_link_is}                                           Лінк має наступний вигляд:
${msg_identical}                                         Сторінки ідентичні
${msg_not_identical}                                     Сторінки не ідентичні
${text_znaideno}                                         Знайдено:
${msg}                                                   УРЛ вікна браузера:
${msg_storika ne znaidena_str}                           Сторінка не знайдена


${lctr_is_zamovnik}                                       xpath=//*[@id="companies-is_seller"]/option[1]
${lctr_is_uchasnick}                                      xpath=//*[@id="companies-is_seller"]/option[2]
${lctr_select_zamovORuchasnick}                           xpath=//*[@id="registration-form"]/div[1]/div[1]/label
${lctr_is_seller}                                         xpath=//*[@id="companies-is_seller"]
${lctr_search_btn_magnifier}                           xpath=//*[@id="__next"]/div[2]/div/div[1]/div/button
${lctr_status_name_in_auct_page}  xpath=//aside[contains(@class,"meta-blockstyles__FixedBlock-v6fx5m-0 bNaTcU")]


${BROWSER_chrome}                                       Chrome
${BROWSER_headless}                                     headlesschrome


#перемінні із Інф. Повідомлення на http://185.25.116.133:4242/
${planning_page_4242}                                        http://185.25.116.133:4242/planning/search



#перемінні із таби Інф. Повідомлення на https://prozorro.sale/
${planning_page_prod}                                        https://prozorro.sale/planning/search

*** Keywords ***


Open Browser Chrome in headless_mode
    Open Browser  ${planning_page_4242}   ${BROWSER_headless}
    Maximize Browser Window


*** Test Cases ***

ТС Порівняти урл із дева і прода за патерном planning/search
    [Documentation]  Перевірка лінків
    [Tags]  лінк в розділі Інформаційні повідомлення
    ${pattern_planning/search} =  Catenate    SEPARATOR=\n   planning/search
    Log  ${pattern_planning/search}

    #приклади використання патерну
    ${a}=     Get Lines Matching Pattern     ${pattern_planning/search}   planning/search    case_insensitive=true
    Log  ${a}
    ${c}=    Get Regexp Matches    ${pattern_planning/search}  planning/search
    Log  ${c}

    #реальна перевірка відповідності урлів із 4242 і проду до патерну  planning/search
    Go to  ${planning_page_4242}
    Maximize Browser Window
    ${url_planning_4242}=  Execute Javascript  return window.location.href
    ${url_planning_4242}=  Get Lines Matching Pattern     ${pattern_planning/search}   planning/search    case_insensitive=true

    Go to  ${planning_page_prod}
    ${url_planning_prod}=  Execute Javascript  return window.location.href
    ${url_planning_prod}=  Get Lines Matching Pattern     ${pattern_planning/search}   planning/search    case_insensitive=true

    log many  ${msg}  ${url_planning_4242}  ${url_planning_prod}
                                           0