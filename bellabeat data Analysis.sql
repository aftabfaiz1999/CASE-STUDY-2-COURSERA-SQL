use bellabeat
go

---This Data is From  Bellabeat Application of One Month and 33 Peoples---





select * from dailyActivity_merged


select * from dailyActivity_merged order by ActivityDate desc

 ---1.Total People Who have Logged In Application---
 select COUNT(distinct id) as TotalLoggedInPeoples from dailyActivity_merged


 ---2.show average Totalsteps of a person by his id
select Avg(TotalSteps)as totalsteps,Calories from dailyActivity_merged Group by  Calories  order by Calories desc ;



----3.show average TotalSteps of a person by id  who burned more then 1000-2000 Calories by desending order
select Avg(TotalSteps) as avg_total_steps ,Calories from dailyActivity_merged Group by  Calories having Calories between 1000 and 2000 order by Calories desc ;

----4.show average TotalSteps of a person by id who burned more then 2000-3000 Calories by desending order

select Avg(TotalSteps)as avg_total_steps,Calories from dailyActivity_merged Group by  Calories having Calories between 2000 and 3000 order by Calories desc ;


----5.show average TotalSteps of a person by id who burned more then 3000-4000 Calories by desending order
select Avg(TotalSteps)as avg_total_steps,Calories from dailyActivity_merged Group by  Calories having Calories between 3000 and 4000 order by Calories desc ;

----6.show average TotalSteps of a person by id who burned more then 4000-5000 Calories by desending order

select Avg(TotalSteps)as avg_total_steps,Calories from dailyActivity_merged Group by  Calories having Calories between 4000 and 5000 order by Calories desc ;


 -----7. 33 People Calories Burned Daily by id 
 select distinct(Calories) as Daily_calories_burned,Id as daily_id_login from dailyActivity_merged where Calories > (select count(Calories)from dailyActivity_merged)


 ----8. In weightLogInfo_merged table have only 8 people id's with repect to weight..The Ids and calories from dailyActivity_merged and weight and bmi from weightLogInfo_merged
 create view Calories_Weight_kg as

select distinct(dailyActivity_merged.Id),dailyActivity_merged.Calories,weightLogInfo_merged.WeightKg,weightLogInfo_merged.BMI
from dailyActivity_merged
left join weightLogInfo_merged
on dailyActivity_merged.Id=weightLogInfo_merged.Id
where weightLogInfo_merged.WeightKg is not null

----Wight of 8 People by Calories Burned 


select  sum(distinct Calories) as Sum_Calories , WeightKg from Calories_Weight_kg group by WeightKg
select  avg(distinct Calories) as Avg_Calories , WeightKg from Calories_Weight_kg group by WeightKg
select  min(distinct Calories) as Min_Calories , WeightKg from Calories_Weight_kg group by WeightKg
select  max(distinct Calories) as Max_Calories , WeightKg from Calories_Weight_kg group by WeightKg



-----9.Time duration of  people sleeps after burned Calories
create view sleepDuration_after_CaloriesBrned as

select distinct(dailyCalories_merged.Calories),dailyCalories_merged.ActivityDay,
Cast(TotalMinutesAsleep / 60 as Varchar) + ' hours '+
Cast(TotalMinutesAsleep % 60 as Varchar) + ' minutes'
as [TotalTimeSleep],dailyCalories_merged.Id
from dailyCalories_merged
left join sleepDay_merged
on dailyCalories_merged.Id=sleepDay_merged.Id
where sleepDay_merged.TotalMinutesAsleep > (select count(distinct Id)from dailyCalories_merged)


-----10.Heartrate Value with AverageIntensity with respect to id's Create a View


create view totalintensity_heartrate_Onehour as

select distinct(heartrate_seconds_merged.Value),hourlyIntensities_merged.TotalIntensity,hourlyIntensities_merged.Id
from hourlyIntensities_merged
left join heartrate_seconds_merged
on hourlyIntensities_merged.Id=heartrate_seconds_merged.Id 
where Value is not null

---- To Check TotalIntensity IN Onehour with Heartrate
select count(distinct TotalIntensity) as TotalIntnsity, totalintensity_heartrate_Onehour.value as HeartRate from totalintensity_heartrate_Onehour
group by Value




