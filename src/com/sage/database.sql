create schema corona_virus collate utf8mb4_general_ci;

create table china_history_data
(
	statisticsData varchar(256) null,
	confirmedCount varchar(10) null,
	confirmedIncr varchar(10) null,
	curedCount varchar(10) null,
	curedIncr varchar(10) null,
	currentConfirmedCount varchar(10) null,
	currentConfirmedIncr varchar(10) null,
	dateId varchar(24) null,
	deadCount varchar(10) null,
	deadIncr varchar(10) null,
	suspectedCount varchar(10) null,
	update_time timestamp default CURRENT_TIMESTAMP not null
);

create table china_today_data
(
	provinceName varchar(32) null,
	provinceShortName varchar(32) null,
	currentConfirmedCount varchar(10) null,
	confirmedCount varchar(10) null,
	suspectedCount varchar(10) null,
	curedCount varchar(10) null,
	deadCount varchar(10) null,
	comment varchar(1024) null,
	locationId varchar(10) null,
	statisticsData varchar(256) null,
	update_time timestamp default CURRENT_TIMESTAMP not null
);

create table world_history_data
(
	statisticsData varchar(256) null,
	confirmedCount varchar(10) null,
	confirmedIncr varchar(10) null,
	curedCount varchar(10) null,
	curedIncr varchar(10) null,
	currentConfirmedCount varchar(10) null,
	currentConfirmedIncr varchar(10) null,
	dateId varchar(24) null,
	deadCount varchar(10) null,
	deadIncr varchar(10) null,
	suspectedCount varchar(10) null,
	update_time timestamp default CURRENT_TIMESTAMP not null
);

create table world_today_data
(
	createTime timestamp default CURRENT_TIMESTAMP not null,
	countryType varchar(32) null,
	continents varchar(32) null,
	provinceId varchar(32) null,
	provinceName varchar(32) null,
	currentConfirmedCount varchar(32) null,
	confirmedCount varchar(32) null,
	suspectedCount varchar(32) null,
	curedCount varchar(32) null,
	deadCount varchar(32) null,
	deadRate varchar(32) null,
	countryShortCode varchar(32) null,
	countryFullName varchar(64) null,
	statisticsData varchar(256) null
);

