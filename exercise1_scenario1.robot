*** Settings ***
Library                                  SeleniumLibrary
# Library                         Selenium2Library

*** Variables ***
${browser}                               Chrome
${eBayURL}                               https://www.ebay.com/
${shopByCategory}                        id:gh-shop-a
${cellphonesAndAccesories}               xpath://a[@href="https://www.ebay.com/b/Cell-Phones-Smart-Watches-Accessories/15032/bn_1865441"]
${cellPhonesAndSmartphones}              xpath://a[@href="https://www.ebay.com/b/Cell-Phones-Smartphones/9355/bn_320094"]
${moreRefinements}                       class:x-refine__main__list--more
${moreRefinementsPopUp}                  id:x-overlay__form
${screenSize}                            id:c3-mainPanel-Screen%20Size
${5inchSize}                             id:c3-subPanel-Screen%20Size_5.0%20-%205.4%20in_cbx
${price}                                 id:c3-mainPanel-price
${textRangePrice}                        xpath://div[@class="x-textrange"]
${inputMinPrice}                         xpath://div[@class="x-textrange__input--from"]last()
${inputMaxPrice}                         xpath://div/div/div[@class="x-textrange__input--to"]

*** Keywords ***
Open eBay website with Chrome
    Open Browser                         ${eBayURL}            ${browser}
    Maximize Browser Window

Click Shop by Category
    Click Element                        ${shopByCategory}

Choose Cell Phones & Accessories in Electronic category
    Click Link                           ${cellphonesAndAccesories}
    Wait Until Page Contains             Cell Phones, Smart Watches & Accessories    timeout=10s

Choose Cell Phones and Smartphones
    Click Link                           ${cellPhonesAndSmartphones}
    Wait Until Page Contains             Cell Phones & Smartphones    timeout=10s

Scroll page until find More Refinements and Click It
    Sleep                                1 seconds
    Scroll Element Into View             ${moreRefinements}
    Wait Until Element is visible        ${moreRefinements}     timeout=5s
    Set Focus To Element                 ${moreRefinements}
    Click Element                        ${moreRefinements}

View Refinement Filter Pop Up 
    Wait Until Element is visible        ${moreRefinementsPopUp}

Click Screen Size filter
    Wait Until Element is visible        ${screenSize}     timeout=5s
    Click Element                        ${screenSize}

Checkbox 5.0 - 5.4 in
    Wait Until Element is visible        ${5inchSize}     timeout=5s
    Select Checkbox                      ${5inchSize}

Scroll left navigation bar until find Price and Click It
    Sleep                                1 seconds
    Scroll Element Into View             ${price}
    Wait Until Element is visible        ${price}     timeout=5s
    Set Focus To Element                 ${price}
    Click Element                        ${price}

Input Minimum Item Price
    Wait Until Page Contains Element     ${textRangePrice}
    Sleep                                1 seconds
    Click Element                        ${inputMinPrice}
    Input Text                           ${inputMinPrice}        5000000

Input Maximum Item Price
    Wait Until Page Contains Element     ${textRangePrice}
    Click Element                        ${inputMaxPrice}
    Input Text                           ${inputMaxPrice}        7000000


*** Test Cases ***
Access a Product via category after applying multiple filters
    Open eBay website with Chrome
    Click Shop by Category
    Choose Cell Phones & Accessories in Electronic category
    Choose Cell Phones and Smartphones
    Scroll page until find More Refinements and Click It
    View Refinement Filter Pop Up 
    Click Screen Size filter
    Checkbox 5.0 - 5.4 in
    Scroll left navigation bar until find Price and Click It
    Input Minimum Item Price
    Input Maximum Item Price