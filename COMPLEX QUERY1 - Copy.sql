select 
       ooha.order_number,
       ooha.org_id,
       hca.account_name,
       hp.party_name,
       hcasab.orig_system_reference,
       hpsb.status
       
from 
       oe_order_headers_all ooha,
       hz_cust_accounts hca,
       hz_parties hp,
       hz_cust_acct_sites_all hcasab,
       hz_party_sites hpsb
       
where 
        ooha.PROGRAM_ID(+)=hp.PROGRAM_ID
    and ooha.org_id(+)=hca.org_id
    --and hca.party_id=hp.party_id
    and hca.CUST_ACCOUNT_ID=hcasab.CUST_ACCOUNT_ID
    --and ooha.program_id=41819
    and hcasab.PARTY_SITE_ID=hpsb.PARTY_SITE_ID;


--select  DISTINCT PROGRAM_ID from hz_cust_acct_sites_all;
