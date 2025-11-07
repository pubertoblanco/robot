*** Settings ***
Documentation     Automated accessibility testing using axe-core
Library           SeleniumLibrary
Library           Collections
Library           OperatingSystem
Library           String
Library           ../keywords/AxeLibrary.py
Suite Setup       Open Browser To Start Page
Suite Teardown    Close Browser

*** Variables ***
${BROWSER}        headlesschrome
${URLS_FILE}      ${CURDIR}/../urls.txt
${IMPACT}         ${EMPTY}

*** Test Cases ***
Test Accessibility For URLs From File
    [Documentation]    Run accessibility tests for all URLs in the urls.txt file
    [Tags]    accessibility
    ${urls}=    Load URLs From File    ${URLS_FILE}
    FOR    ${url}    IN    @{urls}
        Run Accessibility Test    ${url}
    END

*** Keywords ***
Open Browser To Start Page
    [Documentation]    Initialize the browser
    Open Browser    about:blank    ${BROWSER}
    Set Window Size    1920    1080

Load URLs From File
    [Documentation]    Read URLs from a text file, one URL per line
    [Arguments]    ${file_path}
    ${content}=    Get File    ${file_path}
    @{lines}=    Split String    ${content}    \n
    ${urls}=    Create List
    FOR    ${line}    IN    @{lines}
        ${trimmed}=    Strip String    ${line}
        Run Keyword If    '${trimmed}' != '' and not '${trimmed}'.startswith('#')
        ...    Append To List    ${urls}    ${trimmed}
    END
    RETURN    ${urls}

Run Accessibility Test
    [Documentation]    Run accessibility test on a single URL
    [Arguments]    ${url}
    Log    Testing accessibility for: ${url}    console=yes
    Go To    ${url}
    Wait Until Page Contains Element    tag:body    timeout=10s
    ${violations}=    Run Axe Analysis    ${IMPACT}
    ${violation_count}=    Get Length    ${violations}
    Log    Found ${violation_count} accessibility violations    console=yes
    Run Keyword If    ${violation_count} > 0    Log Violations    ${violations}
    Should Be Equal As Numbers    ${violation_count}    0    msg=Found ${violation_count} accessibility violations on ${url}

Log Violations
    [Documentation]    Log detailed violation information
    [Arguments]    ${violations}
    FOR    ${violation}    IN    @{violations}
        ${id}=    Get From Dictionary    ${violation}    id
        ${impact}=    Get From Dictionary    ${violation}    impact
        ${description}=    Get From Dictionary    ${violation}    description
        ${help_url}=    Get From Dictionary    ${violation}    helpUrl
        ${nodes}=    Get From Dictionary    ${violation}    nodes
        ${node_count}=    Get Length    ${nodes}
        Log    \n=== VIOLATION ===    console=yes
        Log    ID: ${id}    console=yes
        Log    Impact: ${impact}    console=yes
        Log    Description: ${description}    console=yes
        Log    Help: ${help_url}    console=yes
        Log    Affected nodes: ${node_count}    console=yes
        FOR    ${node}    IN    @{nodes}
            ${html}=    Get From Dictionary    ${node}    html
            Log    - ${html}    console=yes
        END
    END
