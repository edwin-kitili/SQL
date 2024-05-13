SELECT * FROM per_all_people_f;
SELECT * FROM per_all_assignments_f;
SELECT * FROM per_grades;

SELECT pip.person_id per,
       pip.business_group_id biz,
       pip.last_name last,
       signo.assignment_id assign,
       signo.grade_id grd,
       red.grade_defination_id def,
       red.creation_dat date
FROM
      per_all_people_f pip,
      per_all_assignments_f signo,
      per_grades red;
WHERE 
       pip.person_id=signo.person_id,
    and
