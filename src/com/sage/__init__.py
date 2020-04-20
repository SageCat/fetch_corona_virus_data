import codecs
import logging
import re
import urllib.request as request
from time import sleep

import pymysql

# define the mysql database information
db_name = 'corona_virus'
db_user = 'root'
db_pass = '123456'
db_ip = '127.0.0.1'
db_port = 3306

# new a log document to record the log
file_handler = codecs.open('../../log/log.txt', 'w', 'utf-8')
# new a list to save the json data url for every country
history_data_url = []
# new a list to save the json data url for every province of China
china_history_data_url = []


# define a function to write data to database table
def write_db(sql, db_data=()):
    try:
        conn = pymysql.connect(db=db_name, user=db_user, passwd=db_pass, host=db_ip, port=int(db_port), charset="utf8")
        cursor = conn.cursor()
    except Exception as e:
        print(e)
        logging.error('connect to database failed:%s' % e)
        return False

    try:
        cursor.execute(sql, db_data)
        conn.commit()
    except Exception as e:
        conn.rollback()
        logging.error('data write failed:%s' % e)
        return False
    finally:
        cursor.close()
        conn.close()


# data source website, it's from 丁香医生
url = "http://ncov.dxy.cn/ncovh5/view/en_pneumonia"
# extract data for world today
data = request.urlopen(url).read()
data = data.decode("utf-8")
# find all of the data groups which begin with 'countryType' and end with 'showRank'
country_data = re.findall('"countryType(.*?)showRank', data)
# add prefix and suffix to the data groups to let it be json format, in this case, it's easier to transform it into
# python data dictionary
for i in range(0, len(country_data)):
    country_data[i] = '{"countryType' + country_data[i]
    country_data[i] = str(country_data[i]).replace('},"', '}}')

for i in country_data:
    # transform json string into python data dictionary
    temp = eval(str(i))
    # define sql command for inserting data into database
    sql = 'INSERT INTO world_today_data(countryType,continents,provinceId,provinceName,currentConfirmedCount,' \
          'confirmedCount,suspectedCount,curedCount,deadCount,deadRate,countryShortCode,countryFullName,statisticsData)' \
          ' VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
    # get values from temp data dictionary by keys to pack them as data tuple
    data = (temp['countryType'], temp['continents'],
            temp['provinceId'], temp['provinceName'], temp['currentConfirmedCount'], temp['confirmedCount'],
            temp['suspectedCount'], temp['curedCount'],
            temp['deadCount'], temp['deadRate'], temp['countryShortCode'], temp['countryFullName'],
            temp['statisticsData'])
    # record the data url of every country history data, it's preparing to fetch the history data
    history_data_url.append(temp['statisticsData'])
    # print the data into console
    print('world today:', data)
    # write the data into log files as log
    file_handler.write('world today:' + str(data) + '\n')
    # write data into database
    write_db(sql, data)

# extract the history data for every country_data
for i in range(0, len(history_data_url)):
    # sleep 2 seconds among country's data to avoid the disconnection from the data source server
    sleep(2)
    history_data = request.urlopen(history_data_url[i]).read()
    history_data = history_data.decode('utf-8')
    history_data_detail = re.findall('{"confirmedCount"(.*?),"suspectedCountIncr"', history_data)
    for j in range(0, len(history_data_detail)):
        history_data_detail[j] = '{"confirmedCount"' + history_data_detail[j] + '}'
    for k in history_data_detail:
        temp = eval(str(k))
        sql = 'INSERT INTO world_history_data(statisticsData,confirmedCount,confirmedIncr,curedCount,curedIncr,currentConfirmedCount,currentConfirmedIncr,dateId,deadCount,deadIncr,suspectedCount) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
        data = (
            history_data_url[i], temp['confirmedCount'], temp['confirmedIncr'], temp['curedCount'], temp['curedIncr'],
            temp['currentConfirmedCount'], temp['currentConfirmedIncr'], temp['dateId'], temp['deadCount'],
            temp['deadIncr'],
            temp['suspectedCount'])
        print('world_history_data:', data)
        file_handler.write('world_history_data:' + str(data) + '\n')
        write_db(sql, data)

# china today data
original_data = request.urlopen(url).read()
original_data = original_data.decode("utf-8")
filtered_data = re.findall('window.getAreaStat(.*?)id="getIndexRecommendList2', original_data)
china_today = re.findall('provinceName(.*?),"cities', str(filtered_data))
for i in range(0, len(china_today)):
    china_today[i] = '{"provinceName' + china_today[i] + '}'

for j in china_today:
    temp = eval(str(j))

    sql = 'INSERT INTO china_today_data(provinceName,provinceShortName,currentConfirmedCount,confirmedCount,suspectedCount,curedCount,deadCount,comment,locationId,statisticsData) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
    data = (temp['provinceName'], temp['provinceShortName'], temp['currentConfirmedCount'], temp['confirmedCount'],
            temp['suspectedCount'], temp['curedCount'], temp['deadCount'], temp['comment'], temp['locationId'],
            temp['statisticsData'])
    china_history_data_url.append(temp['statisticsData'])
    print('china today data:', data)
    file_handler.write('china today data:' + str(data) + '\n')
    write_db(sql, data)
#
# # china history data
for i in range(0, len(china_history_data_url)):
    sleep(1)
    history_data = request.urlopen(china_history_data_url[i]).read()
    history_data = history_data.decode('utf-8')
    history_data_detail = re.findall('{"confirmedCount"(.*?),"suspectedCountIncr"', history_data)
    for j in range(0, len(history_data_detail)):
        history_data_detail[j] = '{"confirmedCount"' + history_data_detail[j] + '}'
    for k in history_data_detail:
        temp = eval(str(k))
        sql = 'INSERT INTO china_history_data(statisticsData,confirmedCount,confirmedIncr,curedCount,curedIncr,currentConfirmedCount,currentConfirmedIncr,dateId,deadCount,deadIncr,suspectedCount) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
        data = (
            china_history_data_url[i], temp['confirmedCount'], temp['confirmedIncr'], temp['curedCount'],
            temp['curedIncr'],
            temp['currentConfirmedCount'], temp['currentConfirmedIncr'], temp['dateId'], temp['deadCount'],
            temp['deadIncr'],
            temp['suspectedCount'])
        print('china_history_data:', data)
        file_handler.write('china_history_data:' + str(data) + '\n')
        write_db(sql, data)
# close the log file stream
file_handler.close()
