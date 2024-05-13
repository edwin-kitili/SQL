SELECT
  last_updated_date ar,
  created_by ar,
  amount ar,
  cash_receipt_id arc,
  status arc,
  bank_account_num ba,
  bank_branch_id ba,
  bank_id ba
  
  

FROM 
  AR_CASH_RECEIPTS_ALL ar,
  AR_CASH_RECEIPT_HISTORY_ALL arc,
  CE_BANK_ACCOUNTS ba;