SELECT papf.employee_number "Employee Number",

papf.title "Title",

papf.first_name "First Name",

papf.last_name "Last Name",

papf.date_of_birth,

hrlsex.meaning "Gender",

ppt.user_person_type ,

papf.national_identifier,

hrlnat.meaning "Nationality",

hrlms.meaning "Marital Status",

papf.email_address "E-mail",

TO_CHAR(papf.effective_start_date, 'DD-MON-RRRR') "Start Date",

TO_CHAR(papf.effective_end_date, 'DD-MON-RRRR') "End Date",

TO_CHAR(papf.original_date_of_hire, 'DD-MON-RRRR') "Hire Date",

pjobs.name "Job",

ppos.name "Position_Name",

pgrade.name "Employee_Grade",

haou.name "Employee_Organization",

pbus.name "Business Group",

hrlat.meaning "Address Type",

pad.address_line1 || CHR(10) || pad.address_line2 || CHR(10) ||

pad.address_line3 "Employee Address",

pad.postal_code ,

ftt.territory_short_name "Country_Name"

FROM per_all_people_f papf,

per_all_assignments_f paaf,

per_person_types_tl ppt,

hr_lookups hrlsex,

hr_lookups hrlnat,

hr_lookups hrlms,

hr_lookups hrleg,

hr_lookups hrlat,

per_jobs pjobs,

per_all_positions ppos,

per_addresses pad,

per_grades_tl pgrade,

per_business_groups pbus,

hr_all_organization_units haou,

fnd_territories_tl ftt

 WHERE 1 = 1

AND ftt.territory_code(+) = pad.country

AND pad.business_group_id(+) = papf.business_group_id

AND pad.date_to IS NULL

AND pad.person_id(+) = papf.person_id

AND pgrade.grade_id(+) = paaf.grade_id

AND haou.organization_id(+) = paaf.organization_id

AND haou.business_group_id(+) = paaf.business_group_id

AND pbus.business_group_id(+) = paaf.business_group_id

AND ppos.position_id(+) = paaf.position_id

AND pjobs.job_id(+) = paaf.job_id  AND ppt.person_type_id(+) = papf.person_type_id  AND paaf.effective_end_date >=sysdate

AND paaf.person_id = papf.person_id

AND paaf.effective_end_date >=sysdate