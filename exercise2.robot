*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${urlGitHub}                            https://github.com/
${signIn}                               xpath=//a[@href="/login"]
${usernameTextField}                    id=login_field
${passwordTextField}                    id=password
${signInButton}                         css:.btn-block
${pullRequestInHeader}                  xpath=//a[@href="/pulls"]
${dropdownMenu}                         css:.details-reset
${newGist}                              xpath=//a[@href="https://gist.github.com/"]
${logoGist}                             css:.octicon-logo-gist
${filenameTextField}                    css:.js-blob-filename
${bodyTextField}                        css:.CodeMirror-line
${dropdownMenuButton}                   css:.select-menu-button
${chooseCreatePublicGist}               xpath=//*[contains(text(), 'Create public gist')]
${CreatePublicGistButton}               css:button.js-sync-select-menu-button
${codeAndRevisionsTab}                  css:.UnderlineNav-body                             
${editButton}                           css:a[aria-label="Edit this Gist"]
${updatePublicGistButton}               xpath=//*[contains(text(), 'Update public gist')]
${deleteButton}                         css:button[aria-label="Delete this Gist"]
${deleteSuccess}                        id=js-flash-container
${listOfGists}                          css:a[aria-label="All gists"]

*** Keywords ***
Open GitHub Web
    Open Browser                         ${urlGitHub}        Chrome
    Maximize Browser Window

Click Sign In
    Click Element                        ${signIn}

Login With Valid Username
    Wait Until Page Contains             Sign in to GitHub
    Input Text                           ${usernameTextField}        yourUsername

Login With Valid Password
    Input Password                       ${passwordTextField}        yourPassword

Click Sign In Button
    Click Button                         ${signInButton}

Login Successfully
    Wait Until Page Contains Element     ${pullRequestInHeader}

Create New Gist 
    Click Element                        ${dropdownMenu}
    Click Link                           ${newGist}
    Wait Until Page Contains Element     ${logoGist}
 
Write File Name
    Wait Until Page Contains Element     ${filenameTextField}
    Click Element                        ${filenameTextField}
    Input Text                           ${filenameTextField}            textfile1.txt

Write Body of File
    Wait Until Page Contains Element     ${bodyTextField}
    Click Element                        ${bodyTextField}
    Input Text                           ${bodyTextField}                Hello, Warung Pintar!

Choose Create Public Gist
    Click Element                        ${dropdownMenuButton}
    Sleep                                1 seconds
    Click Element                        ${chooseCreatePublicGist}
    Sleep                                1 seconds

Click Create Public Gist Button
    Click Button                         ${CreatePublicGistButton}

User Can Create a Public Gist Successfully
    Wait Until Page Contains Element     ${codeAndRevisionsTab}

Click Edit Button
    Wait Until Page Contains Element     ${editButton}
    Set Focus To Element                 ${editButton}
    Sleep                                1 seconds
    Click Element                        ${editButton}

In Editing Page
    Wait Until Page Contains Element     ${updatePublicGistButton}

Edit Body Of File
    Set Focus To Element                 ${bodyTextField}
    Press Keys                           ${bodyTextField}               SPACE
    Input Text                           ${bodyTextField}               How are you?

Click Update Public Gist Button
    Click Button                         ${updatePublicGistButton}

User Can Update Public Gist Successfully
    Wait Until Page Contains Element     ${codeAndRevisionsTab}

Click Delete Button
    Wait Until Page Contains Element     ${deleteButton}
    Set Focus To Element                 ${deleteButton}
    Sleep                                1 seconds
    Click Element                        ${deleteButton}

Appear Dialog Confirmation Pop Up Then Click OK
    Handle Alert

User Can Delete Existing Public Gist Successfully
    Wait Until Page Contains Element     ${deleteSuccess}

Gist deleted successfully
    Wait Until Page Contains Element     ${deleteSuccess}

User Can See All List of Gists Page Successfully
    Wait Until Page Contains Element     ${listOfGists}

*** Test Cases ***

User Login GitHub
    Given Open GitHub Web
    When Click Sign In
    And Login With Valid Username
    And Login With Valid Password
    And Click Sign In Button
    Then Login Successfully

User create a public gist
    Given Create New Gist 
    When Write File Name
    And Write Body of File
    And Choose Create Public Gist
    And Click Create Public Gist Button
    Then User Can Create a Public Gist Successfully

User edit existing gist
    Given Click Edit Button
    When In Editing Page
    And Edit Body Of File
    And Click Update Public Gist Button
    Then User Can Update Public Gist Successfully

User delete existing gist
    Given Click Delete Button
    When Appear Dialog Confirmation Pop Up Then Click OK
    Then User Can Delete Existing Public Gist Successfully

User see all gist list
    Given Gist deleted successfully
    Then User Can See All List of Gists Page Successfully