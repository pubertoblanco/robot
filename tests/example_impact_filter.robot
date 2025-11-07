*** Settings ***
Documentation     Example accessibility test with impact filtering
Library           Collections
Library           OperatingSystem
Library           String
Library           SeleniumLibrary
Library           ../keywords/AxeLibrary.py
Suite Setup       Open Browser To Start Page
Suite Teardown    Close Browser
Test Tags         accessibility


*** Variables ***
${BROWSER}        headlesschrome
${URL}            https://example.com


*** Test Cases ***
Test All Violations
    [Documentation]    Test for all accessibility violations
    Go To    ${URL}
    Wait Until Page Contains Element    tag:body    timeout=10s
    ${violations}=    Run Axe Analysis
    ${count}=    Get Length    ${violations}
    Log    Found ${count} total violations    console=yes

Test Critical Violations Only
    [Documentation]    Test for critical accessibility violations only
    [Tags]    critical
    Go To    ${URL}
    Wait Until Page Contains Element    tag:body    timeout=10s
    ${violations}=    Run Axe Analysis    critical
    ${count}=    Get Length    ${violations}
    Log    Found ${count} critical violations    console=yes

Test Serious Violations Only
    [Documentation]    Test for serious accessibility violations only
    [Tags]    serious
    Go To    ${URL}
    Wait Until Page Contains Element    tag:body    timeout=10s
    ${violations}=    Run Axe Analysis    serious
    ${count}=    Get Length    ${violations}
    Log    Found ${count} serious violations    console=yes


*** Keywords ***
Open Browser To Start Page
    [Documentation]    Initialize the browser
    Open Browser    about:blank    ${BROWSER}
    Set Window Size    1920    1080
