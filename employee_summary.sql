-- employee checkin details employeeid, totalentry, totallogin, totallogout, latestlogin, latestlogout
-- https://ik.imagekit.io/suresh29/sql_practice/employee_checkins.pdf
 
WITH logins
     AS (SELECT employeeid,
                Max(timestamp_details) latest_login,
                Count(1)               AS totallogin
         FROM   employee_checkin_details
         WHERE  entry_details = 'login'
         GROUP  BY 1),
     logouts
     AS (SELECT employeeid,
                Max(timestamp_details) latest_logout,
                Count(1)               AS totallogin
         FROM   employee_checkin_details
         WHERE  entry_details = 'logout'
         GROUP  BY 1)
SELECT a.*,
       b.*
FROM   logins AS a
       INNER JOIN logouts AS b
               ON a.employeeid = b.employeeid;

SELECT *
FROM   employee_checkin_details;

SELECT *
FROM   employee_details;
/*

https://www.youtube.com/watch?v=u3W_Op3FTVA&ab_channel=AnkitBansal


--employeeid, totalentry, totallogin, totallogout, latestlogin, latestlogout, employee_default_phone_number
*/