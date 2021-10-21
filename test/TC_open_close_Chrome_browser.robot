*** Settings ***
Library     SeleniumLibrary
*** Variables ***
${BROWSER_chrome}                                        Chrome
${BROWSER_headless}                                      headlesschrome
${main_page}                                            http://185.25.116.133:4242/

#LOCATORS

#*** Keywords ***

*** Test Cases ***

ТС1 Open and close Chrome browser
    [Documentation]  Відкрити і закрити браузер Хром
    Open Browser  ${main_page}  ${BROWSER_chrome}
    Maximize Browser Window
    Close Browser