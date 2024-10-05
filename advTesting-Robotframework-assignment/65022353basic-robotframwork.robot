*** Settings ***
Documentation     Basic AI-aided with Robot Framework - Assignment 10 คะแนน (7 ตค 2567)
Library           SeleniumLibrary
Library           BuiltIn

Suite Setup       Open Browser    https://test.k6.io/browser.php    chrome
Suite Teardown    Close Browser


*** Variables ***
${NO_INTERACTION}        No interaction
# Checkbox
${CHECKED_MESSAGE}       Thanks for checking the box
${UNCHECKED_MESSAGE}     You've just unchecked the box
# Input text
${FOCUSED_INPUT_TEXT}    focused on input text field
${FILLING_INPUT_TEXT}    Thanks for filling in the input text field
${REMOVED_INPUT_TEXT}    You've just removed everything from the input text field
# Selectbox
${NOTHING_SELECTED}      Nothing selected
${SELECTED_ZERO}         Selected: zero

#
*** Keywords ***
# TC01
Get CHECKBOX-INFO
  ${checkbox_info}    Get Text    id=checkbox-info-display
  [Return]    ${checkbox_info}

Click CHECKBOX-INFO
  Click Element    id=checkbox1

# TC02
Click for INCREMENT ELEMENT COUNTER
  Click Element    id=counter-button

Get+Log COUNTER INFO DISPLAY
  ${counter_info}    Get Text    id=counter-info-display
  Log To Console    ${counter_info}

# TC03
Get TEXT INPUT INFO
  ${text_input_info}    Get Text    id=text-info-display
  [Return]    ${text_input_info}

Click TEXT INPUT
  Click Element    id=text1

# TC04
Get SELECTBOX INFO
  ${selected_box}    Get Text    id=select-multiple-info-display
  [Return]    ${selected_box}

Click NUMBERS-OPIONS ZERO
  Click Element    //*[@id="numbers-options"]/option[1]

#
*** Test Cases ***
TC01 Check Checkbox Text In Element
  # ตรวจสอบข้อความเริ่มต้นว่าคือ "No interaction"
  ${checkbox_info}=    Get CHECKBOX-INFO
  Log To Console    before Checking the box: "${checkbox_info}"
  Should Be Equal    ${checkbox_info}    ${NO_INTERACTION}

  # คลิกที่ checkbox และตรวจสอบข้อความว่า "Thanks for checking the box"
  Click CHECKBOX-INFO
  ${checkbox_info}=    Get CHECKBOX-INFO
  Log To Console    after Checking the box: "${checkbox_info}"
  Should Be Equal    ${checkbox_info}    ${CHECKED_MESSAGE}

  # คลิกที่ checkbox อีกครั้งและตรวจสอบข้อความว่า "You've just unchecked the box"
  Click CHECKBOX-INFO
  ${checkbox_info}=    Get CHECKBOX-INFO
  Log To Console    after Unchecking the box: "${checkbox_info}"
  Should Be Equal    ${checkbox_info}    ${UNCHECKED_MESSAGE}

#
TC02 Check Increment Click
  Capture Page Screenshot    beforeIncrement.png   #Capture Page Screenshot
  Click for INCREMENT ELEMENT COUNTER
  Get+Log COUNTER INFO DISPLAY
  Capture Page Screenshot    afterIncrement.png    #Capture Page Screenshot
  
TC03 Input Text
  ${text_input_info}=    Get TEXT INPUT INFO
  Log To Console    before Focusing input-text: "${text_input_info}"
  Should Be Equal    ${text_input_info}    ${NO_INTERACTION}

  Click TEXT INPUT
  ${text_input_info}=    Get TEXT INPUT INFO
  Log To Console    after Focusing input-text: "${text_input_info}"
  Should Be Equal    ${text_input_info}    ${FOCUSED_INPUT_TEXT}

  Input Text    id=text1    1234
  ${text_input_info}=    Get TEXT INPUT INFO
  Log To Console    after Filling input-text: "${text_input_info}"
  Should Be Equal    ${text_input_info}    ${FILLING_INPUT_TEXT}

  Click TEXT INPUT
  FOR    ${index}    IN RANGE    4
      Press Keys    id=text1    BACKSPACE
      
  END
  ${text_input_info}=    Get TEXT INPUT INFO
  Log To Console    after Removing all input-text: "${text_input_info}"
  Should Be Equal    ${text_input_info}    ${REMOVED_INPUT_TEXT}

TC04 Selectbox
  ${selected_box}=    Get SELECTBOX INFO
  Log To Console    before Selecting-option: "${selected_box}"
  Should Be Equal    ${selected_box}    ${NOTHING_SELECTED}

  Click NUMBERS-OPIONS ZERO 
  ${selected_box}=    Get SELECTBOX INFO
  Log To Console    after Selecting-option: "${selected_box}"
  Should Be Equal    ${selected_box}    ${SELECTED_ZERO}