select * from per_all_people_f;
DECLARE
v_person_id per_all_people_f.person_id%type;
v_person_type_id per_all_people_f.person_type_id%type;
v_last_name per_all_people_f.last_name%type;
v_applicant_number per_all_people_f.applicant_number%type;

CURSOR C_emp_details is
SELECT person_id,person_type_id,last_name,applicant_number FROM per_all_people_f;
BEGIN
OPEN C_emp_details;
LOOP
FETCH C_emp_details into v_person_id,v_person_type_id,v_last_name,v_applicant_number;
EXIT WHEN C_emp_details%NOTFOUND;
END LOOP;
CLOSE C_emp_details;
END;
/


CREATE OR REPLACE PROCEDURE EM_RECORDS 
AS
BEGIN
 UPDATE per_all_people_f
 SET person_id= 12345
 where person_id = '381';
 
 END;
/