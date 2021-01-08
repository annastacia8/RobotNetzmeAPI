*** Settings ***
Documentation    PaymentQris
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary
Library     JsonValidator
Library     DateTime
Library     /Users/annastaciapriyatna/pythonProject/TestCases/hmac_gen.py

*** Variables ***
${base_url}=    https://tokoapi-stg.netzme.com/qr/payment
${body}=        Create Dictionary   pan=9360081401000000415   processingCode=260000   transactionAmount=4000     transmissionDateTime=20200924160000     systemTraceAuditNumber=123456       localTransactionDateTime=20200924160000     settlementDate=20202210     captureDate=20202210    merchantType=8111      posEntryMode=011     feeType=C   feeAmount=0     acquirerId=93600814      issuerId=93600161       forwardingId=008    rrn=99905530098433     approvalCode=121212     terminalId=123456       merchantId=4sActhBS     merchantName=Kreasi maju       merchantCity=Jakarta Selatan       merchantCountry=62   productIndicator=Q001   customerData=Yuhu    merchantCriteria=URE     currencyCode=360    postalCode=12910    additionalField=${none}     customerPan=9360016187569790
*** Keywords ***
Get HMAC From Python
    ${HMAC}=      Get Hmac
    ...         ${body}
    Set Global Variable         ${GLOBALHMAC}      ${HMAC}
*** Test Cases ***
PaymentQris
    Get HMAC From Python
    log to console      ${GLOBALHMAC}
    create session  mysession   ${base_url}     verify=true
    ${headers}=     Create dictionary   mac=${GLOBALHMAC}    Content-Type=application/json
    ${response}=    Post Request    mysession      /payment     data=${body}    headers=${headers}
    log to console      ${response.status_code}
    log to console      ${response.content}