create or replace PACKAGE BODY XXAA_XDO_PLSQL_XMLP_REPORT
AS
 PROCEDURE XXAA_EMP_DETAILS (o_errbuf OUT VARCHAR2, o_retcode OUT VARCHAR2)
 AS
 -->Cursor to fetch Employee Records
 CURSOR csr_employee
 IS
 SELECT papf.person_id prsn_id,
 papf.full_name prsn_name,
 employee_number emp_no,
 papf.business_group_id,
 pg.name grade
 FROM per_all_people_f papf,
 per_all_assignments_f paaf,
 per_grades pg
 WHERE papf.person_id = paaf.person_id
 AND paaf.grade_id = pg.grade_id
 AND paaf.assignment_type = 'E'
 AND paaf.primary_flag = 'Y'
 AND TRUNC (SYSDATE) BETWEEN papf.effective_start_date AND
papf.effective_end_date
 AND TRUNC (SYSDATE) BETWEEN paaf.effective_start_date AND
paaf.effective_end_date
 AND TRUNC (SYSDATE) BETWEEN NVL (pg.date_from, SYSDATE) AND NVL
(pg.date_to, SYSDATE)
 AND papf.business_group_id = 202;
 -->Cursor to fetch employee’s dependent (Children) records
 CURSOR csr_children (p_person_id NUMBER)
 IS
 SELECT papf.person_id child_id,
 papf.full_name child_name,
 papf.date_of_birth dob
 FROM per_contact_relationships pcr, per_all_people_f papf
 WHERE pcr.contact_person_id = papf.person_id
 AND pcr.person_id = p_person_id
 AND pcr.contact_type = 'C'
 AND TRUNC (SYSDATE) BETWEEN NVL (pcr.date_start, SYSDATE) AND NVL
(pcr.date_end, SYSDATE)
 AND TRUNC (SYSDATE) BETWEEN papf.effective_start_date AND
papf.effective_end_date;
 BEGIN
 /*First line of XML data should be ‘<?xml version="1.0"?>’*/
 FND_FILE.PUT_LINE (FND_FILE.OUTPUT, '<?xml version="1.0"?>');
 FND_FILE.PUT_LINE (FND_FILE.OUTPUT, '<XXAA_EMP_DETAILS>');
 FOR v_employee IN csr_employee
 LOOP
 /*for each record create a group tag <G_EMP_NAME> at the start*/
 FND_FILE.PUT_LINE (FND_FILE.OUTPUT, ' <G_EMP_NAME>');
 /*Embed data between XML tags for ex:- <EMP_NAME>Abeesh</EMP_NAME>*/
 FND_FILE.PUT_LINE ( FND_FILE.OUTPUT, ' <EMP_NAME>' || v_employee.prsn_name ||
'</EMP_NAME>');
 FND_FILE.PUT_LINE ( FND_FILE.OUTPUT, ' <EMP_NO>' || v_employee.emp_no ||
'</EMP_NO>');
 FND_FILE.PUT_LINE ( FND_FILE.OUTPUT, ' <GRADE>' || v_employee.grade ||
'</GRADE>');
 FOR v_children IN csr_children (v_employee.prsn_id)
 LOOP
 /*for each child record create a group tag <G_NO_CHILD> at the start*/
 FND_FILE.PUT_LINE ( FND_FILE.OUTPUT, ' <G_NO_CHILD>');
 FND_FILE.PUT_LINE ( FND_FILE.OUTPUT, ' <CHILD_NAME>' ||
v_children.child_name || '</CHILD_NAME>');
 FND_FILE.PUT_LINE ( FND_FILE.OUTPUT, ' <CHILD_DOB>' || v_children.dob ||
'</CHILD_DOB>');
 FND_FILE.PUT_LINE ( FND_FILE.OUTPUT, ' <CHILD_CLASS> I</CHILD_CLASS>');
 FND_FILE.PUT_LINE ( FND_FILE.OUTPUT, ' <CHILD_SCHOOL>BHAVANS 
</CHILD_SCHOOL>');
 FND_FILE.PUT_LINE ( FND_FILE.OUTPUT, ' <CHILD_FEES>100 </CHILD_FEES>');
 /*Close the group tag </G_NO_CHILD> at the end of child record*/
 FND_FILE.PUT_LINE (FND_FILE.OUTPUT, ' </G_NO_CHILD>');
 END LOOP;
 /*Close the group tag </G_EMP_NAME> at the end of employee record*/
 FND_FILE.PUT_LINE (FND_FILE.OUTPUT, ' </G_EMP_NAME>');
 END LOOP;
 /*finally Close the starting Report tag*/
 FND_FILE.PUT_LINE (FND_FILE.OUTPUT, '</XXAA_EMP_DETAILS>');

 END XXAA_EMP_DETAILS;
END XXAA_XDO_PLSQL_XMLP_REPORT;