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
        where 
         pa.person_id(+) = papf.person_id
AND hl.lookup_code(+) = papf.sex
AND hr.lookup_code(+) = papf.nationality
AND paa.person_id = papf.person_id  
AND paa.effective_end_date >=sysdate
AND paa.person_id = papf.person_id
AND pp.position_id(+) = paa.position_id
AND pj.job_id(+) = papf.job_id;
