DECLARE
  C_PERSON per_people_f.PERSON_ID%TYPE;
  C_TYPE per_people_f.PERSON_TYPE_ID%TYPE;
  C_LAST per_people_f.LAST_NAME%TYPE;
  
  CURSOR C_per_people_f IS 
    SELECT PERSON_ID, PERSON_TYPE_ID, LAST_NAME 
    FROM per_people_f;
BEGIN
  OPEN C_per_people_f;
  
  LOOP
    FETCH C_per_people_f INTO C_PERSON, C_TYPE, C_LAST;
    EXIT WHEN C_per_people_f%NOTFOUND;
    
    -- Process the fetched values, for example, you can print them
    DBMS_OUTPUT.PUT_LINE('Person ID: ' || C_PERSON || ', Type: ' || C_TYPE || ', Last Name: ' || C_LAST);
  END LOOP;
  
  CLOSE C_per_people_f;
END;
/
