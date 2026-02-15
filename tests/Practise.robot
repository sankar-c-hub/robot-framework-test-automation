*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Process
Library    String
Library    DateTime
Library    XML

*** Variables ***
${BROWSER_PATH}    ./drivers/chromedriver.exe
${URL}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${URL2}    https://demo.automationtesting.in/Register.html
${BROWSER_NAME}    chrome
${INCIGNITO}    False   
${HEADLESS}    False

*** Test Cases ***
Lanching the Application using robot framework
    [Documentation]    Open the URL using Robot Framework
    [Tags]    test001
    Go To Application 
    Go To     ${URL}
    Set Selenium Speed    2seconds
*** Test Cases ***
Handling the input text box using the robot framework
    [Documentation]    Handling the input box using Robot Framework
    [Tags]    test002
    Go To Application
    Set Selenium Speed    2
    Go To    ${URL2}
    
    ${firstnamexpath}    Set Variable    xpath://input[@placeholder='First Name']
    Element Should Be Visible    ${firstnamexpath}
    Element Should Be Enabled    ${firstnamexpath}
    Input Text    ${firstnamexpath}    sankar 
    ${input_value}=    Get Value    ${firstnamexpath}
    Should Be Equal    ${input_value}    sankar

    ${lastnamexpath}    Set Variable    xpath://input[@placeholder='Last Name']
    Element Should Be Visible    ${lastnamexpath}
    Element Should Be Enabled    ${lastnamexpath}
    Input Text    ${lastnamexpath}    reddy
    ${last}=    Get Value    ${lastnamexpath}
    Should Be Equal    ${last}    reddy

    Clear Element Text    ${firstnamexpath}
    Clear Element Text    ${lastnamexpath}
    Close the Browsers
Handling the Radio Button And CheckBox using the robot framework
    [Documentation]    Handling the Radio Button And CheckBox using the robot framework
    [Tags]    test003
    Open Browser    ${URL2}    ${BROWSER_NAME}    executable_path=${BROWSER_PATH}
    Maximize Browser Window
    Set Selenium Speed    2
    ${RadioButton}    Set Variable    xpath://input[@type='radio']
    Select Radio Button    radiooptions    male
    Close All Browsers

*** Keywords ***

Go To Application
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${incognito}=    Evaluate    '${INCIGNITO}'.lower() == 'true'
    ${headless}=    Evaluate    '${HEADLESS}'.lower() == 'true'
    Run Keyword If    ${incognito}    Call Method    ${chrome_options}    add_argument    --incognito
    Run Keyword If    ${headless}    Call Method    ${chrome_options}    add_argument    --headless
    Create WebDriver    Chrome    chrome_options=${chrome_options}    executable_path=${BROWSER_PATH}
    Maximize Browser Window
    Set Browser Implicit Wait    10
Close the Browsers
    Close All Browsers