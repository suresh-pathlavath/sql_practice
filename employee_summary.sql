with logins as (
    SELECT employeeid, max(timestamp_details) latest_login, count(1) as totallogin from employee_checkin_details where entry_details = 'login' group by 1
)
, logouts as (
    SELECT employeeid, max(timestamp_details) latest_logout, count(1) as totallogin from employee_checkin_details where entry_details = 'logout' group by 1
)

SELECT a.*, b.*
 from logins as a 
 inner join logouts as b on a.employeeid = b.employeeid
;

SELECT * from employee_checkin_details;
SELECT * from employee_details;


/*

https://www.youtube.com/watch?v=u3W_Op3FTVA&ab_channel=AnkitBansal


--employeeid, totalentry, totallogin, totallogout, latestlogin, latestlogout, employee_default_phone_number
*/