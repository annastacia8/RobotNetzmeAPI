*** Settings ***
Documentation    RefundPartial
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary
Library    JsonValidator
Library     DateTime
Library     /Users/annastaciapriyatna/pythonProject/TestCases/UUID_Gen.py
*** Variables ***
${base_url}=    https://tokoapi-stg.netzme.com/api/merchant/qr/refund


*** Keywords ***
Get UUID From Python
    ${UUID}=      get Uuid
    Set Global Variable         ${GLOBALUUID}      ${UUID}


*** Test Cases ***
Refund_Partial
    Get UUID From Python
    log to console      ${GLOBALUUID}
    create session  mysession   ${base_url}     verify=true
    ${body2}=   Create Dictionary    amount=IDR 500.00     merchantId=M_pXAFWzCg   transactionId=7433970885
    ${body}=    Create Dictionary   body=${body2}    requestId=${GLOBALUUID}  requestTime=${None}    type=refund_qris
    ${headers}=     Create Dictionary    Content-Type=application/json     Authorization=Basic dG9rb2thcmU6YzRmOTZiZmRhOGQ5ZDVhMDgxNmU1MWE5M2JkZWNjNWU=
    ${response}=    Post Request    mysession      /partial     data=${body}    headers=${headers}
    log to console      ${response.status_code}
    log to console      ${response.content}

   #${json_value}  Get Json Value  ${resp}
    &{JSON}=    Evaluate    json.loads("""${response.content}""")    json
    ${status}=  Set Variable  ${JSON['status']}


Refund_Partial_Merchant_id_not_found
    create session  mysession   ${base_url}     verify=true
    ${body2}=   Create Dictionary    amount=IDR 500.00     merchantId=pXAFWzCg   transactionId=2465384687
    ${body}=    Create Dictionary   body=${body2}    requestId=2017c151-fd28-40e5-b530-5386cd642373  requestTime=${None}    type=refund_qris
    ${headers}=     Create Dictionary    Content-Type=application/json     Authorization=Basic dG9rb2thcmU6YzRmOTZiZmRhOGQ5ZDVhMDgxNmU1MWE5M2JkZWNjNWU=
    ${response}=    Post Request    mysession      /refund     data=${body}    headers=${headers}
    log to console      ${response.status_code}
    log to console      ${response.content}


Refund_Partial_exceed_the_amount
    create session  mysession   ${base_url}     verify=true
    ${body2}=   Create Dictionary    amount=IDR 90000.00     merchantId=pXAFWzCg   transactionId=2465384687
    ${body}=    Create Dictionary   body=${body2}    requestId=601e14dc-b189-4811-b380-43ad7ed11cc4  requestTime=${None}    type=refund_qris
    ${headers}=     Create Dictionary    Content-Type=application/json     Authorization=Basic dG9rb2thcmU6YzRmOTZiZmRhOGQ5ZDVhMDgxNmU1MWE5M2JkZWNjNWU=
    ${response}=    Post Request    mysession      /refund     data=${body}    headers=${headers}
    log to console      ${response.status_code}
    log to console      ${response.content}

