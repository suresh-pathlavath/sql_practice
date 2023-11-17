SELECT emp_name,
    emp_increment_date,
    /* YEAR(STR_TO_DATE(emp_doj, '%d-%m-%Y')) as date_of_join,*/
    YEAR(STR_TO_DATE(emp_increment_date, '%d-%m-%Y')) as incremental_year,
    salary
FROM emp_table
order by emp_name,
    incremental_year
    /*
     https://www.linkedin.com/posts/saikat-de-76376a149_sql-sqldeveloper-sqlqueries-activity-7118905100168777729-Sp3E/?utm_source=share&utm_medium=member_android
     
     Write a SQL code & provide only those employee's who got incremental hike year over year.
     */