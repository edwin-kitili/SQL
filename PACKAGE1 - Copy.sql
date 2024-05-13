CREATE OR REPLACE PACKAGE get_staff_details AS
 p_person_id per_all_people_f.person_id%type;
  p_business_group_id per_all_people_f.business_group_id%type;
  p_person_type_id per_all_people_f.person_type_id%type;
  p_last_name per_all_people_f.last_name%type;

  CURSOR P_EMPLOYEE_DETAILS IS
    SELECT person_id, business_group_id, person_type_id, last_name
    FROM per_all_people_f;

  employee_rec P_EMPLOYEE_DETAILS%rowtype;

END get_staff_details;

CREATE OR REPLACE PACKAGE BODY get_staff_details AS

BEGIN
OPEN P_EMPLOYEE_DETAILS;
  LOOP
    FETCH P_EMPLOYEE_DETAILS INTO employee_rec;
    EXIT WHEN P_EMPLOYEE_DETAILS%notfound;
    dbms_output.put_line('person_id: ' || employee_rec.person_id ||
                         ', business_group_id: ' || employee_rec.business_group_id ||
                         ', person_type_id: ' || employee_rec.person_type_id ||
                         ', last_name: ' || employee_rec.last_name);
  END LOOP;
  CLOSE P_EMPLOYEE_DETAILS;
  
  END;