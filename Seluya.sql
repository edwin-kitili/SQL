SELECT DISTINCT
       -- :to_trx_date,
        to_number(papf.employee_number)                                                                                             employee_number    ,
        papf.full_name                                                                                                              employee_name      ,
        TO_CHAR (papf.date_of_birth, 'DD-MON-YYYY')                                                                                       dob                ,
        --TO_CHAR (papf.effective_start_date, 'DD-MON-YYYY') start_date,
        DECODE (papf.sex, 'F', 'Female', 'M', 'Male', 'Other')                                                                      gender             ,
        DECODE (papf.REGISTERED_DISABLED_FLAG, 'Y', 'Yes', 'N', 'No', 'F', 'Yes - Fully Disabled', 'P', 'Yes - Partially Disabled') disability         ,
        pj.NAME                                                                                                                     job                ,
        pg.NAME                                                                                                                     grade              ,
        hr.meaning                                                                                                                  terms_of_ser       ,
        pp.NAME                                                                                                                     designation        ,
        papf.attribute13                                                                                                            ethnic_community   ,
        papf.start_date                                                                                                             date_of_appointment,
        pqv.NAME                                                                                                                    high_qualification ,
        pq.title                                                                                                                    professional_qual  ,
        NVL (ppe.period_years, 0) + ROUND ( (SYSDATE - papf.start_date) / 365, 1)                                                   yrs_of_exp         ,
        papf.national_identifier                                                                                                                       ,
        papf.attribute10 AS nssf_num                                                                                                                   ,
        papf.attribute11 AS nhif_num                                                                                                                   ,
        papf.attribute12 AS kra_pin
FROM
        per_all_people_f       papf,
        per_all_assignments_f  paa ,
        per_jobs               pj  ,
        per_grades             pg  ,
        per_positions          pp  ,
        hr_lookups             hl  ,
        per_addresses          pa  ,
        per_phones             ph  ,
        per_qualifications_v   pqv ,
        per_previous_employers ppe ,
        per_qualifications     pq  ,
        hr_lookups             hr
        
        where papf.business_group_id = paa.business_group_id
        and paa.job_id = pj.job_id
        and pj.business_group_id = pg.business_group_id
        and pg.business_group_id = pp.business_group_id
        and pp.date_effective = hl.last_update_date
        and hl.last_updated_by = pa.created_by
        and pa.party_id = ph.party_id
        and hl.meaning = pqv.status_meaning
        and pa.address_line1 = ppe.employer_address
        and pq.title = pqv.title
        and hl.lookup_type = hr.lookup_type;