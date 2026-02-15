*** Settings ***
Resource    ../resources/Locators.robot
Library     SeleniumLibrary
Library    Process
Library     OperatingSystem
Library     String
Library     DateTime
Library    XML

*** Variables ***
${BROWSER_PATH}    ./drivers/chromedriver.exe
${URL}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER_NAME}    chrome
${username}        Admin
${password}        admin123
${INCIGNITO}       False
${HEADLESS}        True

*** Test Cases ***
Verify Login With Valid Credentials
    [Documentation]    This test case verifies that a user can log in with valid credentials.
    [Tags]             test001
    Go To Application
    Input Text        ${UserName_xpath}    ${username}
    Input Text        ${PassWord_xpath}    ${password}
    Element Should Be Enabled    ${UserName_xpath}
    Element Should Be Enabled    ${PassWord_xpath}
    Click Button      ${LoginButton_xpath}
    Sleep             2
    Element Should Contain    ${Dashboard_Xpath}    Dashboard
    Sleep             2
    Tear Down

Verify Login with Invalid Credentials
    [Documentation]    This test case verifies that a user cannot log in with invalid credentials.
    [Tags]             test002
    Go To Application
    Input Text    ${UserName_xpath}    aaaaaa
    Input Text    ${PassWord_xpath}    aaaaaa
    Element Should Be Enabled    ${UserName_xpath}
    Element Should Be Enabled    ${PassWord_xpath}
    Click Button    ${LoginButton_xpath}
    Sleep    2
    Element Should Contain    ${Invalidcredentials_xpath}    Invalid credentials
    Sleep    2
    Tear Down

Verify Login with Empty Username
    [Documentation]    This test case verifies that a user cannot log in with an empty username.
    [Tags]    test003
    Go To Application
    Input Text    ${PassWord_xpath}    ${password}
    Element Should Be Visible    ${PassWord_xpath}
    Click Button    ${LoginButton_xpath}
    Sleep    2
    Element Should Contain    ${Required_xpath}    Required
    Sleep    2
    Tear Down

Verify Login with Empty Password
    [Documentation]    This test case verifies that a user cannot log in with an empty password.
    [Tags]    test004
    Go To Application
    Input Text    ${UserName_xpath}    ${username}
    Element Should Be Visible    ${UserName_xpath}
    Click Button    ${LoginButton_xpath}
    Sleep    2
    Element Should Contain    ${Required_xpath}    Required
    Sleep    2
    Tear Down

Verify “Forgot your password?” Link
     [Documentation]    This test case verifies that the “Forgot your password?” link redirects to the password recovery page.
    [Tags]    test005
    Go To Application
    Sleep    2
    Element Should Be Visible    ${ForgotPassword_xpath}
    Click Element    ${ForgotPassword_xpath}
    Element Should Be Visible    ${ResetPassword_xpath}
    Element Should Contain    ${ResetPassword_xpath}    Reset Password
    Sleep    2
    Tear Down

Verify Password zField Masking
    [Documentation]    Verify that the password entered in the Password field is masked.
    [Tags]    test006
    Go To Application
    Sleep    1
    Element Should Be Visible    ${PassWord_xpath}
    Input Password    ${PassWord_xpath}    ${password}
    ${type_value}=    Get Element Attribute    ${PassWord_xpath}    type
    Should Be Equal    ${type_value}    password
    Tear Down

*** Keywords ***
Go To Application
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Run Keyword If    '${INCIGNITO}' == 'True'    Call Method    ${chrome_options}    add_argument    --incognito
    Run Keyword If    '${HEADLESS}' == 'True'    Call Method    ${chrome_options}    add_argument    --headless
    Create WebDriver    Chrome    chrome_options=${chrome_options}
    Go To    ${URL}
    Maximize Browser Window
    Set Browser Implicit Wait    10

Tear Down
    Close All Browsers

Enter Valid Credentials
    [Documentation]    Enters the valid username and password.
    Input Text    ${UserName_xpath}    ${username}
    Input Password    ${PassWord_xpath}    ${password}
