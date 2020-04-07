import logging
import re
import urllib.request as request
import codecs
import pymysql

db_name = 'corona_virus'
db_user = 'root'
db_pass = '123456'
db_ip = '127.0.0.1'
db_port = 3306

file_handler = codecs.open('../../log/log.txt', 'w', 'utf-8')
history_data_url = []
china_history_data_url = []


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


# data source website
url = "http://ncov.dxy.cn/ncovh5/view/en_pneumonia"

# extract data for world today
data = request.urlopen(url).read()
data = data.decode("utf-8")
country_data = re.findall('"countryType(.*?)showRank', data)
for i in range(0, len(country_data)):
    country_data[i] = '{"countryType' + country_data[i]
    country_data[i] = str(country_data[i]).replace('},"', '}}')

global_str = {'true': 0, 'false': 1}
for i in country_data:
    temp = eval(str(i), global_str)

    sql = 'INSERT INTO world_today_data(countryType,continents,provinceId,provinceName,currentConfirmedCount,confirmedCount,suspectedCount,curedCount,deadCount,deadRate,countryShortCode,countryFullName,statisticsData) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
    data = (temp['countryType'], temp['continents'],
            temp['provinceId'], temp['provinceName'], temp['currentConfirmedCount'], temp['confirmedCount'],
            temp['suspectedCount'], temp['curedCount'],
            temp['deadCount'], temp['deadRate'], temp['countryShortCode'], temp['countryFullName'],
            temp['statisticsData'])
    history_data_url.append(temp['statisticsData'])
    print('world today:', data)
    file_handler.write('world today:' + str(data) + '\n')
    write_db(sql, data)
#
# # extract the history data for every country_data
for i in range(0, len(history_data_url)):
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
#
# # china today data
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

file_handler.close()
