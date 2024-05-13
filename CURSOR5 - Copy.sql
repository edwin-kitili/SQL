DECLARE
c_nationality per_people_f. NATIONALITY%TYPE;
c_identifier per_people_f. NATIONAL_IDENTIFIER%TYPE;
c_name per_people_f. PREVIOUS_LAST_NAME%TYPE;
c_title per_people_f.TITLE%TYPE;
CURSOR C_per_people IS
SELECT nationality, national_identifier,last_name, title
FROM per_people_f;
BEGIN
OPEN C_per_people;
 LOOP
   FETCH C_per_people INTO c_nationality,c_identifier, c_name, c_title;
   EXIT WHEN C_per_people%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE(c_nationality||''||c_identifier||''||c_name||''||c_title);
 END LOOP;
 CLOSE  C_per_people;
END;
/