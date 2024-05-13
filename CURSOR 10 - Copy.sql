
SELECT * FROM per_all_people_f;

SELECT person_id, business_group_id, person_type_id, last_name, applicant_number, comment_id 
FROM per_all_people_f;


DECLARE
  
  v_person_id per_all_people_f.person_id%TYPE;
  v_business_group_id per_all_people_f.business_group_id%TYPE;
  v_person_type_id per_all_people_f.person_type_id%TYPE;
  v_last_name per_all_people_f.last_name%TYPE;
  v_applicant_number per_all_people_f.applicant_number%TYPE;
  v_comment_id per_all_people_f.comment_id%TYPE;

 
  CURSOR c_employee IS
    SELECT person_id, business_group_id, person_type_id, last_name, applicant_number, comment_id
    FROM per_all_people_f;

BEGIN

  OPEN c_employee;

  
  LOOP
    FETCH c_employee INTO v_person_id, v_business_group_id, v_person_type_id, v_last_name, v_applicant_number, v_comment_id;
    
   
    EXIT WHEN c_employee%NOTFOUND;
    
   

  END LOOP;

  
  CLOSE c_employee;

END;
/
