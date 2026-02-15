# Robot Framework Test Automation Project

## 📋 Project Overview

This is a **Robot Framework Test Automation Project** designed for automated testing of web applications, APIs, or desktop applications. Robot Framework is a generic, keyword-driven test automation framework that uses an easy-to-read tabular syntax for creating test cases.

## 🏗️ Project Structure

```
ROBOTPROJECT/
├── drivers/                 # Browser drivers (ChromeDriver, GeckoDriver, etc.)
├── resources/              # Resource files, keywords, variables
├── tests/                  # Test suite files (.robot)
├── .gitignore             # Git ignore rules
├── log.html               # Detailed execution log
├── output.xml             # Machine-readable test results
├── report.html            # High-level test report
└── setting.json           # Project configuration settings
```

## 🛠️ Technology Stack

| Technology | Purpose |
|------------|---------|
| **Robot Framework** | Test Automation Framework |
| **SeleniumLibrary** | Web UI Testing |
| **RequestsLibrary** | API Testing |
| **DatabaseLibrary** | Database Testing (if applicable) |
| **Python** | Underlying Programming Language |
| **pip** | Package Management |

## ✨ Key Features

- ✅ **Keyword-Driven Testing**: Use built-in and custom keywords for test creation
- ✅ **Data-Driven Testing**: Support for parameterized test cases
- ✅ **Cross-Browser Testing**: Test on Chrome, Firefox, Edge, Safari
- ✅ **Comprehensive Reporting**: Detailed HTML reports with logs and screenshots
- ✅ **Easy-to-Read Syntax**: Tabular format that's readable by non-programmers
- ✅ **Extensible**: Create custom libraries and keywords
- ✅ **CI/CD Integration**: Easy integration with Jenkins, GitLab CI, GitHub Actions

## 📦 Prerequisites

Before running the tests, ensure you have:

- **Python** 3.7 or higher
- **pip** (Python package installer)
- **Robot Framework** 6.0+
- **Browser Drivers** (ChromeDriver, GeckoDriver, etc.)

## 🚀 Installation & Setup

### 1. Install Python

