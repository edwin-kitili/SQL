select cash_receipt_id, created_by, creation_date, amount, type, receipt_number, status
from ar_cash_receipts_all acra
WHERE TYPE='MISC' 
AND acra.CASH_RECEIPT_ID=:P_CASH_RECEIPT_ID;

(SELECT CASH_RECEIPT_ID FROM ar_cash_receipts_all)