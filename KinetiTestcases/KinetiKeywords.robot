*** Settings ***
Library  SeleniumLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***

${ContexturesURL}   https://contextures.com/xlsampledata01.html#data
${ContexturesURL_Download}      https://contextures.com/xlsampledata01.html
${CookiesFrame}     //iframe[contains(@class,'faktor-iframe-wrapper')]
${AcceptCookies}    //*[text()='Accept All']

${OfficeSupplyTable}    (//tbody)[1]
${SampleDataTableLink}  //a[normalize-space()='Sample Data - Office Supply Sales Table']
${DownloadSampleDataTableURL}   //a[@href='#download'][contains(.,'Download the Sample Data')]
${counter}=     ${1}
${max_num}  Set Variable  50
${OfficeSupplyDownloadLink}     //a[@href='SampleData.zip'][contains(.,'Office Suply Sales sample data workbook')]

*** Keywords ***

SampleDataTable
    Open Browser    ${ContexturesURL}   chrome
    Sleep   2
    Maximize Browser window
    Sleep   4
    Select Frame    ${CookiesFrame}
    Click Element   ${AcceptCookies}
    Click Element   ${SampleDataTableLink}

SampleDataTableDownload
    Open Browser    ${ContexturesURL_Download}   chrome
    Sleep   2
    Maximize Browser window
    Sleep   4
    Select Frame    ${CookiesFrame}
    Click Element   ${AcceptCookies}

TableParsed
    Page Should Contain Element     ${OfficeSupplyTable}

Find Different Items Sold in the Office Supply
    Count Pencil
    Count Binders
    Count Pen
    Count PenSet
    Count Desk

Count Pencil
      ${ItemColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[4]
      FOR  ${colIndex}  IN RANGE     4      ${ItemColumn} + 1
            ${curText}      Get Text     //table[@border='1']/tbody/tr[${colIndex}]/td[4]
            IF     "${curText}" == "Pencil"
                    ${counter}=  set variable  ${counter+0}
                    ${counter}=  evaluate  ${counter} + 1
             END
    END
    Log To Console     ${counter} times Pencils are sold

Count Binders
      ${ItemColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[4]
      FOR  ${colIndex}  IN RANGE     4      ${ItemColumn} + 1
            ${curText}      Get Text     //table[@border='1']/tbody/tr[${colIndex}]/td[4]
            IF     "${curText}" == "Binder"
                    ${counter}=  set variable  ${counter+0}
                    ${counter}=  evaluate  ${counter} + 1
             END
    END
    Log To Console     ${counter} times Binders are sold

Count Pen
    ${ItemColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[4]
      FOR  ${colIndex}  IN RANGE     4      ${ItemColumn} + 1
            ${curText}      Get Text     //table[@border='1']/tbody/tr[${colIndex}]/td[4]
            IF     "${curText}" == "Pen"
                    ${counter}=  set variable  ${counter+0}
                    ${counter}=  evaluate  ${counter} + 1
             END
    END
    Log To Console     ${counter} times Pens are sold

Count PenSet
    ${ItemColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[4]
      FOR  ${colIndex}  IN RANGE     4      ${ItemColumn} + 1
            ${curText}      Get Text     //table[@border='1']/tbody/tr[${colIndex}]/td[4]
            IF     "${curText}" == "Pen Set"
                    ${counter}=  set variable  ${counter+0}
                    ${counter}=  evaluate  ${counter} + 1
             END
    END
    Log To Console     ${counter} times Pen Set are sold

Count Desk
    ${ItemColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[4]
      FOR  ${colIndex}  IN RANGE     4      ${ItemColumn} + 1
            ${curText}      Get Text     //table[@border='1']/tbody/tr[${colIndex}]/td[4]
            IF     "${curText}" == "Desk"
                    ${counter}=  set variable  ${counter+0}
                    ${counter}=  evaluate  ${counter} + 1
             END
    END
    Log To Console     ${counter} times Desks are sold

Find Item sold Less than 5 units
    ${ItemColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[4]
    ${UnitColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[5]
      FOR  ${colIndex}  IN RANGE     4      ${UnitColumn} + 1
            ${Unit}      Get Text     //table[@border='1']/tbody/tr[${colIndex}]/td[5]
            IF  ${Unit} < 5
                ${Itemwithlessthan5units}   Get Text    //table[@border='1']/tbody/tr[${colIndex}]/td[4]
                ${OrderDate}    Get Text    //table[@border='1']/tbody/tr[${colIndex}]/td[1]
                Log To Console      ${Itemwithlessthan5units} has ${Unit} Units sold on ${OrderDate}
            END
      END

Find if Pencil sold less than 5 units
    ${ItemColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[4]
    ${UnitColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[5]
      FOR  ${colIndex}  IN RANGE     4      ${UnitColumn} + 1
            ${curText}      Get Text     //table[@border='1']/tbody/tr[${colIndex}]/td[4]
            ${Unit}      Get Text     //table[@border='1']/tbody/tr[${colIndex}]/td[5]
            IF  "${curText}" == "Pencil" and ${Unit} < 5
                ${Itemwithlessthan5units}   Get Text    //table[@border='1']/tbody/tr[${colIndex}]/td[4]
                Log To Console     ${Itemwithlessthan5units} units of Pencil orders found
            END
      END

Find Expensive Item
    @{list_to_populate}  Create List
    ${ItemColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[4]
    ${UnitColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[5]
    ${UnitCostColumn}   Get Element Count   //table[@border='1']/tbody/tr/td[6]
      FOR  ${colIndex}  IN RANGE     4      ${UnitCostColumn} + 1
            ${UnitCost}     Get Text    //table[@border='1']/tbody/tr[${colIndex}]/td[6]
            Append To List  ${list_to_populate}  ${UnitCost}
    END
    Log Many  @{list_to_populate}
    ${sorted}=    Evaluate     sorted(${list_to_populate}, key=float, reverse=True)
    Log To Console       ${sorted}[0]
      FOR  ${colIndex}  IN RANGE     4      ${UnitCostColumn} + 1
        ${curText}      Get Text     //table[@border='1']/tbody/tr[${colIndex}]/td[4]
        ${UnitCost}     Get Text    //table[@border='1']/tbody/tr[${colIndex}]/td[6]
        IF  ${UnitCost} == ${sorted}[0]
            ${ExpensiveItem}   Get Text    //table[@border='1']/tbody/tr[${colIndex}]/td[4]
            Log To Console      ExpensiveItem : ${ExpensiveItem} has ${UnitCost} unitcost
        END
      END

LinkToDownloadFound
    Execute JavaScript    window.scrollTo(808,344)
    Wait Until Page Contains Element    ${DownloadSampleDataTableURL}
   # Page Should Contain     //a[@href='#download'][contains(.,'Download the Sample Data')]
    Click Link      ${DownloadSampleDataTableURL}

Download Excel
    Page Should Contain Element     ${OfficeSupplyDownloadLink}
    Click Link      ${OfficeSupplyDownloadLink}


