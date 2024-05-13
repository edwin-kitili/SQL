CREATE OR REPLACE PACKAGE EMP_DETAILS
AS
  PROCEDURE FETCH_DETAILS(employee_id IN NUMBER);
END EMP_DETAILS;
/

CREATE OR REPLACE PACKAGE BODY EMP_DETAILS
AS
  PROCEDURE FETCH_DETAILS(employee_id IN NUMBER)
  AS
    v_person_id per_all_people_f.person_id%TYPE;
    v_business_group_id per_all_people_f.business_group_id%TYPE;
    v_person_type_id per_all_people_f.person_type_id%TYPE;
    v_last_name per_all_people_f.last_name%TYPE;
    v_applicant_number per_all_people_f.applicant_number%TYPE;
    v_comment_id per_all_people_f.comment_id%TYPE;

    CURSOR c_employee IS
      SELECT person_id, business_group_id, person_type_id, last_name, applicant_number, comment_id
      FROM per_all_people_f
      WHERE person_id = employee_id; -- Use the appropriate column for filtering

  BEGIN
    OPEN c_employee;

    LOOP
      FETCH c_employee INTO v_person_id, v_business_group_id, v_person_type_id, v_last_name, v_applicant_number, v_comment_id;

      EXIT WHEN c_employee%NOTFOUND;

     /* DBMS_OUTPUT.PUT_LINE('Person ID: ' || v_person_id);
      DBMS_OUTPUT.PUT_LINE('Business Group ID: ' || v_business_group_id);
      DBMS_OUTPUT.PUT_LINE('Person Type ID: ' || v_person_type_id);
      DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_last_name);
      DBMS_OUTPUT.PUT_LINE('Applicant Number: ' || v_applicant_number);
      DBMS_OUTPUT.PUT_LINE('Comment ID: ' || v_comment_id);*/

      -- Uncomment the following lines if you want to print XML-like tags to FND_FILE
      
      FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '<FETCH_DETAILS>');
      FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '  <G_EMP_DETAILS>');
      FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '    <PERSON_ID>' || v_person_id || '</PERSON_ID>');
      FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '    <BUSINESS_GROUP_ID>' || v_business_group_id || '</BUSINESS_GROUP_ID>');
      FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '    <PERSON_TYPE_ID>' || v_person_type_id || '</PERSON_TYPE_ID>');
      FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '    <LAST_NAME>' || v_last_name || '</LAST_NAME>');
      FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '    <APPLICANT_NUMBER>' || v_applicant_number || '</APPLICANT_NUMBER>');
      FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '    <COMMENT_ID>' || v_comment_id || '</COMMENT_ID>');
      FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '  </G_EMP_DETAILS>');
      FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '</FETCH_DETAILS>');
      

    END LOOP;

    CLOSE c_employee;
  END FETCH_DETAILS;
END EMP_DETAILS;
/
