SELECT acra.RECEIPT_NUMBER,
       acra.DOC_SEQUENCE_VALUE,
       ACRA.RECEIPT_DATE,
       ACRA.COMMENTS,
       ACRA.amount,
       ARAA.AMOUNT_APPLIED,
       rcta.TRX_NUMBER,
       araa.gl_date            Receipt_applied_gl_date,
       acrha.GL_Date,
       BB.BANK_NAME            REMIT_BANK_NAME,
       BB.BANK_BRANCH_NAME     REMIT_BANK_BRANCH
  FROM AR_CASH_RECEIPTS_ALL            acra,
       AR_CASH_RECEIPT_HISTORY_ALL     acrha,
       AR_RECEIVABLE_APPLICATIONS_ALL  araa,
       RA_CUSTOMER_TRX_ALL             rcta,
       HZ_CUST_SITE_USES_ALL           HCSUA,
       CE_BANK_ACCOUNTS                CBA,
       CE_BANK_ACCT_USES_OU            REMIT_BANK,
       CE_BANK_BRANCHES_V              BB
 WHERE     acrha.CASH_RECEIPT_ID = acra.CASH_RECEIPT_ID
       AND acrha.CASH_RECEIPT_HISTORY_ID = araa.CASH_RECEIPT_HISTORY_ID(+)
       AND acrha.CASH_RECEIPT_ID = araa.CASH_RECEIPT_ID(+)
       AND araa.display = 'Y'
       AND rcta.CUSTOMER_TRX_ID(+) = araa.APPLIED_CUSTOMER_TRX_ID
       AND rcta.BILL_TO_SITE_USE_ID = HCSUA.SITE_USE_ID(+)
       AND REMIT_BANK.BANK_ACCT_USE_ID(+) = acra.REMIT_BANK_ACCT_USE_ID
       AND REMIT_BANK.ORG_ID(+) = acra.ORG_ID
       AND remit_bank.bank_account_id = CBA.bank_account_id(+)
       AND BB.BRANCH_PARTY_ID(+) = CBA.BANK_BRANCH_ID
       AND acra.TYPE <> 'MISC'
       AND acrha.GL_Date between NVL(:P_GL_START_DATE, acrha.GL_Date) AND NVL(:P_GL_END_DATE, acrha.GL_Date)

        
--Miscellaneous Receipt
UNION ALL
SELECT acra.RECEIPT_NUMBER,
       acra.DOC_SEQUENCE_VALUE,
       ACRA.RECEIPT_DATE,
       ACRA.COMMENTS,
       ACRA.amount,
       NULL                    AMOUNT_APPLIED,
       NULL                    TRX_NUMBER,
       NULL                    Receipt_applied_gl_date,
       acrha.GL_Date,
       BB.BANK_NAME            REMIT_BANK_NAME,
       BB.BANK_BRANCH_NAME     REMIT_BANK_BRANCH
  FROM AR_CASH_RECEIPTS_ALL         acra,
       AR_CASH_RECEIPT_HISTORY_ALL  acrha
        --       ,AR_RECEIVABLE_APPLICATIONS_ALL  araa
        --       ,RA_CUSTOMER_TRX_ALL             rcta
        --       ,HZ_CUST_SITE_USES_ALL           HCSUA,
                                         ,
       CE_BANK_ACCOUNTS             CBA,
       CE_BANK_ACCT_USES_OU         REMIT_BANK,
       CE_BANK_BRANCHES_V           BB
 WHERE     acrha.CASH_RECEIPT_ID = acra.CASH_RECEIPT_ID
       --       AND acrha.CASH_RECEIPT_HISTORY_ID = araa.CASH_RECEIPT_HISTORY_ID(+)
       --       AND acrha.CASH_RECEIPT_ID = araa.CASH_RECEIPT_ID(+)
       --       and araa.display = 'Y'
       --       AND rcta.CUSTOMER_TRX_ID(+) = araa.APPLIED_CUSTOMER_TRX_ID
       --       AND rcta.BILL_TO_SITE_USE_ID = HCSUA.SITE_USE_ID(+)
       AND REMIT_BANK.BANK_ACCT_USE_ID(+) = acra.REMIT_BANK_ACCT_USE_ID
       AND REMIT_BANK.ORG_ID(+) = acra.ORG_ID
       AND remit_bank.bank_account_id = CBA.bank_account_id(+)
       AND BB.BRANCH_PARTY_ID(+) = CBA.BANK_BRANCH_ID
       AND acra.TYPE = 'MISC'
       AND acrha.GL_Date between NVL(:P_GL_START_DATE, acrha.GL_Date) AND NVL(:P_GL_END_DATE, acrha.GL_Date)
       --AND acra.RECEIPT_DATE=:P_receipt_date
ORDER BY RECEIPT_NUMBER DESC;