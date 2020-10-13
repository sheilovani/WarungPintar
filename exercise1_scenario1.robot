*** Settings ***
Library                                  SeleniumLibrary

*** Variables ***
${browser}                               Chrome
${eBayURL}                               https://www.ebay.com/
${shopByCategory}                        id:gh-shop-a
${cellphonesAndAccesories}               xpath://a[@href="https://www.ebay.com/b/Cell-Phones-Smart-Watches-Accessories/15032/bn_1865441"]
${cellPhonesAndSmartphones}              xpath://a[@href="https://www.ebay.com/b/Cell-Phones-Smartphones/9355/bn_320094"]
${moreRefinements}                       class:x-refine__main__list--more
# ---------- More Refinements Pop Up  ----------
${moreRefinementsPopUp}                  id:x-overlay__form
${screenSize}                            id:c3-mainPanel-Screen%20Size
${5inchSize}                             id:c3-subPanel-Screen%20Size_5.0%20-%205.4%20in_cbx
${price}                                 id:c3-mainPanel-price
${textRangePrice}                        id:c3-subPanel-_x-price-textrange
${inputMinPrice}                         css:#c3-subPanel-_x-price-textrange .x-textrange div .x-textrange__input--from
${inputMaxPrice}                         css:#c3-subPanel-_x-price-textrange .x-textrange div .x-textrange__input--to
${locationOptions}                       class:c3-subPanel
${itemLocation}                          id:c3-mainPanel-location
${radioButtonAsia}                       css:#c3-subPanel-location_Asia .x-refine__single-select-label .x-refine__single-select-radio
${applyButton}                           css:button.x-overlay-footer__apply-btn
# ---------- Verify Filter Tags Applied  ----------
${filterResult}                          5.0 - 5.4 Inch Cell Phones & Smartphones between IDR5,000,000.00 and IDR9,000,000.00
${amountResult}                          css:.srp-controls__row-cells .srp-controls__count .srp-controls__count-heading
${screenSizeFilterApplied}
${valueSizeChecked}
${PriceFilterApplied}
${minValuePriceApplied}
${itemLocationFilterApplied}
${selectedAsia}

*** Keywords ***
Open eBay website with Chrome
    Open Browser                         ${eBayURL}            ${browser}
    Maximize Browser Window

Click Shop by Category
    Click Element                        ${shopByCategory}

Choose Cell Phones & Accessories in Electronic Category
    Click Link                           ${cellphonesAndAccesories}
    Wait Until Page Contains             Cell Phones, Smart Watches & Accessories    timeout=10s

Choose Cell Phones and Smartphones
    Click Link                           ${cellPhonesAndSmartphones}
    Wait Until Page Contains             Cell Phones & Smartphones    timeout=10s

Scroll Page Until Find More Refinements and Click It
    Sleep                                1 seconds
    Scroll Element Into View             ${moreRefinements}
    Wait Until Element is visible        ${moreRefinements}      timeout=5s
    Set Focus To Element                 ${moreRefinements}
    Click Element                        ${moreRefinements}

View Refinement Filter Pop Up 
    Wait Until Element is visible        ${moreRefinementsPopUp}

Click Screen Size Filter
    Wait Until Element is visible        ${screenSize}           timeout=5s
    Click Element                        ${screenSize}

Checkbox 5.0 - 5.4 in
    Wait Until Element is visible        ${5inchSize}            timeout=5s
    Select Checkbox                      ${5inchSize}

Scroll Left Navigation Filter Bar Until Find Price and Click It
    Sleep                                1 seconds
    Scroll Element Into View             ${price}
    Wait Until Element is visible        ${price}                timeout=5s
    Set Focus To Element                 ${price}
    Click Element                        ${price}

Input Minimum Item Price Amount IDR 5000000
    Wait Until Page Contains Element     ${textRangePrice}
    Sleep                                1 seconds
    Click Element                        ${inputMinPrice}
    Input Text                           ${inputMinPrice}        5000000

Input Maximum Item Price Amount IDR 9000000
    Wait Until Page Contains Element     ${textRangePrice}
    Click Element                        ${inputMaxPrice}
    Input Text                           ${inputMaxPrice}        9000000

Scroll Left Navigation Filter Bar Until Find Item Location and Click It
    Sleep                                1 seconds
    Scroll Element Into View             ${itemLocation}
    Wait Until Element is visible        ${itemLocation}         timeout=5s
    Set Focus To Element                 ${itemLocation}
    Click Element                        ${itemLocation}

Choose Asia as Location
    Sleep                                1 seconds
    Click Button                         ${radioButtonAsia}    

Click Apply Button
    Click Element                        ${applyButton}

Search for Products by Applying Multiple Filters Has Been Successful
    Wait Until Page Contains             ${filterResult}
    Wait Until Element Contains          ${amountResult}                  1-18 of 41 Results
    Sleep                                1 seconds
    Scroll Element Into View             ${itemLocationFilterApplied}
    Wait Until Element is visible        ${valueSizeChecked}              timeout=5s
    Set Focus To Element                 ${valueSizeChecked}
    Checkbox Should Be Selected          ${valueSizeChecked}
    Wait Until Element is visible        ${minValuePriceApplied}          timeout=5s
    Wait Until Element is visible        ${selectedAsia}                  timeout=5s
    Set Focus To Element                 ${selectedAsia}
    Radio Button Should Be Set To        ${selectedAsia}                  value


*** Test Cases ***
Access a Product via category after applying multiple filters
    Given Open eBay website with Chrome
    When Click Shop by Category
    And Choose Cell Phones & Accessories in Electronic Category
    And Choose Cell Phones and Smartphones
    And Scroll Page Until Find More Refinements and Click It
    And View Refinement Filter Pop Up 
    And Click Screen Size Filter
    And Checkbox 5.0 - 5.4 in
    And Scroll Left Navigation Filter Bar Until Find Price and Click It
    And Input Minimum Item Price Amount IDR 5000000
    And Input Maximum Item Price Amount IDR 9000000
    And Scroll Left Navigation Filter Bar Until Find Item Location and Click It
    And Choose Asia as Location
    And Click Apply Button
    Then Search for Products by Applying Multiple Filters Has Been Successful