Download and install Python from [python.org](https://www.python.org/downloads/)

```bash
python --version
```

### 2. Install Robot Framework

```bash
pip install robotframework
```

### 3. Install Required Libraries

```bash
# For Web Testing
pip install robotframework-seleniumlibrary

# For API Testing
pip install robotframework-requests

# For Database Testing
pip install robotframework-databaselibrary

# For Excel/Data handling
pip install robotframework-excellib

# For Screenshot capabilities
pip install pillow
```

### 4. Install Browser Drivers

#### Option 1: Manual Installation
Download drivers and place them in the `drivers/` folder:
- **ChromeDriver**: https://chromedriver.chromium.org/
- **GeckoDriver** (Firefox): https://github.com/mozilla/geckodriver/releases
- **EdgeDriver**: https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/

#### Option 2: Using WebDriver Manager
```bash
pip install webdrivermanager
webdrivermanager chrome firefox --linkpath drivers/
```

### 5. Verify Installation

```bash
robot --version
```

## 🧪 Running Tests

### Run All Tests

```bash
robot tests/
```

### Run Specific Test Suite

```bash
robot tests/login_tests.robot
```

### Run Tests with Specific Browser

```bash
robot --variable BROWSER:chrome tests/
robot --variable BROWSER:firefox tests/
```

### Run Tests with Tags

```bash
# Run smoke tests
robot --include smoke tests/

# Run regression tests
robot --include regression tests/

# Exclude specific tests
robot --exclude wip tests/
```

### Run Tests and Generate Custom Report

```bash
robot --outputdir results --timestampoutputs tests/
```

### Run Tests in Parallel

```bash
pip install robotframework-pabot
pabot --processes 4 tests/
```

## 📝 Writing Test Cases

### Example Test Suite

Create a file `tests/login_tests.robot`:

```robotframework
*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/common.robot
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Navigate To Login Page
Test Teardown     Capture Page Screenshot

*** Variables ***
${URL}            https://example.com
${BROWSER}        chrome
${USERNAME}       testuser
${PASSWORD}       testpass123

*** Test Cases ***
Valid Login
    [Tags]    smoke    regression
    [Documentation]    Test successful login with valid credentials
    Input Username    ${USERNAME}
    Input Password    ${PASSWORD}
    Click Login Button
    Verify Dashboard Is Displayed
    Verify Welcome Message Contains    ${USERNAME}

Invalid Login - Wrong Password
    [Tags]    regression    negative
    [Documentation]    Test login fails with incorrect password
    Input Username    ${USERNAME}
    Input Password    wrongpassword
    Click Login Button
    Verify Error Message    Invalid credentials

Empty Username
    [Tags]    regression    negative
    [Documentation]    Test login validation for empty username
    Input Username    ${EMPTY}
    Input Password    ${PASSWORD}
    Click Login Button
    Verify Error Message    Username is required

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s

Navigate To Login Page
    Go To    ${URL}/login

Input Username
    [Arguments]    ${username}
    Input Text    id:username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    id:password    ${password}

Click Login Button
    Click Button    id:login-button

Verify Dashboard Is Displayed
    Wait Until Page Contains Element    id:dashboard    10s
    Page Should Contain    Dashboard

Verify Welcome Message Contains
    [Arguments]    ${username}
    Wait Until Page Contains    Welcome, ${username}

Verify Error Message
    [Arguments]    ${message}
    Wait Until Page Contains Element    css:.error-message
    Element Should Contain    css:.error-message    ${message}
```

### Example Resource File

Create `resources/common.robot`:

```robotframework
*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           String

*** Variables ***
${TIMEOUT}        10s
${DELAY}          0.5s

*** Keywords ***
Wait For Element
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}

Take Screenshot On Failure
    Run Keyword If Test Failed    Capture Page Screenshot

Log Test Step
    [Arguments]    ${step_description}
    Log    ${step_description}    console=yes
```

## 📊 Test Reports

After test execution, three main files are generated:

### 1. **report.html**
- High-level overview of test execution
- Pass/fail statistics
- Test suite summary
- Tag statistics

### 2. **log.html**
- Detailed execution log
- Step-by-step execution details
- Screenshots (if captured)
- Error messages and stack traces

### 3. **output.xml**
- Machine-readable test results
- Used for CI/CD integration
- Can be processed by other tools

## 🎯 Test Organization

### Recommended Structure

```
tests/
├── ui_tests/
│   ├── login_tests.robot
│   ├── dashboard_tests.robot
│   └── checkout_tests.robot
├── api_tests/
│   ├── user_api_tests.robot
│   └── product_api_tests.robot
└── integration_tests/
    └── end_to_end_tests.robot

resources/
├── keywords/
│   ├── ui_keywords.robot
│   ├── api_keywords.robot
│   └── db_keywords.robot
├── variables/
│   ├── common_variables.robot
│   └── test_data.robot
└── page_objects/
    ├── login_page.robot
    └── dashboard_page.robot
```

## 🔧 Configuration

### setting.json

```json
{
  "browser": "chrome",
  "baseUrl": "https://example.com",
  "timeout": 10,
  "headless": false,
  "implicitWait": 5,
  "screenshots": {
    "onFailure": true,
    "onSuccess": false
  },
  "reporting": {
    "outputDir": "results",
    "timestampOutputs": true
  }
}
```

## 🏷️ Tagging Strategy

Use tags to organize and selectively run tests:

```robotframework
[Tags]    smoke           # Quick sanity tests
[Tags]    regression      # Full regression suite
[Tags]    critical        # Business-critical tests
[Tags]    api             # API tests
[Tags]    ui              # UI tests
[Tags]    wip             # Work in progress
[Tags]    slow            # Long-running tests
```

## 🔄 CI/CD Integration

### Jenkins Pipeline

```groovy
pipeline {
    agent any
    
    stages {
        stage('Setup') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        
        stage('Run Tests') {
            steps {
                sh 'robot --outputdir results tests/'
            }
        }
        
        stage('Publish Results') {
            steps {
                robot outputPath: 'results',
                      reportFileName: 'report.html',
                      logFileName: 'log.html',
                      outputFileName: 'output.xml'
            }
        }
    }
}
```

### GitHub Actions

```yaml
name: Robot Framework Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: 3.9
    
    - name: Install dependencies
      run: |
        pip install robotframework
        pip install robotframework-seleniumlibrary
    
    - name: Run tests
      run: robot tests/
    
    - name: Upload results
      uses: actions/upload-artifact@v2
      if: always()
      with:
        name: robot-results
        path: |
          report.html
          log.html
          output.xml
```

## 🎨 Best Practices

1. **Use Descriptive Test Names**: Make test case names clear and meaningful
2. **Keep Tests Independent**: Each test should run independently
3. **Use Page Object Pattern**: Separate page-specific keywords into resource files
4. **Proper Tagging**: Tag tests appropriately for selective execution
5. **Error Handling**: Use `Run Keyword And Continue On Failure` for soft assertions
6. **Wait Strategies**: Always use explicit waits, avoid `Sleep`
7. **Screenshots**: Capture screenshots on failure for debugging
8. **Modular Keywords**: Create reusable keywords in resource files
9. **Version Control**: Keep test scripts in Git
10. **Documentation**: Document complex keywords and test cases

## 🐛 Troubleshooting

### Common Issues

**Issue**: Browser driver not found
```bash
# Solution: Install webdriver-manager or manually download drivers
pip install webdrivermanager
webdrivermanager chrome firefox
```

**Issue**: Element not found
```bash
# Solution: Increase timeout or use explicit waits
Wait Until Element Is Visible    locator    timeout=30s
```

**Issue**: Tests fail in headless mode
```bash
# Solution: Run in headed mode for debugging
robot --variable HEADLESS:False tests/
```

## 📚 Useful Commands

```bash
# List all keywords in a library
robot --libdoc SeleniumLibrary list

# Generate keyword documentation
robot --libdoc SeleniumLibrary SeleniumLibrary.html

# Dry run (validate syntax without executing)
robot --dryrun tests/

# Run tests and open report automatically
robot --listener ReturnCodeListener tests/
```

## 📖 Documentation & Resources

- **Robot Framework User Guide**: https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html
- **SeleniumLibrary**: https://robotframework.org/SeleniumLibrary/
- **Built-in Libraries**: https://robotframework.org/robotframework/latest/libraries/BuiltIn.html
- **Community**: https://forum.robotframework.org/

## 🔐 Security Notes

- Never commit sensitive data (passwords, API keys) to version control
- Use environment variables or secure vaults for credentials
- Add `setting.json` with credentials to `.gitignore`

## 📄 License

This project is licensed under the MIT License.

## 👥 Contributors

- **Your Name** - Initial work and maintenance

---

**Last Updated**: February 2026
**Framework Version**: Robot Framework 6.x
