-- world_today_data
SELECT createTime,
       continents,
       provinceName,
       currentConfirmedCount,
       confirmedCount,
       suspectedCount,
       curedCount,
       deadCount,
       deadRate,
       countryFullName
FROM world_today_data;


-- world_history_data
SELECT continents,
       countryFullName,
       dateId,
       confirmedCount,
       confirmedIncr,
       curedCount,
       curedIncr,
       currentConfirmedCount,
       currentConfirmedIncr,
       deadCount,
       deadIncr,
       suspectedCount
FROM (select statisticsData,
             confirmedCount,
             confirmedIncr,
             curedCount,
             curedIncr,
             currentConfirmedCount,
             currentConfirmedIncr,
             date_format(dateId, '%Y-%m-%d') as dateId,
             deadCount,
             deadIncr,
             suspectedCount
      from world_history_data
      order by statisticsData) history_data
         left join
     (SELECT continents,
             provinceName,
             countryFullName,
             statisticsData
      FROM world_today_data
      order by statisticsData
     ) dim_country_name
     on history_data.statisticsData = dim_country_name.statisticsData

-- china_today_data
SELECT provinceShortName,
       currentConfirmedCount,
       confirmedCount,
       suspectedCount,
       curedCount,
       deadCount
FROM china_today_data;

-- china_history_data
SELECT provinceShortName,
       dateId,
       confirmedCount,
       confirmedIncr,
       curedCount,
       curedIncr,
       currentConfirmedCount,
       currentConfirmedIncr,
       deadCount,
       deadIncr,
       suspectedCount
FROM (SELECT statisticsData,
             date_format(dateId, '%Y-%m-%d') as dateId,
             confirmedCount,
             confirmedIncr,
             curedCount,
             curedIncr,
             currentConfirmedCount,
             currentConfirmedIncr,
             deadCount,
             deadIncr,
             suspectedCount
      FROM china_history_data
      order by statisticsData) china_history_data
         left join (SELECT provinceShortName,
                           statisticsData
                    FROM china_today_data
                    order by statisticsData) dim_province
                   on china_history_data.statisticsData = dim_province.statisticsData