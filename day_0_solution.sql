select *
from children c
join ChristmasList l on c.child_id = l.child_id;

select city, country, avg(naughty_nice_score)
from children c
join ChristmasList l on c.child_id = l.child_id
group by city, country
having count(name) >= 5
order by avg(naughty_nice_score) desc;

with bob as (
    select city, country, avg(naughty_nice_score) score, ROW_NUMBER()
    over (
        partition by country
        order by avg(naughty_nice_score) desc
    ) as r 
    from Children c
    join ChristmasList l on c.child_id = l.child_id
    group by city, country
    having count(name) >= 5
)
select * from bob where r <= 3 
    order by score desc