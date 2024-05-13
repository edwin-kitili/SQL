SELECT 
    aia.invoice_num,     
    aia.ORG_ID,
    aia.invoice_currency_code,
    DECODE(aia.PAYMENT_STATUS_FLAG, 'N', 'UN-PAID', 'P', 'Partial Paid', 'Y', 'PAID') AS PAYMENT_STATUS_FLAG,
    aia.invoice_date,
    aps.vendor_name,
    apss.vendor_site_code,
    aila.line_number,
    aia.invoice_amount,
    aila.amount AS line_amount,
    pha.segment1 AS po_number,
    aila.line_type_lookup_code,
    apt.name AS Term_name,     
    aca.check_number,
    aipa.amount AS payment_amount,
    apsa.amount_remaining,
    aipa.invoice_payment_type,
    hou.name AS operating_unit,
    gl.name AS ledger_name  
FROM 
    apps.ap_invoices_all aia,
    ap_invoice_lines_all aila,
    ap_invoice_distributions_all aida,
    ap_suppliers aps,
    ap_supplier_sites_all apss,
    po_headers_all pha,
    ap_invoice_payments_all aipa,
    ap_checks_all aca,
    ap_payment_schedules_all apsa,
    ap_terms apt,
    hr_operating_units hou,
    gl_ledgers gl
WHERE 
    aia.INVOICE_ID = aila.INVOICE_ID
    AND aila.ORG_ID = aida.ORG_ID
    AND aida.REQUEST_ID = aps.REQUEST_ID
    AND aps.VENDOR_SITE_ID = apss.VENDOR_SITE_ID
    AND aps.VENDOR_ID = pha.VENDOR_ID
    AND pha.ORG_ID = aipa.ORG_ID
    AND aipa.CHECK_DATE = aca.CHECK_DATE
    AND aca.CHECKRUN_ID = apsa.CHECKRUN_ID
    --AND apt.TERM_ID = aia.TERM_ID
    and hou.NAME=aia.NAME
    --and hou.NAME=gl.NAME
    AND hou.NAME = apt.NAME
    and apt.NAME=gl.NAME;
    --AND hou.NAME = gl.NAME; -- Adjust join conditions as per your schema
