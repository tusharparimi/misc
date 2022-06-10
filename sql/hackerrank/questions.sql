/*-----------------------------------------
total hours worked on weekends by each employee
-------------------------------------------*/

select emp_id,
SUM(timestampdiff(HOUR,str_to_date(itime,'%Y-%m-%d %H:%i:%s'),str_to_date(outtime,'%Y-%m-%d %H:%i:%s')))
from (
select 
emp_id
,substr(timestamp,1,10)
,max(case when rn%2=0 then timestamp end) as itime
,max(case when rn%2!=0 then timestamp end) as outtime
from (
    SELECT *
    , row_number() over (partition by emp_id order by timestamp     desc) rn
    from attendance
    WHERE weekday(timestamp)=5 or weekday(timestamp)=6
) v 
group by emp_id, substr(timestamp,1,10)
) v2
GROUP BY emp_id
;
