select 
    aia.invoice_num,     
    aia.ORG_ID,
    aia.invoice_currency_code,
    DECODE(aia.PAYMENT_STATUS_FLAG,'N','UN-PAID','P','Partial Paid','Y','PAID') PAYMENT_STATUS_FLAG ,
    aia.invoice_date,
    aps.vendor_name,
    apss.vendor_site_code,
    aila.line_number,
    aia.invoice_amount,
    aila.amount line_amount,
    pha.segment1 po_number,
    aila.line_type_lookup_code,
    apt.name Term_name,     
    gcc.concatenated_segments distributed_code_combinations,
    aca.check_number,
    aipa.amount payment_amount,
    apsa.amount_remaining,
    aipa.invoice_payment_type,
    hou.name operating_unit,
    gl.name ledger_name  
from 
    apps.ap_invoices_all aia,
    ap_invoice_lines_all aila,
    ap_invoice_distributions_all aida,
    ap_suppliers aps,
    ap_supplier_sites_all apss,
    po_headers_all pha,
    gl_code_combinations_kfv gcc,
    ap_invoice_payments_all aipa,
    ap_checks_all aca,
    ap_payment_schedules_all apsa,
    ap_terms apt,
    hr_operating_units hou,
    gl_ledgers gl
where
    aia.invoice_id = aila.invoice_id
    and aila.invoice_distribution_id = aida.invoice_distribution_id -- add this line
    and aia.vendor_id = aps.vendor_id
    and aps.vendor_id = apss.vendor_id
    and aia.po_header_id = pha.po_header_id
    and aida.code_combination_id = gcc.code_combination_id
    and aipa.check_id = aca.check_id
    and apsa.term_id = apt.term_id
    and aia.org_id = hou.organization_id
    and gcc.ledger_id = gl.ledger_id;
    --and aia.payment_schedule_id = apsa.payment_schedule_id;
    --and aia.payment_id = aipa.payment_id;
