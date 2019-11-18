-- 1. Largest number of unique users
-- The site with id N0OTG has the largest number of unique users of 90.
select top 1 count(user_id), site_id from
(select unique user_id, site_id from table where country_id = 'BDV')
group by site_id


----------------------------------------------------------------------------
-- 2. Users who visited sites more than 10 times during the given timeframe
select * from
(select unique user_id, site_id, count(site_id) as c from
(select user_id, site_id from table
  where ts between "2019-02-03 00:00:00"
  and "2019-02-04 23:59:59") group by user_id, site_id)
where c >= 10;
/**
Below is the ID of the users who visited sites more than 10 times during the
given timeframe followed by the site ID and counts:
[
   {
      "user_id": "LC3C7E",
      "site_id": "3POLC",
      "c": 15
   },
   {
      "user_id": "LC3A59",
      "site_id": "N0OTG",
      "c": 26
   },
   {
      "user_id": "LC06C3",
      "site_id": "N0OTG",
      "c": 25
   },
   {
      "user_id": "LC3C9D",
      "site_id": "N0OTG",
      "c": 17
   }
]
**/

-----------------------------------------------------------------------------
-- 3. Unique numbers of users whose last visit was for each site
select site_id, count(user_id) from
(select * from table group by user_id order by ts desc)
group by site_id

/**
Below is the output from querying unique numbers of users whose last visit was for each site:
[
   {
      "site_id": "QGO3G",
      "COUNT(user_id)": 293
   },
   {
      "site_id": "N0OTG",
      "COUNT(user_id)": 561
   },
   {
      "site_id": "GVOFK",
      "COUNT(user_id)": 46
   },
   {
      "site_id": "5NPAU",
      "COUNT(user_id)": 985
   },
   {
      "site_id": "3POLC",
      "COUNT(user_id)": 28
   },
   {
      "site_id": "JSUUP",
      "COUNT(user_id)": 2
   },
   {
      "site_id": "RT9Z6",
      "COUNT(user_id)": 1
   }
]
**/

---------------------------------------------------------------------------
-- 4. Number of users whose first/last visits are to the same website
-- Output: 1670
-- Last site each user visited
select * from table group by user_id order by ts desc

-- First site each user visited
select * from table group by user_id order by ts asc

create table first_visit go select * from
(select * from table group by user_id order by ts asc)

create table last_visit select * from
(select * from table group by user_id order by ts desc)
