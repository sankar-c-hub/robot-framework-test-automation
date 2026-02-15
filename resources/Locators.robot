*** Variables ***
${UserName_xpath}    xpath://input[@placeholder='Username']
${PassWord_xpath}    xpath://input[@placeholder='Password']
${LoginButton_xpath}    xpath://button[@type='submit']
${Dashboard_Xpath}    xpath://h6[normalize-space()='Dashboard']
${Invalidcredentials_xpath}    xpath://p[@class='oxd-text oxd-text--p oxd-alert-content-text']
${Required_xpath}    xpath://span[text()='Required']
${ForgotPassword_xpath}    xpath:(//p[normalize-space()='Forgot your password?'])[1]
${ResetPassword_xpath}    xpath://h6[normalize-space()='Reset Password']