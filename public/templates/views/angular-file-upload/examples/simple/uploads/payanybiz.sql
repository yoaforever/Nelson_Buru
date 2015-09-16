/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : payanybiz

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2015-02-26 22:53:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for airportcode
-- ----------------------------
DROP TABLE IF EXISTS airportcodes;
CREATE TABLE airportcodes (
id   int NOT NULL,
  description varchar NOT NULL,
  createdOn datetime DEFAULT NULL,
  modifiedOn datetime DEFAULT NULL,
  active tinyint(4) DEFAULT NULL,
  PRIMARY KEY (id )
);

-- ----------------------------
-- Records of airportcode
-- ----------------------------

-- ----------------------------
-- Table structure for airtransactionsdetail
-- ----------------------------
DROP TABLE IF EXISTS airtransactionsdetails;
CREATE TABLE airtransactionsdetails (
id   int(11) NOT NULL,
  transactions_id   int(11) NOT NULL,
  airwaybillnumber varchar(30) DEFAULT NULL,
  issued_date datetime DEFAULT NULL,
  origin int(11) DEFAULT NULL,
  destination int(11) DEFAULT NULL,
  actual_weight int(11) DEFAULT NULL,
  chargeable_weight int(11) DEFAULT NULL,
  freight int(11) DEFAULT NULL,
  fuel int(11) DEFAULT NULL,
  security varchar(10) DEFAULT NULL,
  tax varchar(10) DEFAULT NULL,
  declared_value decimal(19,4) DEFAULT NULL,
  amount_due decimal(19,4) DEFAULT NULL,
  payment_amount decimal(19,4) DEFAULT NULL,
  createdOn datetime DEFAULT NULL,
  modifiedOn datetime DEFAULT NULL,
  active tinyint(4) DEFAULT NULL,
  PRIMARY KEY (id ),
  KEY destination (destinations),
  KEY origins (origins),
  KEY transactions_id   (transactions_id  ),
  CONSTRAINT airtransactionsdetail_ibfk_1 FOREIGN KEY (destinations) REFERENCES airportcodes (id ),
  CONSTRAINT airtransactionsdetail_ibfk_2 FOREIGN KEY (origins) REFERENCES airportcodes (id ),
  CONSTRAINT airtransactionsdetail_ibfk_3 FOREIGN KEY (transactions_id  ) REFERENCES transactions (id )
) ;

-- ----------------------------
-- Records of airtransactionsdetail
-- ----------------------------

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS banks;
CREATE TABLE banks (
id   int(11) NOT NULL,
  name longtext,
  createdOn datetime NOT NULL,
  modifiedOn datetime NOT NULL,
  active tinyint(4) NOT NULL,
  routing_number longtext NOT NULL,
  PRIMARY KEY (id )
);

-- ----------------------------
-- Records of bank
-- ----------------------------
INSERT INTO banks VALUES ( 7 ,  Regions123 ,  2013-12-08 16:58:54 ,  2013-12-08 16:58:54 ,  1 ,  180000110 );
INSERT INTO banks VALUES ( 8 ,  Wells Fargo ,  2013-12-08 16:58:55 ,  2013-12-08 16:58:55 ,  1 ,  100010011 );
INSERT INTO banks VALUES ( 9 ,  BNK-212 ,  2013-12-08 16:58:57 ,  2013-12-08 16:58:57 ,  1 ,  303000000 );
INSERT INTO banks VALUES ( 10 ,  BNK-213 ,  2013-12-08 16:58:58 ,  2013-12-08 16:58:58 ,  1 ,  130000000 );
INSERT INTO banks VALUES ( 11 ,  BNK-214 ,  2013-12-08 16:58:59 ,  2013-12-08 16:58:59 ,  1 ,  123123000 );
INSERT INTO banks VALUES ( 12 ,  BOFA ,  2013-12-08 17:01:15 ,  2013-12-08 17:01:15 ,  1 ,  123123440 );
INSERT INTO banks VALUES ( 13 ,  Sun Trust ,  2013-12-08 17:01:16 ,  2013-12-08 17:01:16 ,  1 ,  444123000 );
INSERT INTO banks VALUES ( 14 ,  BBV ,  2013-12-08 17:01:18 ,  2013-12-08 17:01:18 ,  1 ,  125523000 );

-- ----------------------------
-- Table structure for bankaccount
-- ----------------------------
DROP TABLE IF EXISTS bankaccounts;
CREATE TABLE bankaccounts (
id   int(11) NOT NULL,
  number longtext NOT NULL,
  name longtext,
  routing_number longtext,
  active tinyint(4) NOT NULL,
  createdOn datetime NOT NULL,
  modifiedOn datetime NOT NULL,
  customers_id   int(11) NOT NULL,
  bank_id   int(11) DEFAULT NULL,
  type int(11) NOT NULL,
  bank_name varchar(255) NOT NULL,
  PRIMARY KEY (id ),
  KEY bank_id   (bank_id  ),
  KEY customers_id   (customers_id  ),
  CONSTRAINT bankaccount_ibfk_1 FOREIGN KEY (bank_id  ) REFERENCES banks (id ),
  CONSTRAINT bankaccount_ibfk_2 FOREIGN KEY (customers_id  ) REFERENCES customerss (id )
);

-- ----------------------------
-- Records of bankaccount
-- ----------------------------
INSERT INTO bankaccounts VALUES ( 8 ,  900000 ,  ACCTG#1 ,  100010011 ,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  3 ,  8 ,  1 ,  Wells Fargo );
INSERT INTO bankaccounts VALUES ( 9 ,  80000 ,  ACCTG#2 ,  180000110 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  3 ,  7 ,  1 ,  Regions123 );
INSERT INTO bankaccounts VALUES ( 69 ,  123 , null,  111111111 ,  1 ,  2015-02-09 11:40:49 ,  2015-02-09 11:40:49 ,  43 , null,  1 ,  asdasd );
INSERT INTO bankaccounts VALUES ( 70 ,  123 , null,  111111111 ,  1 ,  2015-02-09 11:40:49 ,  2015-02-09 11:40:49 ,  43 , null,  2 ,  asdasd );
INSERT INTO bankaccounts VALUES ( 71 ,  1234 , null,  111111151 ,  1 ,  2015-02-09 12:39:59 ,  2015-02-09 12:39:59 ,  44 , null,  1 ,  asdas );
INSERT INTO bankaccounts VALUES ( 72 ,  1234 , null,  111111151 ,  1 ,  2015-02-09 12:39:59 ,  2015-02-09 12:39:59 ,  44 , null,  2 ,  asdas );
INSERT INTO bankaccounts VALUES ( 73 ,  12345678 , null,  123456789 ,  1 ,  2015-02-09 12:45:53 ,  2015-02-09 12:45:53 ,  45 , null,  1 ,  27890 );
INSERT INTO bankaccounts VALUES ( 74 ,  12345678 , null,  123456789 ,  1 ,  2015-02-09 12:45:53 ,  2015-02-09 12:45:53 ,  45 , null,  2 ,  27890 );
INSERT INTO bankaccounts VALUES ( 75 ,  1235 , null,  011111111 ,  1 ,  2015-02-09 12:55:17 ,  2015-02-09 12:55:17 ,  46 , null,  1 ,  asdsd );
INSERT INTO bankaccounts VALUES ( 76 ,  1235 , null,  011111111 ,  1 ,  2015-02-09 12:55:17 ,  2015-02-09 12:55:17 ,  46 , null,  2 ,  asdsd );
INSERT INTO bankaccounts VALUES ( 83 ,  444 , null,  212222222 ,  1 ,  2015-02-09 13:28:55 ,  2015-02-09 13:28:55 ,  50 , null,  1 ,  hghgdghd );
INSERT INTO bankaccounts VALUES ( 84 ,  444 , null,  212222222 ,  1 ,  2015-02-09 13:28:55 ,  2015-02-09 13:28:55 ,  50 , null,  2 ,  hghgdghd );
INSERT INTO bankaccounts VALUES ( 85 ,  111111111 , null,  111111111 ,  1 ,  2015-02-09 20:01:47 ,  2015-02-09 20:01:47 ,  51 , null,  1 ,  Chase );
INSERT INTO bankaccounts VALUES ( 86 ,  111111111 , null,  111111111 ,  1 ,  2015-02-09 20:01:47 ,  2015-02-09 20:01:47 ,  51 , null,  2 ,  Chase );
INSERT INTO bankaccounts VALUES ( 87 ,  123456 , null,  123456789 ,  1 ,  2015-02-11 20:16:40 ,  2015-02-11 20:16:40 ,  52 , null,  1 ,  Chase );
INSERT INTO bankaccounts VALUES ( 88 ,  123456 , null,  123456789 ,  1 ,  2015-02-11 20:16:40 ,  2015-02-11 20:16:40 ,  52 , null,  2 ,  Chase );
INSERT INTO bankaccounts VALUES ( 89 ,  333 , null,  333333333 ,  1 ,  2015-02-11 21:01:00 ,  2015-02-11 21:01:00 ,  53 , null,  1 ,  ff );
INSERT INTO bankaccounts VALUES ( 90 ,  333 , null,  333333333 ,  1 ,  2015-02-11 21:01:00 ,  2015-02-11 21:01:00 ,  53 , null,  2 ,  ff );

-- ----------------------------
-- Table structure for biz_area
-- ----------------------------
DROP TABLE IF EXISTS  biz_areas;
CREATE TABLE biz_areas (
id   int(11) NOT NULL,
  biz_area_description varchar(20) NOT NULL,
  createdOn datetime NOT NULL,
  modifiedOn datetime NOT NULL,
  active tinyint(4) NOT NULL,
  PRIMARY KEY (id )
) ;

-- ----------------------------
-- Records of biz_area
-- ----------------------------
INSERT INTO biz_areas VALUES ( 1 ,  Ocean ,  2013-11-20 23:36:11 ,  2013-11-20 23:36:11 ,  1 );
INSERT INTO biz_areas VALUES ( 2 ,  Air ,  2013-11-20 23:36:11 ,  2013-11-20 23:36:11 ,  1 );
INSERT INTO biz_areas VALUES ( 3 ,  Trucking ,  2013-11-20 23:36:11 ,  2013-11-20 23:36:11 ,  1 );
INSERT INTO biz_areas VALUES ( 4 ,  Biz To Biz ,  2013-11-20 23:36:11 ,  2013-11-20 23:36:11 ,  1 );
INSERT INTO biz_areas VALUES ( 5 ,  Rail ,  2013-11-20 23:36:11 ,  2013-11-20 23:36:11 ,  1 );

-- ----------------------------
-- Table structure for chatmessage
-- ----------------------------
DROP TABLE IF EXISTS chatmessages;
CREATE TABLE chatmessage (
id   int(11) NOT NULL,
  message longtext,
  unread tinyint(4) DEFAULT NULL,
  customers_id   int(11) DEFAULT NULL,
  users_id   int(11) DEFAULT NULL,
  active tinyint(4) DEFAULT NULL,
  createdOn datetime DEFAULT NULL,
  modifiedOn datetime DEFAULT NULL,
  PRIMARY KEY (id )
) ;

-- ----------------------------
-- Records of chatmessage
-- ----------------------------

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS citys;
CREATE TABLE citys (
id   int(11) NOT NULL,
  name longtext NOT NULL,
  country_id   int(11) DEFAULT NULL,
  state_id   int(11) DEFAULT NULL,
  citytimezone_id   int(11) DEFAULT NULL,
  createdOn datetime NOT NULL,
  modifiedOn datetime NOT NULL,
  active tinyint(4) NOT NULL,
  PRIMARY KEY (_id ),
  KEY citytimezone_id   (citytimezone_id  ),
  KEY country_id   (country_id  ),
  KEY state_id   (state_id  ),
  CONSTRAINT city_ibfk_1 FOREIGN KEY (citytimezone_id  ) REFERENCES citytimezones (id ),
  CONSTRAINT city_ibfk_2 FOREIGN KEY (country_id  ) REFERENCES countrys (id ),
  CONSTRAINT city_ibfk_3 FOREIGN KEY (state_id  ) REFERENCES states (id )
) ;

-- ----------------------------
-- Records of city
-- ----------------------------
INSERT INTO citys VALUES ( 2 ,  Miami ,  2 ,  2 , null,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 );
INSERT INTO citys VALUES ( 4 ,  Burbank ,  2 ,  3 , null,  2014-11-09 00:00:00 ,  2014-11-09 00:00:00 ,  1 );
INSERT INTO citys VALUES ( 6 ,  Charlotte ,  2 ,  4 , null,  2014-11-09 00:00:00 ,  2014-11-09 00:00:00 ,  1 );

-- ----------------------------
-- Table structure for citytimezone
-- ----------------------------
DROP TABLE IF EXISTS citytimezones;
CREATE TABLE citytimezones (
id   int(11) NOT NULL,
  name longtext NOT NULL,
  hours_diff int(11) NOT NULL,
  createdOn datetime NOT NULL,
  modifiedOn datetime NOT NULL,
  active tinyint(4) NOT NULL,
  country_id   int(11) DEFAULT NULL,
  PRIMARY KEY (id ),
  KEY country_id   (country_id  ),
  CONSTRAINT citytimezone_ibfk_1 FOREIGN KEY (country_id) REFERENCES countrys (id )
);

-- ----------------------------
-- Records of citytimezone
-- ----------------------------

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts (
id   int(11) NOT NULL,
  first_name longtext NOT NULL,
  last_name longtext NOT NULL,
  address longtext,
  zip_postal longtext,
  phone longtext,
  phone_ext longtext,
  fax longtext,
  email longtext NOT NULL,
  createdOn datetime NOT NULL,
  modifiedOn datetime NOT NULL,
  active tinyint(4) NOT NULL,
  country_id   int(11) DEFAULT NULL,
  customers_id   int(11) DEFAULT NULL,
  state_id   int(11) DEFAULT NULL,
  city_id   int(11) DEFAULT NULL,
  PRIMARY KEY (id ),
  KEY city_id   (city_id  ),
  KEY country_id   (country_id  ),
  KEY customers_id   (customers_id),
  KEY state_id   (state_id  ),
  CONSTRAINT contact_ibfk_1 FOREIGN KEY (city_id  ) REFERENCES citys (id ),
  CONSTRAINT contact_ibfk_2 FOREIGN KEY (country_id  ) REFERENCES countrys (id ),
  CONSTRAINT contact_ibfk_3 FOREIGN KEY (customers_id  ) REFERENCES customerss (id ),
  CONSTRAINT contact_ibfk_4 FOREIGN KEY (state_id  ) REFERENCES states (id )
) ;

-- ----------------------------
-- Records of contact
-- ----------------------------

-- ----------------------------
-- Table structure for country
-- ----------------------------
DROP TABLE IF EXISTS countrys;
CREATE TABLE countrys (
id   int(11) NOT NULL,
  name longtext NOT NULL,
  createdOn datetime NOT NULL,
  modifiedOn datetime NOT NULL,
  active tinyint(4) NOT NULL,
  PRIMARY KEY (id )
) ;

-- ----------------------------
-- Records of country
-- ----------------------------
INSERT INTO countrys VALUES ( 2 ,  USA ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 );

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS customerss;
CREATE TABLE customes (
id   int(11) NOT NULL,
  legal_name varchar(50) NOT NULL,
  dba longtext,
  tin longtext,
  address longtext,
  zip_postal longtext,
  phone longtext,
  phone_ext longtext,
  fax longtext,
  email longtext NOT NULL,
  url longtext,
  debit_account_id   int(11) DEFAULT NULL,
  OFACStatus int(11) DEFAULT NULL,
  registration_status int(11) DEFAULT NULL,
    createdOn datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    mctive   tinyint(4) NOT NULL,
    ountry_id int(11) DEFAULT NULL,
    city_id int(11) DEFAULT NULL,
    state_id int(11) DEFAULT NULL,
    duns   varchar(255) DEFAULT NULL,
    city   varchar(255) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY   city_id (  city_id),
  KEY   country_id (  country_id),
  KEY   state_id (  state_id),
  CONSTRAINT   customers_ibfk_1   FOREIGN KEY (  city_id) REFERENCES   citys   (id),
  CONSTRAINT   customers_ibfk_2   FOREIGN KEY (  country_id) REFERENCES   countrys   (id),
  CONSTRAINT   customers_ibfk_3   FOREIGN KEY (  state_id) REFERENCES   states   (id)
) ;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO   customerss   VALUES ( 3 ,  Maersk Lines ,  Bil ,  Tin#1 ,  9300 Arrowpoint  ,  28273 ,  500-900-9090 ,  100 ,  500-900-9091 ,  angelmpino87@yahoo.com ,  url ,  1 ,  1 ,  1 ,  2013-01-10 00:00:00 ,  2013-01-10 00:00:00 ,  1 ,  2 ,  6 ,  4 , null, null);
INSERT INTO   customerss   VALUES ( 4 ,  payor #4 ,  Pay ,  Tin #2 ,  Addr #2 ,  33190 ,  600-098-0090 ,  200 ,  700-099-9080 ,  a@a.com ,  url1 ,  1 ,  1 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 ,  2 ,  2 ,  2 , null, null);
INSERT INTO   customerss   VALUES ( 5 ,  payor #5 ,  Pay ,  Tin #3 ,  Addr #3 ,  33170 ,  600-080-9090 ,  300 ,  600-090-9808 ,  b@b.com ,  url3 ,  1 ,  1 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 ,  2 ,  2 ,  2 , null, null);
INSERT INTO   customerss   VALUES ( 6 ,  biller #6 ,  Bil ,  Tin#1 ,  Addr #! ,  33180 ,  500-900-9090 ,  100 ,  500-900-9091 ,  j@j.com ,  url ,  1 ,  1 ,  1 ,  2013-01-10 00:00:00 ,  2013-01-10 00:00:00 ,  1 ,  2 ,  2 ,  2 , null, null);
INSERT INTO   customerss   VALUES ( 7 ,  payor #7 ,  Pay ,  Tin #2 ,  Addr #2 ,  33190 ,  600-098-0090 ,  200 ,  700-099-9080 ,  a@a.com ,  url1 ,  1 ,  1 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 ,  2 ,  2 ,  2 , null, null);
INSERT INTO   customerss  VALUES ( 8 ,  payor #8 ,  Pay ,  Tin #3 ,  Addr #3 ,  33170 ,  600-080-9090 ,  300 ,  600-090-9808 ,  b@b.com ,  url3 ,  1 ,  1 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 ,  2 ,  2 ,  2 , null, null);
INSERT INTO   customerss   VALUES ( 9 ,  biller #9 ,  Bil ,  Tin#1 ,  Addr #! ,  33180 ,  500-900-9090 ,  100 ,  500-900-9091 ,  j@j.com ,  url ,  1 ,  1 ,  1 ,  2013-01-10 00:00:00 ,  2013-01-10 00:00:00 ,  1 ,  2 ,  2 ,  2 , null, null);
INSERT INTO   customerss   VALUES ( 10 ,  payor #10 ,  Pay ,  Tin #2 ,  Addr #2 ,  33190 ,  600-098-0090 ,  200 ,  700-099-9080 ,  a@a.com ,  url1 ,  1 ,  1 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 ,  2 ,  2 ,  2 , null, null);
INSERT INTO   customerss   VALUES ( 11 ,  Disney1 ,  Pay ,  Tin #3 ,  500 South Buena Vista Street ,  91521 ,  600-080-9090 ,  300 ,  600-090-9808 ,  greyes@gmslending.com  ,  url3 ,  1 ,  1 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 ,  2 ,  4 ,  3 , null, null);
INSERT INTO   customerss   VALUES ( 12 ,  biller #12 ,  Bil ,  Tin#1 ,  Addr #! ,  33180 ,  500-900-9090 ,  100 ,  500-900-9091 ,  j@j.com ,  url ,  1 ,  1 ,  1 ,  2013-01-10 00:00:00 ,  2013-01-10 00:00:00 ,  1 ,  2 ,  2 ,  2 , null, null);
INSERT INTO   customerss   VALUES ( 43 ,  Ult , null,  11111111111 ,  1435 NW 82th Av ,  33134 ,  1111111111 , null, null,  angel@ultconsulting.com , null,  0 ,  0 ,  0 ,  2015-02-09 11:40:49 ,  2015-02-09 11:40:49 ,  0 ,  2 , null,  2 , null,  asas );
INSERT INTO   customerss   VALUES ( 44 ,  Maersk1 , null,  11111111111 ,  123 lasd ,  33134 ,  1111111111 , null, null,  angel@ultconsulting.com , null,  0 ,  0 ,  0 ,  2015-02-09 12:39:58 ,  2015-02-09 12:39:58 ,  0 ,  2 , null,  2 , null,  dad );
INSERT INTO   customerss   VALUES ( 45 ,  MON Company ,  DBA Compny name ,  12-345678901 ,  1010 Isles Dr ,  33193 ,  3053008807 , null, null,  angel@ultconsulting.com , null,  0 ,  0 ,  0 ,  2015-02-09 12:45:53 ,  2015-02-09 12:45:53 ,  0 ,  2 , null,  2 , null,  miami );
INSERT INTO   customerss   VALUES ( 46 ,  Other , null,  11111111111 ,  asd ,  33134 ,  1111111111 , null, null,  angel@ultconsulting.com , null,  0 ,  0 ,  0 ,  2015-02-09 12:55:17 ,  2015-02-09 12:55:17 ,  0 ,  2 , null,  2 , null,  sadasd );
INSERT INTO   customerss   VALUES ( 50 ,  JAJA , null,  11111111111 ,  sadasd ,  33134 ,  1111111111 , null, null,  angel@ultconsulting.com , null,  0 ,  0 ,  0 ,  2015-02-09 13:28:55 ,  2015-02-09 13:28:55 ,  0 ,  2 , null,  2 , null,  kjgjkgjgjk );
INSERT INTO   customerss   VALUES ( 51 ,  Test2015 , null,  12345333333 ,  5044 SW 145 th AVE ,  33175 ,  9542600182 , null, null,  yainierc@yahoo.es , null,  0 ,  0 ,  0 ,  2015-02-09 20:01:46 ,  2015-02-09 20:01:46 ,  0 ,  2 , null,  2 , null,  Miami );
INSERT INTO   customerss   VALUES ( 52 ,  COmpany2112015 , null,  11111111111 ,  5044 SW 145 th AVE ,  33175 ,  7864394806 , null, null,  yainierc84@gmail.com , null,  0 ,  0 ,  0 ,  2015-02-11 20:16:39 ,  2015-02-11 20:16:39 ,  0 ,  2 , null,  2 , null,  Miami );
INSERT INTO   customerss   VALUES ( 53 ,  jjjjjjjj , null,  11111111111 ,  5044 SW 145 th AVE ,  33175 ,  7864394806 , null, null,  jenice_lapeyre@yahoo.es , null,  0 ,  0 ,  0 ,  2015-02-11 21:00:59 ,  2015-02-11 21:00:59 ,  0 ,  2 , null,  2 , null,  Miami );

-- ----------------------------
-- Table structure for customersrelation
-- ----------------------------
DROP TABLE IF EXISTS   customersrelations  ;
CREATE TABLE   customersrelations   (
  id int(11) NOT NULL,
    relationType_id int(11) NOT NULL,
    rreatedOn   datetime NOT NULL,
    rodifiedOn   datetime NOT NULL,
    active   tinyint(4) NOT NULL,
    customers_id int(11) DEFAULT NULL,
    customers1_id int(11) DEFAULT NULL,
    customers2_id int(11) DEFAULT NULL,
    bankaccount_id int(11) DEFAULT NULL,
    bankaccount1_id int(11) DEFAULT NULL,
    bankaccount2_id int(11) DEFAULT NULL,
    bankaccount3_id int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY   bankaccount_id(  bankaccount_id),
  KEY   bankaccount1_id (  bankaccount1_id),
  KEY   bankaccount2_id (  bankaccount2_id),
  KEY   bankaccount3_id (  bankaccount3_id   ),
  KEY   customers_id (  customers_id   ),
  KEY   customers1_id (  customers1_id   ),
  KEY   customers2_id (  customers2_id   ),
  CONSTRAINT   customersrelation_ibfk_1   FOREIGN KEY (  bankaccount_id   ) REFERENCES   bankaccount   (id),
  CONSTRAINT   customersrelation_ibfk_2   FOREIGN KEY (  bankaccount1_id   ) REFERENCES   bankaccount   (id),
  CONSTRAINT   customersrelation_ibfk_3   FOREIGN KEY (  bankaccount2_id   ) REFERENCES   bankaccount   (id),
  CONSTRAINT   customersrelation_ibfk_4   FOREIGN KEY (  bankaccount3_id   ) REFERENCES   bankaccount   (id),
  CONSTRAINT   customersrelation_ibfk_5   FOREIGN KEY (  customers_id   ) REFERENCES   customerss  (id),
  CONSTRAINT   customersrelation_ibfk_6   FOREIGN KEY (  customers1_id   ) REFERENCES   customerss  (id),
  CONSTRAINT   customersrelation_ibfk_7   FOREIGN KEY (  customers2_id   ) REFERENCES   customerss  (id)
) ;

-- ----------------------------
-- Records of customersrelation
-- ----------------------------
INSERT INTO   customersrelations   VALUES ( 1 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  3 ,  4 , null, null, null, null, null);
INSERT INTO   customersrelations  VALUES ( 2 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  3 ,  5 , null, null, null, null, null);
INSERT INTO   customersrelations  VALUES ( 3 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  4 ,  5 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 4 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  3 ,  6 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 5 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  4 ,  6 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 6 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  5 ,  6 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 7 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  3 ,  7 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 8 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  4 ,  7 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 9 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  5 ,  7 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 10 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  6 ,  7 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 11 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  3 ,  8 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 12 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  4 ,  8 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 13 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  5 ,  8 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 14 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  6 ,  8 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 15 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  7 ,  8 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 16 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  3 ,  9 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 17 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  4 ,  9 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 18 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  5 ,  9 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 19 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  6 ,  9 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 20 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  7 ,  9 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 21 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  8 ,  9 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 22 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  3 ,  10 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 23 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  4 ,  10 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 24 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  5 ,  10 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 25 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  6 ,  10 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 26 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  7 ,  10 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 27 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  8 ,  10 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 28 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  9 ,  10 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 29 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  3 ,  11 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 30 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  4 ,  11 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 31 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  5 ,  11 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 32 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  6 ,  11 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 33 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  7 ,  11 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 34 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  8 ,  11 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 35 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  9 ,  11 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 36 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  10 ,  11 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 37 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  3 ,  12 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 38 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  4 ,  12 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 39 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  5 ,  12 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 40 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  6 ,  12 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 41 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  7 ,  12 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 42 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  8 ,  12 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 43 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  9 ,  12 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 44 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  10 ,  12 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 45 ,  1 ,  2013-12-30 21:33:17 ,  2013-12-30 21:33:17 ,  1 ,  11 ,  12 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 46 ,  0 ,  2014-11-11 15:36:24 ,  2014-11-11 15:36:24 ,  1 ,  11 ,  3 , null, null, null, null, null);
INSERT INTO   customersrelations   VALUES ( 47 ,  2 ,  2014-11-25 02:42:56 ,  2014-11-25 02:42:56 ,  1 ,  3 ,  11 , null, null, null, null, null);

-- ----------------------------
-- Table structure for dispute_categorys
-- ----------------------------
DROP TABLE IF EXISTS   dispute_categoryss  ;
CREATE TABLE   dispute_categoryss  (
  id int(11) NOT NULL,
    description   varchar(80) DEFAULT NULL,
    createdOn   datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    active   tinyint(4) NOT NULL,
  PRIMARY KEY (id)
) ;

-- ----------------------------
-- Records of dispute_categorys
-- ----------------------------
INSERT INTO   dispute_categoryss   VALUES ( 1 ,  Inter modal ,  2014-04-01 19:27:57 ,  2014-04-01 19:27:57 ,  1 );
INSERT INTO   dispute_categoryss   VALUES ( 2 ,  Ocean Freight ,  2014-04-01 19:27:57 ,  2014-04-01 19:27:57 ,  1 );
INSERT INTO   dispute_categoryss   VALUES ( 3 ,  Trucking Rail ,  2014-04-01 19:27:57 ,  2014-04-01 19:27:57 ,  1 );

-- ----------------------------
-- Table structure for dispute_reasons
-- ----------------------------
DROP TABLE IF EXISTS   dispute_categoryss  ;
CREATE TABLE   dispute_categoryss   (
  id int(11) NOT NULL,
    description   varchar(80) DEFAULT NULL,
    createdOn   datetime NOT NULL,
    codifiedOn   datetime NOT NULL,
    active   tinyint(4) NOT NULL,
  PRIMARY KEY (id)
) ;

-- ----------------------------
-- Records of dispute_reasons
-- ----------------------------
INSERT INTO   dispute_categoryss   VALUES ( 1 ,  001 - Incorrect Rates ,  2014-04-01 19:27:57 ,  2014-04-01 19:27:57 ,  1 );
INSERT INTO   dispute_categoryss   VALUES ( 2 ,  002 - Incorrect payer ,  2014-11-06 00:00:00 ,  2014-11-06 00:00:00 ,  1 );
INSERT INTO   dispute_categoryss   VALUES ( 3 ,  003 - Already pa_id  ,  2014-11-06 00:00:00 ,  2014-11-06 00:00:00 ,  1 );
INSERT INTO   dispute_categoryss   VALUES ( 4 ,  004 - Missing Information ,  2014-11-06 00:00:00 ,  2014-11-06 00:00:00 ,  1 );
INSERT INTO   dispute_categoryss   VALUES ( 5 ,  005 - Commercial Negotiation ,  2014-11-06 00:00:00 ,  2014-11-06 00:00:00 ,  1 );
INSERT INTO   dispute_categoryss   VALUES ( 6 ,  006 - Legal ,  2014-11-06 00:00:00 ,  2014-11-06 00:00:00 ,  1 );
INSERT INTO   dispute_categoryss   VALUES ( 7 ,  007 - FMC Performance Bond ,  2014-11-06 00:00:00 ,  2014-11-06 00:00:00 ,  1 );

-- ----------------------------
-- Table structure for oceantransactionsdetail
-- ----------------------------
DROP TABLE IF EXISTS   oceantransactionsdetails  ;
CREATE TABLE   oceantransactionsdetails   (
  id int(11) NOT NULL,
    transactions_id int(11) NOT NULL,
    relatedBOL   int(11) DEFAULT NULL,
    departure_date   datetime DEFAULT NULL,
    arrival_date   datetime DEFAULT NULL,
    has_arrived   tinyint(4) DEFAULT NULL,
    direction_id int(11) DEFAULT NULL,
    createdOn   datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    active   tinyint(4) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY   direction_id(  direction_id   ),
  KEY   transactions_id(  transactions_id   ),
  CONSTRAINT   oceantransactionsdetail_ibfk_1   FOREIGN KEY (  direction_id   ) REFERENCES   transactionsdirectionss   (id),
  CONSTRAINT   oceantransactionsdetail_ibfk_2   FOREIGN KEY (  transactions_id   ) REFERENCES   transactions  (id)
) ;

-- ----------------------------
-- Records of oceantransactionsdetail
-- ----------------------------

-- ----------------------------
-- Table structure for pabtask
-- ----------------------------
DROP TABLE IF EXISTS   pabtaska  ;
CREATE TABLE   pabtasks   (
  id int(11) NOT NULL,
    title   varchar(250) NOT NULL,
    completed   tinyint(4) DEFAULT NULL,
    users_id int(11) DEFAULT NULL,
    createdOn   datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    active   tinyint(4) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY   users_id(  users_id   ),
  CONSTRAINT   pabtask_ibfk_1   FOREIGN KEY (  users_id   ) REFERENCES   userss   (id)
) ;

-- ----------------------------
-- Records of pabtask
-- ----------------------------
INSERT INTO   pabtasks   VALUES ( 1 ,  task test#5 ,  0 ,  1 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  1 );
INSERT INTO   pabtasks   VALUES ( 2 ,  test task payor11 ,  0 ,  9 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  1 );
INSERT INTO   pabtasks   VALUES ( 3 ,  test #61234 ,  0 ,  1 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  1 );
INSERT INTO   pabtasks   VALUES ( 5 ,  sfgshshsfd ,  1 ,  1 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  1 );
INSERT INTO   pabtasks   VALUES ( 1003 ,  tesr ,  1 ,  9 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  1 );
INSERT INTO   pabtasks   VALUES ( 1004 ,  test ,  1 ,  9 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  1 );
INSERT INTO   pabtasks   VALUES ( 1005 ,  kk ,  0 ,  1 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  1 );

-- ----------------------------
-- Table structure for paymentmethod
-- ----------------------------
DROP TABLE IF EXISTS   paymentmethods  ;
CREATE TABLE   paymentmethods   (
  id int(11) NOT NULL,
    description   varchar(20) NOT NULL,
    createdOn   datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    active   tinyint(4) NOT NULL,
  PRIMARY KEY (id)
) ;

-- ----------------------------
-- Records of paymentmethod
-- ----------------------------

-- ----------------------------
-- Table structure for registrationqueue
-- ----------------------------
DROP TABLE IF EXISTS   registrationqueues  ;
CREATE TABLE   registrationqueues   (
  id int(11) NOT NULL,
    createdOn   datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    requestIP   longtext,
    status   int(11) NOT NULL,
    processed   datetime NOT NULL,
    users_id int(11) DEFAULT NULL,
    customers_id int(11) DEFAULT NULL,
    active   tinyint(4) NOT NULL,
  PRIMARY KEY (id),
  KEY   customers_id(  customers_id   ),
  KEY   users_id(  users_id   ),
  CONSTRAINT   registrationqueue_ibfk_1   FOREIGN KEY (  customers_id   ) REFERENCES   customerss   (id),
  CONSTRAINT   registrationqueue_ibfk_2   FOREIGN KEY (  users_id   ) REFERENCES   userss   (id)
) ;

-- ----------------------------
-- Records of registrationqueue
-- ----------------------------

-- ----------------------------
-- Table structure for state
-- ----------------------------
DROP TABLE IF EXISTS   states  ;
CREATE TABLE   state   (
  id int(11) NOT NULL,
    name   longtext NOT NULL,
    country_id int(11) DEFAULT NULL,
    createdOn   datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    active   tinyint(4) NOT NULL,
  PRIMARY KEY (id),
  KEY   country_id(  country_id   ),
  CONSTRAINT   state_ibfk_1   FOREIGN KEY (  country_id   ) REFERENCES   countrys   (id)
) ;

-- ----------------------------
-- Records of state
-- ----------------------------
INSERT INTO   states   VALUES ( 2 ,  FL ,  2 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 );
INSERT INTO   states   VALUES ( 3 ,  CA ,  2 ,  2014-11-09 00:00:00 ,  2014-11-09 00:00:00 ,  1 );
INSERT INTO   states   VALUES ( 4 ,  NC ,  2 ,  2014-11-09 00:00:00 ,  2014-11-09 00:00:00 ,  1 );

-- ----------------------------
-- Table structure for sysdiagrams
-- ----------------------------
DROP TABLE IF EXISTS   sysdiagrams  ;
CREATE TABLE   sysdiagrams   (
    name   varchar(0) NOT NULL,
    principal_id int(11) NOT NULL,
    diagram_id int(11) NOT NULL,
    version   int(11) DEFAULT NULL,
    definition   longblob,
  PRIMARY KEY (  diagram_id)
) ;

-- ----------------------------
-- Records of sysdiagrams
-- ----------------------------
INSERT INTO   sysdiagrams   VALUES (  ,  1 ,  1 ,  1 , 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000000200000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF14000000FEFFFFFF0400000005000000060000001300000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000FEFFFFFF1F000000FEFFFFFF160000001700000018000000190000001A0000001B0000001C0000001D0000001E000000FEFFFFFF20000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000506917F35537D00103000000800C0000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000000000000D6070000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000070000006416000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000200000005F000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F000000FEFFFFFF21000000FEFFFFFFFEFFFFFF2400000025000000260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F00000030000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000434000A1E500C05000080250000000F00FFFF6E00000025000000007D0000E66E0000413C0000DF81000022810000DEC7FFFF35550000DE805B10F195D011B0A000AA00BDCB5C000008003000000000020000030000003C006B0000000900000000000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D00002800430000000000000053444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C00002800430000000000000051444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C16000000E00600000096010000003800A50900000700008002000000B2020000008000001000008053636847726964000ED4FFFF18600000437573746F6D657252656C6174696F6E00008000A50900000700008003000000620000000180000057000080436F6E74726F6C00F7E7FFFF335F000052656C6174696F6E736869702027464B5F5F437573746F6D6572525F5F437573746F5F5F323237353146364327206265747765656E2027437573746F6D65722720616E642027437573746F6D657252656C6174696F6E270000002800B50100000700008004000000310000006F00000002800000436F6E74726F6C0045DAFFFF6874000000008000A50900000700008005000000620000000180000057000080436F6E74726F6C00F7E7FFFF335F000052656C6174696F6E736869702027464B5F5F437573746F6D6572525F5F437573746F5F5F323336393433413527206265747765656E2027437573746F6D65722720616E642027437573746F6D657252656C6174696F6E270000002800B50100000700008006000000310000006F00000002800000436F6E74726F6C00B0EFFFFF6571000000008000A50900000700008007000000620000000180000057000080436F6E74726F6C00F7E7FFFF335F000052656C6174696F6E736869702027464B5F5F437573746F6D6572525F5F437573746F5F5F323435443637444527206265747765656E2027437573746F6D65722720616E642027437573746F6D657252656C6174696F6E270000002800B50100000700008008000000310000006F00000002800000436F6E74726F6C00B0EFFFFF1A71000000002C00A509000007000080090000009A02000000800000040000805363684772696400C2010000162600005573657200007400A5090000070000800A00000052000000018000004B000080436F6E74726F6C00070600009B40000052656C6174696F6E736869702027464B5F5F557365725F5F437573746F6D657249645F5F334631313545314127206265747765656E2027437573746F6D65722720616E64202755736572270000002800B5010000070000800B000000310000006F00000002800000436F6E74726F6C004D0800004148000000003800A5090000070000800E000000AE020000008000000E00008053636847726964009C1800003A6B000057656270616765735F526F6C6573000000004000A5090000070000800F000000BC02000000800000150000805363684772696400061800007A58000077656270616765735F5573657273496E526F6C657301000000008000A50900000700008010000000620000000180000058000080436F6E74726F6C00AD1400009F40000052656C6174696F6E736869702027464B5F5F77656270616765735F5F5F55736572495F5F343030353832353327206265747765656E2027557365722720616E64202777656270616765735F5573657273496E526F6C65732700002800B50100000700008011000000310000006F00000002800000436F6E74726F6C00FD0300008F56000000008C00A50900000700008012000000520000000180000062000080436F6E74726F6C0091210000765F000052656C6174696F6E736869702027464B5F5F77656270616765735F5F5F526F6C65495F5F343046394136384327206265747765656E202757656270616765735F526F6C65732720616E64202777656270616765735F5573657273496E526F6C657327000000002800B50100000700008013000000310000006F00000002800000436F6E74726F6C00D7230000B369000000003C00A50900000700008014000000B40200000080000011000080536368477269640088E1FFFF26340000526567697374726174696F6E517565756500000000008000A50900000700008015000000620000000180000058000080436F6E74726F6C00BFF4FFFF8549000052656C6174696F6E736869702027464B5F5F5265676973747261745F5F437573746F5F5F323832444638433227206265747765656E2027437573746F6D65722720616E642027526567697374726174696F6E51756575652700002800B50100000700008016000000310000006F00000002800000436F6E74726F6C002EFAFFFF074B000000007C00A50900000700008017000000520000000180000054000080436F6E74726F6C00BFF4FFFF2533000052656C6174696F6E736869702027464B5F5F5265676973747261745F5F55736572495F5F323932323143464227206265747765656E2027557365722720616E642027526567697374726174696F6E51756575652700002800B50100000700008018000000310000006F00000002800000436F6E74726F6C006FF2FFFFB532000000003000A50900000700008001000000A20200000080000008000080536368477269640012FDFFFF844E0000437573746F6D65720000000000000000000000000000000000000000000000000000000000000000000000000000000000002143341208000000151500006B1F000078563412070000001401000043007500730074006F006D0065007200520065006C006100740069006F006E0000002A864886F70D0101050500038181005B4A21D6C2F04E4FF9B997DC5C933E1426C109E70DDBF17D7490B22D8702DD962E59BE11DA69E0A86A821277C055700A533CF4E8428EF530387E960C44438C09F76A38E0C8D9EDCCCFA0FFAC4A69426ACAEE802A304F5DC609F6E1E05C81205D8AC75CBB71B8E4A03440FB72826EFA6DABA5146B8E07C6C3EFDB6F8B3A20341F000000000000000800000008000000040000000000000000000000000000000B000000100000000C00000000000000E70EF891EEBC08E7682F13B80000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000096240000DE200000000000002D0100000D0000000C000000070000001C010000BC070000540600001B030000DE030000B202000038040000CD05000075030000CD050000530700000A0500000000000001000000151500006B1F0000000000000C0000000C00000002000000020000001C0100009C0900000000000001000000C71100007714000000000000080000000800000002000000020000001C010000BC0700000100000000000000C7110000ED03000000000000000000000000000002000000020000001C010000BC0700000000000000000000072C0000DE20000000000000000000000D00000004000000040000001C010000BC07000024090000A005000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000001100000043007500730074006F006D0065007200520065006C006100740069006F006E00000004000B0012FDFFFF907E000001EFFFFF907E000001EFFFFFAE60000023E9FFFFAE6000000000000002000000F0F0F0000000000000000000000000000000000001000000040000000000000045DAFFFF687400000D14000058010000320000000100000200000D14000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F005F0043007500730074006F006D006500720052005F005F0043007500730074006F005F005F003200320037003500310046003600430004000B0012FDFFFFFA7D000001EFFFFFFA7D000001EFFFFFAE60000023E9FFFFAE6000000000000002000000F0F0F00000000000000000000000000000000000010000000600000000000000B0EFFFFF657100000D14000058010000320000000100000200000D14000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F005F0043007500730074006F006D006500720052005F005F0043007500730074006F005F005F003200330036003900340033004100350004000B0012FDFFFF647D000001EFFFFF647D000001EFFFFFAE60000023E9FFFFAE6000000000000002000000F0F0F00000000000000000000000000000000000010000000800000000000000B0EFFFFF1A7100002A14000058010000320000000100000200002A14000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F005F0043007500730074006F006D006500720052005F005F0043007500730074006F005F005F0032003400350044003600370044004500214334120800000015150000401D00007856341207000000140100005500730065007200000000002800530045004C0045004300540020006E0061006D0065002C002000760061006C00750065002000460052004F004D0020007300790073002E0065007800740065006E006400650064005F00700072006F0070006500720074006900650073002000570048004500520045002000280063006C0061007300730020003D00200031002900200041004E004400200028006D0069006E006F0072005F006900640020003D00200030002900200041004E004400200028006D0061006A006F0072005F006900640020003D0020004F0042004A004500430054005F004900440028004E00000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000096240000DE200000000000002D0100000D0000000C000000070000001C010000BC070000540600001B030000DE030000B202000038040000CD05000075030000CD050000530700000A050000000000000100000015150000401D0000000000000B0000000B00000002000000020000001C0100008D0900000000000001000000C71100001008000000000000020000000200000002000000020000001C010000BC0700000100000000000000C7110000ED03000000000000000000000000000002000000020000001C010000BC0700000000000000000000072C0000DE20000000000000000000000D00000004000000040000001C010000BC07000024090000A005000078563412040000005200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000050000005500730065007200000002000B009E070000844E00009E070000564300000000000002000000F0F0F00000000000000000000000000000000000010000000B000000000000004D08000041480000B61300005801000032000000010000020000B613000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F005F0055007300650072005F005F0043007500730074006F006D0065007200490064005F005F0033004600310031003500450031004100214334120800000015150000B7090000785634120700000014010000570065006200700061006700650073005F0052006F006C0065007300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000009624000077140000000000002D010000070000000C000000070000001C010000BC070000540600001B030000DE030000B202000038040000CD05000075030000CD050000530700000A050000000000000100000015150000B709000000000000020000000200000002000000020000001C0100008D0900000000000001000000C7110000FF05000000000000010000000100000002000000020000001C010000BC0700000100000000000000C7110000ED03000000000000000000000000000002000000020000001C010000BC0700000000000000000000072C0000DE20000000000000000000000D00000004000000040000001C010000BC07000024090000A005000078563412040000006600000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000F000000570065006200700061006700650073005F0052006F006C006500730000002143341208000000D7160000B7090000785634120700000014010000770065006200700061006700650073005F005500730065007200730049006E0052006F006C006500730000000000000022EC0000AE0E000022EC000000000000B8EC0000AE0E0000B8EC0000000000004EED0000AE0E00004EED000000000000E4ED0000AE0E0000E4ED0000000000007AEE0000AE0E00007AEE00000000000010EF0000AE0E000010EF000000000000A6EF0000AE0E0000A6EF0000000000003CF00000AE0E00003CF0000000000000D2F00000AE0E0000D2F000000000000068F10000AE0E000068F1000000000000FEF10000AE0E0000FEF100000000000094F20000AE0E000094F200000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000009624000077140000000000002D010000070000000C000000070000001C010000BC070000540600001B030000DE030000B202000038040000CD05000075030000CD050000530700000A0500000000000001000000D7160000B709000000000000020000000200000002000000020000001C0100009B0A00000000000001000000C71100001008000000000000020000000200000002000000020000001C010000BC0700000100000000000000C7110000ED03000000000000000000000000000002000000020000001C010000BC0700000000000000000000072C0000DE20000000000000000000000D00000004000000040000001C010000BC07000024090000A005000078563412040000007400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000016000000770065006200700061006700650073005F005500730065007200730049006E0052006F006C0065007300000004000B00441600005643000044160000E84D00009C180000E84D00009C1800007A5800000000000002000000F0F0F00000000000000000000000000000000000010000001100000000000000FD0300008F560000F01300005801000061000000010000020000F013000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F005F00770065006200700061006700650073005F005F005F00550073006500720049005F005F003400300030003500380032003500330002000B00282300003A6B000028230000316200000000000002000000F0F0F00000000000000000000000000000000000010000001300000000000000D7230000B36900000D14000058010000020000000100000200000D14000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611E0046004B005F005F00770065006200700061006700650073005F005F005F0052006F006C00650049005F005F0034003000460039004100360038004300214334120800000063140000DE17000078563412070000001401000052006500670069007300740072006100740069006F006E005100750065007500650000006C0074007500720065003D006E00650075007400720061006C002C0020005000750062006C00690063004B006500790054006F006B0065006E003D0062003000330066003500660037006600310031006400350030006100330061000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C000000340000000000000000000000CA270000A11C0000000000002D0100000B0000000C000000070000001C0100007F080000F90600001B030000DE030000B2020000A1040000CD05000075030000CD050000530700000A050000000000000100000063140000DE17000000000000090000000900000002000000020000001C0100003309000000000000010000001F130000210A000000000000030000000300000002000000020000001C0100007F08000001000000000000001F130000ED03000000000000000000000000000002000000020000001C0100007F08000000000000000000000F300000C320000000000000000000000D00000004000000040000001C0100007F080000140A00003606000078563412040000006C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000001200000052006500670069007300740072006100740069006F006E0051007500650075006500000004000B0012FDFFFF1A4F00007FF9FFFF1A4F00007FF9FFFF004B0000EBF5FFFF004B00000000000002000000F0F0F000000000000000000000000000000000000100000016000000000000002EFAFFFF074B00002613000058010000320000000100000200002613000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611E0046004B005F005F005200650067006900730074007200610074005F005F0043007500730074006F005F005F003200380032004400460038004300320002000B00C2010000BC340000EBF5FFFFBC3400000000000002000000F0F0F000000000000000000000000000000000000100000018000000000000006FF2FFFFB5320000D01200005801000032000000010000020000D012000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611E0046004B005F005F005200650067006900730074007200610074005F005F00550073006500720049005F005F0032003900320032003100430046004200214334120800000015150000C830000078563412070000001401000043007500730074006F006D006500720000000000000000000000000000000000000000000000000000001800010000000200000002000000FFFFFFFFFFFFFFFF080000000400000000000000CABEC1D8C734D001020000000A010A1100000000000000000000000000000000000000000000000000000000000047000D00000003000000030000004F2409004F24090018000000040000000000000034D404D9C834D00102000000A9FE987F00000000000000000000000000000000000000000000000000000006000047000E0000000200000004000000FFFFFFFFFFFFFFFF10000000010000000E0000000341000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000096240000DE200000000000002D0100000D0000000C000000070000001C010000BC070000540600001B030000DE030000B202000038040000CD05000075030000CD050000530700000A050000000000000100000015150000C830000000000000140000000C00000002000000020000001C0100008D0900000000000001000000C7110000320C000000000000040000000400000002000000020000001C010000BC0700000100000000000000C7110000ED03000000000000000000000000000002000000020000001C010000BC0700000000000000000000072C0000DE20000000000000000000000D00000004000000040000001C010000BC07000024090000A005000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000900000043007500730074006F006D00650072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B271000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F5739000002004050EBF25537D001020200001048450000000000000000000000000000000000720100004400610074006100200053006F0075007200630065003D0048004F004D0045005C00530051004C0045005800500052004500530053003B0049006E0069007400690061006C00200043006100740061006C006F0067003D0070006100790061006E007900620069007A003B0049006E00740065006700720061007400650064002000530065006300750072006900740079003D0054007200750065003B004D0075006C007400690070006C00650041006300740069007600650052006500730075006C00740053006500740073003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C0069000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000150000000A1200000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000220000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000023000000520300000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000003100000012000000000000000C000000DEC7FFFF355500000100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000010000000100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0031003900380030002C0031002C0031003600320030002C0035002C0031003000380030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003400340035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0031003900380030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0031003900380030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0031003900380030002C00310032002C0032003300340030002C00310031002C0031003400340030000000020000000200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0031003900380030002C0031002C0031003600320030002C0035002C0031003000380030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003400360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0031003900380030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0031003900380030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0031003900380030002C00310032002C0032003300340030002C00310031002C00310034003400300000000300000003000000000000004E00000001D6155101000000640062006F00000046004B005F005F0043007500730074006F006D006500720052005F005F0043007500730074006F005F005F003200320037003500310046003600430000000000000000000000C40200000000040000000400000003000000080000000185CF0A0085CF0A0000000000000000AD0700000000000500000005000000000000004E00000001143F7301000000640062006F00000046004B005F005F0043007500730074006F006D006500720052005F005F0043007500730074006F005F005F003200330036003900340033004100350000000000000000000000C40200000000060000000600000005000000080000000184CF0AC084CF0A0000000000000000AD0700000000000700000007000000000000004E00000001143F7301000000640062006F00000046004B005F005F0043007500730074006F006D006500720052005F005F0043007500730074006F005F005F003200340035004400360037004400450000000000000000000000C40200000000080000000800000007000000080000000180CF0A8080CF0A0000000000000000AD070000000000090000000900000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0031003900380030002C0031002C0031003600320030002C0035002C0031003000380030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003400340035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0031003900380030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0031003900380030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0031003900380030002C00310032002C0032003300340030002C00310031002C00310034003400300000000A0000000A000000000000004E00000001D6155101000000640062006F00000046004B005F005F0055007300650072005F005F0043007500730074006F006D0065007200490064005F005F003300460031003100350045003100410000000000000000000000C402000000000B0000000B0000000A00000008000000017FCF0A407FCF0A0000000000000000AD0700000000000E0000000E00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0031003900380030002C0031002C0031003600320030002C0035002C0031003000380030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003400340035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0031003900380030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0031003900380030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0031003900380030002C00310032002C0032003300340030002C00310031002C00310034003400300000000F0000000F00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0031003900380030002C0031002C0031003600320030002C0035002C0031003000380030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700310035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0031003900380030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0031003900380030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0031003900380030002C00310032002C0032003300340030002C00310031002C00310034003400300000001000000010000000000000004E00000001143F7301000000640062006F00000046004B005F005F00770065006200700061006700650073005F005F005F00550073006500720049005F005F003400300030003500380032003500330000000000000000000000C40200000000110000001100000010000000080000000184CF0A4084CF0A0000000000000000AD0700000000001200000012000000000000004E00000001D6155101000000640062006F00000046004B005F005F00770065006200700061006700650073005F005F005F0052006F006C00650049005F005F003400300046003900410036003800430000000000000000000000C40200000000130000001300000012000000080000000184CF0A8084CF0A0000000000000000AD070000000000140000001400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003100370035002C0031002C0031003700380035002C0035002C0031003100380035000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300350035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003100370035000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003100370035000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003100370035002C00310032002C0032003500380030002C00310031002C00310035003900300000001500000015000000000000004E0000000100350001000000640062006F00000046004B005F005F005200650067006900730074007200610074005F005F0043007500730074006F005F005F003200380032004400460038004300320000000000000000000000C40200000000160000001600000015000000080000000186CF0A0086CF0A0000000000000000AD0700000000001700000017000000000000004E0000000100350001000000640062006F00000046004B005F005F005200650067006900730074007200610074005F005F00550073006500720049005F005F003200390032003200310043004600420000000000000000000000C40200000000180000001800000017000000080000000185CF0A4085CF0A0000000000000000AD07000000000028000000030000000100000002000000E800000047000000050000000100000002000000E600000047000000070000000100000002000000E4000000470000000A00000001000000090000002200000013000000150000000100000014000000460000009100000010000000090000000F00000045000000000000001700000009000000140000007600000045000000120000000E0000000F00000022000000250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F002200000000800500140000004400690061006700720061006D005F0030000000000226002400000052006500670069007300740072006100740069006F006E0051007500650075006500000008000000640062006F000000000226002C000000770065006200700061006700650073005F005500730065007200730049006E0052006F006C0065007300000008000000640062006F000000000226001E000000570065006200700061006700650073005F0052006F006C0065007300000008000000640062006F000000000226000A0000005500730065007200000008000000640062006F000000000226002200000043007500730074006F006D0065007200520065006C006100740069006F006E00000008000000640062006F000000000224001200000043007500730074006F006D0065007200000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214);

-- ----------------------------
-- Table structure for table
-- ----------------------------
DROP TABLE IF EXISTS   tables  ;
CREATE TABLE   table   (
  id int(11) NOT NULL,
  PRIMARY KEY (id)
) ;

-- ----------------------------
-- Records of table
-- ----------------------------

-- ----------------------------
-- Table structure for transactions
-- ----------------------------
DROP TABLE IF EXISTS   transactions  ;
CREATE TABLE   transactions  (
  id int(11) NOT NULL,
    biz_area_id int(11) DEFAULT NULL,
    recordtype   int(11) DEFAULT NULL,
    Number   varchar(20) DEFAULT NULL,
    relatedNumber   varchar(20) DEFAULT NULL,
    receiver   varchar(100) DEFAULT NULL,
    creator   varchar(100) DEFAULT NULL,
    transactions_types_id int(11) DEFAULT NULL,
    departure_date   datetime DEFAULT NULL,
    arrival_date   datetime DEFAULT NULL,
    due_date   datetime DEFAULT NULL,
    currency_id int(11) DEFAULT NULL,
    amount   decimal(19,4) DEFAULT NULL,
    description   longtext,
    transactions_status_id int(11) DEFAULT NULL,
    payorRefNumber   varchar(20) DEFAULT NULL,
    biller_id int(11) DEFAULT NULL,
    payor_id int(11) DEFAULT NULL,
    users_id int(11) DEFAULT NULL,
    createdOn   datetime DEFAULT NULL,
    modifiedOn   datetime DEFAULT NULL,
    active   tinyint(4) NOT NULL,
    disputed_admount   decimal(19,4) DEFAULT NULL,
    disputedRefNumber   varchar(20) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY   biz_area_id(  biz_area_id   ),
  KEY   currency_id(  currency_id   ),
  KEY   transactions_status_id(  transactions_status_id   ),
  KEY   transactions_types_id(  transactions_types_id   ),
  KEY   users_id(  users_id   ),
  KEY   IX_transactions_biller   (  biller_id   ),
  KEY   IX_transactions_payor   (  payor_id   ),
  CONSTRAINT   transactions_ibfk_1   FOREIGN KEY (  biller_id   ) REFERENCES   customerss  (id),
  CONSTRAINT   transactions_ibfk_2   FOREIGN KEY (  biz_area_id   ) REFERENCES   biz_area   (id),
  CONSTRAINT   transactions_ibfk_3   FOREIGN KEY (  currency_id   ) REFERENCES   transactions_currencyss   (id),
  CONSTRAINT   transactions_ibfk_4   FOREIGN KEY (  payor_id   ) REFERENCES   customerss  (id),
  CONSTRAINT   transactions_ibfk_5   FOREIGN KEY (  transactions_status_id   ) REFERENCES   transactions_status   (id),
  CONSTRAINT   transactions_ibfk_6   FOREIGN KEY (  transactions_types_id   ) REFERENCES   transactions_types   (id),
  CONSTRAINT   transactions_ibfk_7   FOREIGN KEY (  users_id   ) REFERENCES   users   (id)
) ;

-- ----------------------------
-- Records of transactions
-- ----------------------------
INSERT INTO   transactions  VALUES ( 3 ,  1 ,  1 ,  OCN-0001 ,  REL-O-001 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  897.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 4 ,  2 ,  1 ,  AIR-0001 ,  REL-0999 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  51.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2014-10-20 22:15:25 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 5 ,  3 ,  1 ,  TRUCK-001 ,  REL-3344 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  570.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 6 ,  2 ,  1 ,  AIR-02 ,  REL-444 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  525.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 7 ,  1 ,  1 ,  ARJGS4M7SE2GWX ,  EJBWURYCEIK3XYE ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-12 00:00:00 ,  2013-11-24 00:00:00 , null,  994.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  11 ,  1 ,  2013-09-09 00:00:00 ,  2014-04-16 02:10:59 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 8 ,  2 ,  1 ,  0BYBLGXZETPXDN ,  FFFFADM2JSTLY7 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  709.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 9 ,  3 ,  1 ,  TFGGCIEADQIIORU ,  J07X9GUIVIX8SY , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  494.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2014-07-15 11:26:23 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 10 ,  2 ,  1 ,  32KQZKGGYF ,  ZNVLYNHQ6SGH , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  718.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 11 ,  1 ,  1 ,  OE1E82SSGWEFZU ,  CXXYR72MLAD9HRJ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  427.0000 ,  TXN-001 ,  1 ,  REF-2001-12 ,  3 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2014-04-16 02:14:30 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 12 ,  4 ,  1 ,  20AIPFRKGX1FKV ,  OTPKEQEFWACDI3 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  582.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 13 ,  3 ,  1 ,  KZL0KPJRHCQIPXX ,  67DHO9IZ26IZJH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  290.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 14 ,  2 ,  1 ,  UC8RVSIJAG ,  UTAHYONHFOD3 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  928.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 15 ,  1 ,  1 ,  LJZPFZWJWBKGVON ,  M2MG9XHYLZYUJTR ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  399.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 16 ,  2 ,  1 ,  S1PXUC5LBVVHFLN ,  NMFTCSUPVOFHJ9E ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  739.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 17 ,  3 ,  1 ,  O3TXXEO4N9TRI7O ,  AL1SF6VEGY4QVNP , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  753.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 18 ,  2 ,  1 ,  NAQBBFUZCUF21MZ ,  UV8ZDSZYTE4WL2L , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  748.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 19 ,  1 ,  1 ,  XW0F9SGUCPYYSE ,  WFEJFSKAW7RAEXT ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  441.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 20 ,  2 ,  1 ,  WCWHVG00I4JRJD ,  9SG32MQBSULQFS ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  259.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 21 ,  3 ,  1 ,  KMBURPHG17XQZII ,  JKLQBKLZRLNDO4 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  295.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 22 ,  2 ,  1 ,  Z8THSQZSFT ,  HD5OYWABEXFL , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  516.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 23 ,  1 ,  1 ,  5CL5XORLQR0PSRZ ,  PJUMXKSAHLH6PMG ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  829.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 24 ,  2 ,  1 ,  CYSFKA5UOE7ZQTE ,  XGYALWIABS5ETSH ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  972.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 25 ,  3 ,  1 ,  XXZ41PHFC0JQ9JK ,  Z4NDQRBAL6BWGJZ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  333.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 26 ,  2 ,  1 ,  8EH0FBKRTSNGXRZ ,  KIYEI7PKRZVNLZ9 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  268.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 27 ,  1 ,  1 ,  PIY1CLIRNPQPH7Z ,  0TEJ4ZDVS8CMADI ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  77.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 28 ,  2 ,  1 ,  CWOFTJCJLJZNCBM ,  DD8FZMBNKEYTN2F ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  286.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 29 ,  3 ,  1 ,  XHKFKJ8BXVYRQCS ,  TVMJ7LGWISQQMRP , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  920.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 30 ,  2 ,  1 ,  YMH6ASMDTRMRYOV ,  HZVSEWY9HINLNN5 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  871.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 31 ,  1 ,  1 ,  AZH9MDSME9A3MDS ,  GWS2XGTOSSZILT6 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  744.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 32 ,  2 ,  1 ,  BUXYF8JYXGZOYF6 ,  EKOOZCKRJY8UG7H ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  211.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 33 ,  3 ,  1 ,  MBX1RIWQ3VL9TTJ ,  TG4DPADHTALL7LA , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  475.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 34 ,  2 ,  1 ,  NOPMS1GD76OPCVD ,  ECGWHWEUZRXPFEP , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  152.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 35 ,  1 ,  1 ,  QSMKPF0AFGO7M8 ,  20FFF2HBILQ1NWZ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  296.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 36 ,  2 ,  1 ,  1VLBZBLTBEC12H ,  DKPJ5PTCRXEY6F ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  428.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 37 ,  3 ,  1 ,  OERE7AQ3I3TP3N4 ,  GVS1WAZ5INTIE0 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  646.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 38 ,  2 ,  1 ,  ONF8N36KMG ,  L8GQOPNF6JYS , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  242.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 39 ,  1 ,  1 ,  FX0PRSPKDUW1YKQ ,  F2VF4PI5SOUJ7K8 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  264.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 40 ,  2 ,  1 ,  MZQB1UOE79TV4AN ,  KLLUNOYILBFIZVC ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  963.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 41 ,  3 ,  1 ,  PYAAZVPAHZECDDU ,  ZVQP6E8OQFE1HHE , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  408.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 42 ,  2 ,  1 ,  OMINXAAU9G7FLF5 ,  ZIAOXZGNM8BGTXR , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  738.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 43 ,  1 ,  1 ,  RYEZTP8FJWNQWWD ,  3YVPHMFASMQABSM ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  849.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 44 ,  2 ,  1 ,  KFJCNB0VOWVEIAA ,  IRNTUGIHBVNR9OR ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  534.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 45 ,  3 ,  1 ,  1R6UKPNK6KOJNYK ,  YKD7OXOMGGKNADS , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  691.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 46 ,  2 ,  1 ,  XBP0KPNCL8NO4XN ,  EJHP7VIQ6SI5A0P , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  688.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 47 ,  1 ,  1 ,  XTP4F9LEQ2ZK86V ,  LBLT63EBW83V5AU ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  425.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 48 ,  2 ,  1 ,  KANUWDV0E3IPTZO ,  HLXUQZKODNDYFFG ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  237.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 49 ,  3 ,  1 ,  VRQJDDWH1KQYXNX ,  CSRV5LXFGCPDYEX , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  348.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 50 ,  2 ,  1 ,  YBC0AULKC3H9OBM ,  EU5VXYPZFODZXTI , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  770.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 51 ,  1 ,  1 ,  WOP0D0PARI87MHA ,  RHZI6IEELN092CX ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  111.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 52 ,  2 ,  1 ,  WFYNF7RG7YW2AOW ,  YALU50UWUPLD6WX ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  445.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 53 ,  3 ,  1 ,  GITFDJMIM8YBKNN ,  50KGUACJNKNIWG7 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  572.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 54 ,  2 ,  1 ,  THBI0EEYMPTDGCQ ,  FFECQ99IULNZOBE , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  403.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 55 ,  1 ,  1 ,  CIQKLDIWYH9XGAY ,  BYRGEHZYXJD0EVR ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  332.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 56 ,  2 ,  1 ,  Y0AOGLR2BFV3JMY ,  JL0WO2QSZB0LQCK ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  678.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 57 ,  3 ,  1 ,  WOR6GVVV1IZQ0ND ,  BPWBT2VXR9CJMHM , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  785.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 58 ,  2 ,  1 ,  PQSKTGGLBHE5HSQ ,  CZAY8KHBQJB40L4 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  620.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 59 ,  1 ,  1 ,  NDITOORI9MCIUT6 ,  EWFBQLAVHVXVI9S ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  198.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 60 ,  2 ,  1 ,  BQJKDXRFX3XWD70 ,  GNDYL6US1TUF9XP ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  617.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 61 ,  3 ,  1 ,  LNLHFAUH80MZHYT ,  MIEXATPIA7JYDE8 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  430.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 62 ,  2 ,  1 ,  LWQ9CFAUQCWIYNW ,  FPHHP6CLRNG33TT , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  732.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 63 ,  1 ,  1 ,  QTWGS7VKLCHGI5Q ,  VCVXYIKRYVYM5WN ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  927.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 64 ,  2 ,  1 ,  PHXAYUNGQUEZGZQ ,  QETNU7759PKHNS2 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  473.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 65 ,  3 ,  1 ,  URTYKNUHL7ADSYU ,  2MU4189USH4AI1S , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  418.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 66 ,  2 ,  1 ,  RR6IRLPMS5LNZ4R ,  FJN8ZBVZ0JCAY4J , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  810.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 67 ,  1 ,  1 ,  NABINCZUJWIXRU ,  TQBP12YGBTDNMMO ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  728.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 68 ,  2 ,  1 ,  OOGQFS33TW6C2J ,  UBAXEN3CQBA9JH ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  292.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 69 ,  3 ,  1 ,  T3131BYPQZR0H2V ,  3M2FLWFBAVPRK4 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  522.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 70 ,  2 ,  1 ,  27346YWAAF ,  ULABIPKNVDIQ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  137.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 71 ,  1 ,  1 ,  OLNKQTU4QEWP2Q2 ,  88DKMMECPWSZMPR ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  407.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 72 ,  2 ,  1 ,  WFFLXWTWQT6EYE9 ,  MHZOVVAHNCBBWZW ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  16.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 73 ,  3 ,  1 ,  7HLTFBJ9H0TH4ZQ ,  6DUJPDPN1WF2GMH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  377.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 74 ,  2 ,  1 ,  ITF0TJMBPDZUFSF ,  IMDDGRSOMVJOHR7 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  690.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 75 ,  1 ,  1 ,  DRVULFBFSGM2XFM ,  8NK03LG8THBSODK ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  164.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 76 ,  2 ,  1 ,  BWTFS16OU4PLUPF ,  77IBBKSJJAUE75A ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  333.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 77 ,  3 ,  1 ,  Z8OCSNL8MXFYCA1 ,  ZRZYW4PNO9YQGDA , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  686.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 78 ,  2 ,  1 ,  AIBDAWSJKB8JYX4 ,  R6ZCDFLCUZEN09X , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  44.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 79 ,  1 ,  1 ,  VE5JHYYF53DNDVM ,  ZS437XYUTOR3B9K ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  108.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 80 ,  2 ,  1 ,  LQ7CH0RYPPRR0WE ,  KZ5J95VLGSLOLRU ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  889.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 81 ,  3 ,  1 ,  NGHHRNF5GEIG0TP ,  CIAWXTLY9EU5BBY , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  298.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 82 ,  2 ,  1 ,  TJRYTKUWUN9EGHS ,  LQC8LESOO1VI14K , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  689.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 83 ,  1 ,  1 ,  EDEVVDMMEKVM7NV ,  3OUJQD7UENVAJS0 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  129.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 84 ,  2 ,  1 ,  XXZOAPLFQQJFVVU ,  ABNRDBTJXFR53XD ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  145.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 85 ,  3 ,  1 ,  YAZGOATTR8KE8PW ,  K3BPIRY2ZY2TVWU , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  953.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 86 ,  2 ,  1 ,  SBPSLYJJ6HMGEUC ,  BDR3JJBION3OGTZ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  724.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 87 ,  1 ,  1 ,  PEEV4MWYEJFMH4Y ,  WAIEPUX92BSSUCF ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  823.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 88 ,  2 ,  1 ,  NKRC3YMBVDPFF7U ,  LYTYGWVCAEEACV5 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  955.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 89 ,  3 ,  1 ,  KEXQOIUVJHJGUAC ,  EFPAGO0IVA5V1EL , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  969.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 90 ,  2 ,  1 ,  RERDBHYHJKNINOD ,  GDKNKLYZQY21EGW , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  947.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 91 ,  1 ,  1 ,  TGGY0GPUSFEDV7N ,  U2OJWMRYPZWTZKG ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  998.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 92 ,  2 ,  1 ,  7GP3N3QLS4J8XZQ ,  CVYZ7EXEPMBFMC3 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  103.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 93 ,  3 ,  1 ,  9HKXLNGUMJ0TKZS ,  W4TCP7ACLXFEWFT , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  123.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 94 ,  2 ,  1 ,  5GQELKQLZODXT7H ,  FWSX3H39017USLN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  198.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 95 ,  1 ,  1 ,  SUNDW39MQMYRVA4 ,  SNGOGXF4PIZ6LIY ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  41.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 96 ,  2 ,  1 ,  ZYEPOJOTKJ2H67T ,  XFR4XL6WRCXJOSN ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  12.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 97 ,  3 ,  1 ,  5T96WZ1HGRLKLHH ,  4NBGZXP1ZESJZ8A , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  663.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 98 ,  2 ,  1 ,  7UUZCM6DW48UFN4 ,  HPSONQFMSKOTW0S , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  559.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 99 ,  1 ,  1 ,  QNMUSWRYBS2Y1L3 ,  NWKWCJN9HW4Y1VQ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  859.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 100 ,  2 ,  1 ,  QKXOE7XOKXOVDZE ,  NZCZ0KB2EAXYOOP ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  717.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 101 ,  3 ,  1 ,  HCUCZNMLDQYJGKV ,  BWRKIWSVHCQ4NQW , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  639.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 102 ,  2 ,  1 ,  YKKIPOHDKWGJPZI ,  MDBNFLRB5UPAQCU , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  738.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 103 ,  1 ,  1 ,  WL5I5K5OADSOPYT ,  SAZYYYO9HA2TPUZ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  52.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 104 ,  2 ,  1 ,  RRIVGNGUAED7AOS ,  5B57UOLCXFGLKAY ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  68.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 105 ,  3 ,  1 ,  ROQXKAE10MSRUIB ,  EFZVPE9JU5N0JZR , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  589.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 106 ,  2 ,  1 ,  G5TGRNV4MXDE0TF ,  B5_id 7GRXUAK5VUR , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  150.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 107 ,  2 ,  1 ,  7BBO8VPYROONGRP ,  WOIBTHF4NLYUKUO ,  Test Rcv ,  Crt ,  2 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  532.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 108 ,  2 ,  1 ,  D5WKG0BZBBQ3U8V ,  PSD5NFHFETAQAPW ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  602.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 109 ,  3 ,  1 ,  S6KGHIPNSJAZBQL ,  HD2LWL6PLHYTOJX , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  494.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 110 ,  2 ,  1 ,  BYVPBGHWRB7ZBNX ,  ERI8JUVP2FKO2DG , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  419.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 111 ,  1 ,  1 ,  N0P5JYN4YEDPW1V ,  BOM58MVXOWDDSNN ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  92.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 112 ,  2 ,  1 ,  NDK9ER5T7ZG9ROP ,  TWW77SWCJ0PNSET ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  281.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 113 ,  3 ,  1 ,  E7HWGZJV7IK8H5S ,  STLMNIV4I2RIBTD , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  532.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 114 ,  2 ,  1 ,  NBWV5IY7QAIFLKF ,  BEBJAMKPHVGKGMY , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  460.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 115 ,  1 ,  1 ,  JXPA5UKVZRWJKKP ,  QJKVLRUZXRXFAYI ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  956.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 116 ,  2 ,  1 ,  ZVDK04AKF8TDBUW ,  72FOY6PXCAMNUXE ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  408.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 117 ,  3 ,  1 ,  PM9BCYZEHBMTWDM ,  4XATGTD44HYTIM9 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  252.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 118 ,  2 ,  1 ,  GPUCGSMFSSBEXH8 ,  V1WEVSEWK7K9AKI , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  755.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 119 ,  1 ,  1 ,  Z300LUZBEDVC2WL ,  ZJDPHI4RUGLPOFW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  358.0000 ,  TXN-001 ,  4 ,  REF-2001-1 ,  3 ,  11 ,  9 ,  2013-09-09 00:00:00 ,  2014-11-11 21:54:05 ,  1 ,  58.0000 , null);
INSERT INTO   transactions  VALUES ( 120 ,  2 ,  1 ,  4TEBAOUAVYJI4GE ,  GDXXAWWCPZHA9AP ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  393.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 121 ,  3 ,  1 ,  3CVMQPD1YHKNOOC ,  BJMCY6BBDPAGNGP , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  791.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 122 ,  2 ,  1 ,  RVFHOGPN4BUEWNM ,  ZRRVNIEY8ECTUYA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  432.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 123 ,  1 ,  1 ,  WVLXOL3SC3AJRPN ,  LLQZFTHQJVO5W9R ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  905.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 124 ,  2 ,  1 ,  GRCOOA4CITWCM0O ,  OFLYWN9NMQEKY94 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  229.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 125 ,  3 ,  1 ,  9F1IPO7VTMKDQRU ,  QVSTZBPLNSJ1LLV , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  256.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 126 ,  2 ,  1 ,  8XIAQA9ACZEUOTT ,  TP1KQP7RP5YREFB , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  242.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 127 ,  1 ,  1 ,  HERJHEUKAD23ZLJ ,  X5VFTR08XL9G4ZE ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  390.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 128 ,  2 ,  1 ,  52AAO5VYBTL9ZKZ ,  UGZX6C0UDWMEGO2 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  718.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 129 ,  3 ,  1 ,  G4CCMDBBNPZ2UXQ ,  FZ7XXKJLAASCMX6 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  614.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 130 ,  2 ,  1 ,  EZZAKDVQSQIV07C ,  FI6O2718KVPKEXH , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  591.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 131 ,  1 ,  1 ,  DYFWPQGAFK2APS ,  N0MCGHEBLGHL6VD ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  891.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 132 ,  2 ,  1 ,  ZFPVQXPSC16XNJ ,  VETI5XHDDOF43W ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  402.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 133 ,  3 ,  1 ,  OYRG8CVN74L8GBN ,  VLDPBJOPAM1BQI , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  918.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 134 ,  2 ,  1 ,  9HVGFGE98F ,  V3TD0XM2OXIB , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  385.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 135 ,  1 ,  1 ,  3KM8GNNR9IPYAXN ,  BSS0JEUHNDTFVTQ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  349.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 136 ,  2 ,  1 ,  2ZBGHPCHPHGVAAZ ,  D9GFWTBBI4LWB4A ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  494.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 137 ,  3 ,  1 ,  FXILYEMMHZZSNDU ,  BZCPK6PW0LCEERP , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  161.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 138 ,  2 ,  1 ,  YUKXFCJREKNCSSB ,  U9EXR8WEC0JWLGQ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  829.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 139 ,  1 ,  1 ,  3LK1KJCKJBICZCE ,  NETMISO8SG4RI1G ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  408.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 140 ,  2 ,  1 ,  MJXZXFTMMYPOUG2 ,  ZDL5WDSXMKAFFMX ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  902.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 141 ,  3 ,  1 ,  2GR4GESXSDZT5DD ,  1YWRRHF6VFIRYDI , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  868.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 142 ,  2 ,  1 ,  OJGBRIY2A7PKP64 ,  WQNCWKKAJSWBZ4V , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  588.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 143 ,  1 ,  1 ,  WHJ3TNUHSCDEP9H ,  DHJARNCXTUXHORM ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  953.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 144 ,  2 ,  1 ,  VXRZOBHHIIVGCJG ,  QB0VNTBXD76C5JR ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  165.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 145 ,  3 ,  1 ,  NDCMWOJK42SQE99 ,  QJPYI84ATQRBFDA , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  227.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 146 ,  2 ,  1 ,  OJLG6BFYZP5OPSE ,  3ZYUVOD3UFOBYFA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  432.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 147 ,  1 ,  1 ,  1N8ENJYNPMY59WH ,  NJ1EZXLVHZMMGG9 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  490.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  11 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 148 ,  2 ,  1 ,  XGYEOJE1VAHKLYE ,  APUTAJKEEFCBJ9L ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  101.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 149 ,  3 ,  1 ,  OCSQQQUUITBHNXJ ,  LXPU47YXYW3SSRF , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  120.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 150 ,  2 ,  1 ,  YBOUWSE0NDUDATT ,  TRF4RREVKTLUIHB , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  517.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 151 ,  4 ,  1 ,  CBFEH8WS8FSNL4B ,  NPUNLXRGLVKDLGG ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  151.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 152 ,  2 ,  1 ,  AOZDCT79S5T6VZM ,  ZFRMPQ6YBDBEHYO ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  530.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 153 ,  3 ,  1 ,  CWOPIZ4GLTWOQ6U ,  PV2ZFKQVOGCDEHE , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  701.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 154 ,  2 ,  1 ,  AKWHZBX1WQHAY55 ,  Y52AAFURSTZBRPX , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  96.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 155 ,  1 ,  1 ,  IXQLIQ7QGG6WEQE ,  CAHJGOIEQA0P7SJ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  305.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 156 ,  2 ,  1 ,  BLUP3RO5N9CX6UB ,  DDPFFWRRJA8DHMJ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  29.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 157 ,  3 ,  1 ,  HFRQG5DCFCT5I12 ,  781HSCFUSOBRGSZ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  524.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 158 ,  2 ,  1 ,  C9VJOISDQOEQTST ,  QR2KMENB3D9FOX8 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  253.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 159 ,  1 ,  1 ,  LNPR5ILTQJKL4GO ,  Z17G6XAGGFNNWSR ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  334.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  11 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 160 ,  2 ,  1 ,  WARPRTAIMO3UQ6G ,  ODJIH2AJTZUAMY8 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  758.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 161 ,  3 ,  1 ,  KKMRKSNGV61CNJI ,  L62L8V4CUH9C6IK , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  537.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 162 ,  2 ,  1 ,  DDHGN1VWBUBY86A ,  5TZWGXZHMROYW5S , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  314.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 163 ,  1 ,  1 ,  MOKKUEPWFIYXAX8 ,  BNQVSURGR4APLIG ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  252.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 164 ,  2 ,  1 ,  XJSX7KNVVLA4DP4 ,  GMLZN4MQCH5B6LU ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  66.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 165 ,  3 ,  1 ,  JALA8ZGU7SUD7D1 ,  LPKFCSOVYIAX7ER , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  424.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 166 ,  2 ,  1 ,  E9MBEDPKTAHSXGO ,  G3SXFGOW3V29CEA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  456.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 167 ,  1 ,  1 ,  CLPLFBSD0EHKUOV ,  A9VXK7GU656WLMC ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  96.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 168 ,  2 ,  1 ,  5GVFEGUFMBVLXD0 ,  IUHNB010DETWCQW ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  307.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 169 ,  3 ,  1 ,  EPWXKSYDS779OJU ,  KXLRKJEPND2KXM9 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  340.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 170 ,  2 ,  1 ,  PNLXMSQ9HUVJYPJ ,  4PPPWRVTBY4MSTK , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  243.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 171 ,  1 ,  1 ,  NUMCTVLYSVEIAC8 ,  GJQLQKSYBR0HDIZ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  426.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 172 ,  2 ,  1 ,  EPECBIYYRVABRB6 ,  TPBYNS6YMDAYRY9 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  769.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 173 ,  3 ,  1 ,  4GGIIQNGAGC1UAY ,  T4ROCMGW6A89KRG , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  817.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 174 ,  2 ,  1 ,  YZNWAUMU3ZOJ3OV ,  4UZC6BPOASAAAAB , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  53.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 175 ,  1 ,  1 ,  0EXML7IOWTVDA6A ,  W4OIO0TFOGW6GM5 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  767.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 176 ,  2 ,  1 ,  C2KMYJS8BHIRUYN ,  JLYTMMQKVWQ5LDP ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  683.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 177 ,  3 ,  1 ,  VQH5PFJI5A88OIQ ,  EQGDQOJXCARFQ7L , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  405.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 178 ,  2 ,  1 ,  ZUYNJ7EFZ6T5FVP ,  AUBHWAG3BQIICAK , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  417.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 179 ,  1 ,  1 ,  KNNCE36YNPOMDBW ,  LE6TACQMSAIVBFM ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  740.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 180 ,  2 ,  1 ,  KLMGVRWL0WDONTN ,  UUAX48IWU63NW6H ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  588.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 181 ,  3 ,  1 ,  9NDZRHX6SDLI7XL ,  WLBPEH52F9YBNYO , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  566.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 182 ,  2 ,  1 ,  REVHQFWDXC3OPOG ,  UG8ZAN2Z3RZ8DTU , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  641.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 183 ,  1 ,  1 ,  ALYXKT3BRE43PKS ,  F8OV8441YDTMKYV ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  874.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  11 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 184 ,  2 ,  1 ,  HS3494TYEE4MQIC ,  S89D6XDR8EQWK8P ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  821.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 185 ,  3 ,  1 ,  KVVBAIOVWR0XOLT ,  KXCYVF5SQKSDEJY , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  100.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 186 ,  2 ,  1 ,  U6KQ2UAEL2JGTCL ,  WGIGX9LBYIXWXUB , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  420.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 187 ,  1 ,  1 ,  AO9ILZVKK41P2OL ,  DESBDDXL9TUDTZR ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  308.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 188 ,  2 ,  1 ,  IMXY83ONQP2PJFC ,  ARN6MEABDQ0LB5H ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  576.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 189 ,  3 ,  1 ,  0ZTYKY0RTJ1EN5K ,  NS6N3FJZ974H67D , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  470.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 190 ,  2 ,  1 ,  NPLJBU39RANDBA2 ,  JWHE5INVPKAIBGV , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  289.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 191 ,  1 ,  1 ,  QGYNQI15KV4GFAG ,  MDKV396FF0GNSIA ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  662.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 192 ,  2 ,  1 ,  QHVZBJTJF55ZQQ2 ,  ZYRIXQYXISF5EHY ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  715.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 193 ,  3 ,  1 ,  IUEGN8JMV964W6D ,  DSYEKENK4GJDBKP , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  69.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 194 ,  2 ,  1 ,  RMMKFMEOSU03H38 ,  FQSIZYFQMSOO5XB , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  877.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 195 ,  1 ,  1 ,  DIHSTP0YOCV5QIO ,  TD6ULJMBOLRQKIQ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  680.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 196 ,  2 ,  1 ,  ORRG019SU2JSGJN ,  2I2E09QU1H90ZR3 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  24.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 197 ,  3 ,  1 ,  HDN6LOVU35YKATK ,  NGCDTTDL0UBLGUO , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  89.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 198 ,  2 ,  1 ,  MCUQWCYODI6UTRV ,  SWFEONBGEW2YB7J , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  228.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 199 ,  1 ,  1 ,  IZ5ZDMMSGZKOJWN ,  8BGLUWTMGRML7NK ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  33.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 200 ,  2 ,  1 ,  RYFW85BYYMHZ3UR ,  3D1XPTKTUKWHFEW ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  788.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 201 ,  3 ,  1 ,  IQVOJMURHFBFJHE ,  05TX86LRTIR5CZI , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  33.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 202 ,  2 ,  1 ,  ORVL2LV6GURY1XB ,  DBNJ7F6BQFNAZQS , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  432.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 203 ,  1 ,  1 ,  MIBHLL0ZBLBIJSH ,  DEHCAWISFYTUXNI ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  810.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 204 ,  2 ,  1 ,  Y1GL5TFH6QEUT6F ,  5DHDQXBWZGYRCQS ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  946.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 205 ,  3 ,  1 ,  RLHEDPAF2NP07RT ,  JWIAJ3CPXHFONHX , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  618.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 206 ,  2 ,  1 ,  GTWQWLAWRIY0RXT ,  PPDBWCOAX6SUHVC , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  609.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 207 ,  1 ,  1 ,  RBHM4NK4KUISETL ,  1YV30YDRFPVNZRW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  447.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 208 ,  2 ,  1 ,  RSAJH8YG1OTJHRH ,  AZLOE1DUPUTHA97 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  581.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 209 ,  3 ,  1 ,  51JTB3JLAHKB9QP ,  GXEDSCHCYMPQ3KX , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  336.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 210 ,  2 ,  1 ,  XECIJYXVLQXTS7U ,  PKFFSBNV7KNPXK8 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  335.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 211 ,  1 ,  1 ,  S26U8XOVLAQTK7A ,  QBPM7T9OFKFOHRH ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  840.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 212 ,  2 ,  1 ,  JKTHECJJVLAZV4V ,  FGHRQ0OFVA4NNBY ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  768.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 213 ,  3 ,  1 ,  K78CTJYHH3K06FT ,  SNY69TJUFWCJMIS , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  827.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 214 ,  2 ,  1 ,  6M4AOAGJJYPENFO ,  98GOBVVMT1G4OLR , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  856.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 215 ,  1 ,  1 ,  BRWXJHEGZFLQQDO ,  LMYMYEP4CGOJ9EV ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  875.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 216 ,  2 ,  1 ,  QCCZWLLYJ2YENOX ,  9RJDS6MKXSRLUSC ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  780.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 217 ,  3 ,  1 ,  363ZAPOLENDH6J4 ,  QAGPUP1UWB18TXT , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  300.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 218 ,  2 ,  1 ,  DM2TXNJRKUACDQ3 ,  W7IIB6M3YMNBRO2 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  21.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 219 ,  1 ,  1 ,  9KBOFEQSOCJVWNL ,  LIJGVDGRQAWPUIH ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  72.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 220 ,  2 ,  1 ,  L0U7JSSFMMDNP7M ,  DNRME8WF93EMDUJ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  735.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 221 ,  3 ,  1 ,  ZPVMGUY4QBS4LAG ,  CNV0AUTDMJNIA6G , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  76.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 222 ,  2 ,  1 ,  IV8NHHQAD9NUL2P ,  5ZPUZTQWY669GFO , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  291.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 223 ,  1 ,  1 ,  FNPNNHNKL479HTZ ,  SYGSL8UC6CG9FPQ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  612.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 224 ,  2 ,  1 ,  XTZPA5TT6SRKQKA ,  THESCSIZFRRVRSF ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  671.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 225 ,  3 ,  1 ,  1WEBAZT0ETLEEWK ,  FJBUCBXQMST3DKH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  111.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 226 ,  2 ,  1 ,  RYH9XH15UAGCAP4 ,  YKKZ36BI4KOGKMJ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  154.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 227 ,  1 ,  1 ,  OVQTNUIL8CKDDTX ,  JVTDKZI1Q0LR7XO ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  631.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 228 ,  2 ,  1 ,  UONDIPNIBTU3RCD ,  T31AD57L9ARL7QF ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  364.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 229 ,  3 ,  1 ,  JUHBFBF8FCJDW1S ,  LS5FCIJGWIZVNSQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  626.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 230 ,  2 ,  1 ,  MXKFANZO9IBDY1J ,  7YI0ZWRHWUESK0X , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  658.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 231 ,  1 ,  1 ,  QWODWOQEOUV4NSG ,  4IR66IH014ISLGA ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  294.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 232 ,  2 ,  1 ,  WGEJBHG6UBCARMG ,  1AX9FLX5UIL0RP6 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  598.0000 ,  TXN-02  i am adding more to this ,  4 ,  REF-0000000 ,  3 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-12-03 10:11:34 ,  1 ,  98.0000 , null);
INSERT INTO   transactions  VALUES ( 233 ,  3 ,  1 ,  MSYMOG8KIBM6GFD ,  3W1WPMTQEBNGYTW , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  746.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 234 ,  2 ,  1 ,  DBRUHDLA476GXOU ,  ZOEYEMUF7ZMUTF1 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  516.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 235 ,  1 ,  1 ,  LAAMDMNEWWUUVC3 ,  EZEYN2ZQAUOHSJX ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  326.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 236 ,  2 ,  1 ,  QKWA67OA8S7VPAK ,  QXPCXIC1CNUKSGJ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  248.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 237 ,  3 ,  1 ,  SZDJHJJVCJLSECS ,  JBLL81CO6JXPV6I , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  739.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 238 ,  2 ,  1 ,  1MMFV4NPF69IWRI ,  NWO9IY3JYXSKBJS , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  924.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 239 ,  1 ,  1 ,  VRE8MZ6RCOJF8GK ,  BQMUFEZRWLKRT3V ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  962.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 240 ,  2 ,  1 ,  6RB6I2VYU0VPHZ5 ,  JYKZYL1TECY0FQX ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  7.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 241 ,  3 ,  1 ,  BDUUDLRSQJ2XFJ6 ,  DBNQ6JE52UWHW7H , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  235.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 242 ,  2 ,  1 ,  8V2DDWRE2MR3VWB ,  KTFWCPEWY5XYDCN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  416.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 243 ,  1 ,  1 ,  I6F5RFRTXAJ8WHN ,  G0NRAQLY1QXM2YW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  720.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 244 ,  2 ,  1 ,  KF5W7KKN0HQFRYL ,  QKHEJ33LVQOY1UD ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  276.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 245 ,  3 ,  1 ,  NIMPM1VLS50LVBN ,  XXKFQ3K80KM3TA9 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  709.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 246 ,  2 ,  1 ,  PUSXCUCFCC3QXXO ,  ALINMSIB2JZBARO , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  782.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 247 ,  1 ,  1 ,  ESKI1QGA8GIOWN9 ,  NNT9AC60OLSTJGH ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  573.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 248 ,  2 ,  1 ,  F5EMCADOWX1XNRK ,  08YTVAYLJYDCYWF ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  980.0000 ,  TXN-02 ,  2 ,  REF-0000000 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2014-07-14 21:45:21 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 249 ,  3 ,  1 ,  OEIO0LMG7DKP6EL ,  PZYU8MGHUOYJPCJ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  568.0000 ,  TXN-03 ,  2 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2014-07-14 21:45:21 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 250 ,  2 ,  1 ,  MZC3QSUHERVBXSN ,  KPPXUXOVP93W4NC , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  985.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 251 ,  1 ,  1 ,  AY6PUZZFOKGZEMW ,  LABYELTVFUUQQPU ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  19.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 252 ,  2 ,  1 ,  CTK24CAMATNU2HW ,  GCKQCJQMPXCUATU ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  82.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 253 ,  3 ,  1 ,  M5W2WE9BHCTT3PE ,  JPGTNVBSUGHGMDH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  734.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 254 ,  2 ,  1 ,  YNJMBMH_id 1WS2TQ ,  0LMCGCGOBBLGGIL , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  71.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 255 ,  1 ,  1 ,  TACMBEHYOFNTBGV ,  RSYE9VWZDMOHD8M ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  818.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 256 ,  2 ,  1 ,  RIV37XZGK17SQCV ,  LLXAK7BYZUZ4LDQ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  943.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 257 ,  3 ,  1 ,  ETSWZQDBNYNJDNV ,  RA9LGJYUKKO8EKK , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  721.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 258 ,  2 ,  1 ,  568XM3FHRQLDDVR ,  4JRUJ09IMOB2Z8W , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  954.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 259 ,  4 ,  1 ,  UOBJ87RAYDGFQV111 ,  5LHQVGCDZOXHKRA ,  Test Rcv ,  Crt ,  1 ,  2013-11-08 00:00:00 ,  2013-11-24 00:00:00 ,  2014-04-08 23:00:00 , null,  1854.0000 ,  TXN-001 DESC ,  1 ,  REF-2001-12 ,  3 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2014-04-07 06:55:43 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 260 ,  2 ,  1 ,  3ZFYST9N13EVQX ,  AEKB2VTT49OSV3 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  129.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 261 ,  3 ,  1 ,  OC3VLMZUFZUOGK9 ,  SPXU4LGJZ7UDD2 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  181.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 262 ,  2 ,  1 ,  POGLCRLSGF ,  EU8M8SU5FTKH , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  964.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 263 ,  4 ,  1 ,  JZDGGYVMWMOHWSZ ,  OOIROQ2HQ2VSBHM ,  Test Rcv ,  Crt ,  2 ,  2013-11-17 00:00:00 ,  2013-11-30 00:00:00 ,  2014-04-08 23:00:00 , null,  2453.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2014-04-07 10:04:13 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 264 ,  2 ,  1 ,  SOXEC3LV3LZPQEX ,  PBQ2M16Q23YXI7O ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  634.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 265 ,  3 ,  1 ,  KHCMX2VXPQOKHUA ,  8FO5HUJE4JXKRD3 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  695.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 266 ,  2 ,  1 ,  3IO51UMBBV2E0PP ,  DAJRVKNVUHW2UTT , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  233.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 267 ,  1 ,  1 ,  DKSOKVA3BY5TB6U ,  AXXB5DO4IYENZMQ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  3333.0000 ,  TXN-001\nAdding more information on the subject line, just because!\nAdding another line ,  1 ,  REF-2001-1 ,  3 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2014-04-17 09:49:56 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 268 ,  2 ,  1 ,  C16LZUFKWMIB1UH ,  84LXDIKSSHUMC8I ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  291.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 269 ,  3 ,  1 ,  SECX7RJKGVJ66ME ,  RZI95RB3IMWLWN6 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  380.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 270 ,  2 ,  1 ,  XHNTM9BKIZSXNAU ,  L1UKPHCWKS43KC9 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  744.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 271 ,  1 ,  1 ,  UZQTBQ5KZSKGONE-1 ,  DSWM8JR8FRKFGH2-1 ,  Test Rcv ,  Crt ,  1 ,  2013-11-23 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-15 00:00:00 , null,  2899.0000 ,  TXN-001\nadding more in the description ,  1 ,  REF-2001-1 ,  3 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2014-04-17 11:39:38 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 272 ,  2 ,  1 ,  1BHREUSVWJR4FWY ,  LQDGNM0XOEJZUDN ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  169.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 273 ,  3 ,  1 ,  BFJI3KCOVVYYBHK ,  YTZHN0BYGQWCWNW , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  892.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 274 ,  2 ,  1 ,  FUCCB4SELXWTWNE ,  JT1XJPIRLUOYXXA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  85.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 275 ,  1 ,  1 ,  1111111 ,   ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  222.0000 ,  TXN-0012222 ,  1 ,  REF-2001-1 ,  3 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 276 ,  2 ,  1 ,  TAOXBYLBUUTD0ZB ,  DZH9ZVWUVIVOPUS ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  967.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 277 ,  3 ,  1 ,  TZVPL9NFMH7UCSG ,  UFP5H55LDRLXUCP , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  578.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 278 ,  2 ,  1 ,  KPCWJYQ1LVBIMQR ,  CMELQ7RNFQSGIOH , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  818.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 279 ,  1 ,  1 ,  OV2C6DXETHAEK7J ,  FYXJ4GC9EY6SWNZ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  9.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 280 ,  2 ,  1 ,  I5TNHV30JBRXTS2 ,  7VCWPRDVEFEGGUV ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  366.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 281 ,  3 ,  1 ,  ODDQFKZOEVV3DIE ,  G6KTXEAOSHCMUGM , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  278.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 282 ,  2 ,  1 ,  0DKQN0HDUNUV3Y3 ,  SKLPEDPIC1US3Q2 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  962.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 283 ,  1 ,  1 ,  UP7SGJZBQRKASOH ,  ZUR5O2KORBBBVYW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  301.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 284 ,  2 ,  1 ,  CQOZKGO3RHWYS21 ,  CCEZRDDX7UP5ENN ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  514.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  3 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-11 11:15:20 ,  1 ,  14.0000 , null);
INSERT INTO   transactions  VALUES ( 285 ,  3 ,  1 ,  ACTGA9O4STLAMXT ,  XJ6B2SCVO0GYAUQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  121.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 286 ,  2 ,  1 ,  BR4ZZI4MD2WH29O ,  S0MG1VQ92HVUKVW , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  655.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 287 ,  4 ,  1 ,  ERSFQDIN9KJJCJS-1-1 ,  JYHEQDPBXY5ZQFM ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  323.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2014-04-17 11:00:19 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 288 ,  2 ,  1 ,  YF7RZ7PEAAKARXK ,  YRXRZD0JMTVJOFH ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  458.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 289 ,  3 ,  1 ,  P06XZSQSJRGWZVW ,  WN2WL3HFOV7PHDG , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  351.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 290 ,  2 ,  1 ,  BV1RHFEAIO4XC6T ,  CIMEWVY17SLKSBL , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  999.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 291 ,  1 ,  1 ,  JDDZA3VLXPMR6WH ,  YWDGYMMXDQJKMFP ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  144.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 292 ,  2 ,  1 ,  IBU3KJHP716BPYN ,  7RAR7RTW6RH4KSL ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  149.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 293 ,  3 ,  1 ,  I1CO_id EO1LBGIHH ,  1PM0BK8W9HJ6L03 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  731.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 294 ,  2 ,  1 ,  9ENDNJL8KO4FKDG ,  RXRHBYI4PLYDRDE , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  629.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  3 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 295 ,  1 ,  1 ,  JCN0PATZIK1WG0A ,  VQXLS4JXNRTWF1N ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  84.0000 ,  TXN-001 ,  1 ,  REF-2001-4 ,  3 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2014-04-16 02:15:20 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 296 ,  2 ,  1 ,  SBA5FGX9YOA7HFA ,  CH9ZYSUQD3EMWUG ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  980.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 297 ,  3 ,  1 ,  H5UIPSWKGI8OFEL ,  FZQBIED3K6O1Y8P , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  183.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 298 ,  2 ,  1 ,  PCTEXYKCATA3TPF ,  RXBR1FZQ96VIPDD , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  900.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  3 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2014-07-21 20:16:46 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 299 ,  1 ,  1 ,  5KSAFPIBIHXVEXK ,  CBYCHMQUBVM9A0W ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  476.0000 ,  TXN-001 ,  1 ,  REF-2001-1-0 ,  3 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2014-04-18 11:46:49 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 300 ,  2 ,  1 ,  9DGJBST4SMGF4GW ,  BGLB6L5DOB7N06V ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  193.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  3 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 301 ,  3 ,  1 ,  KBYVRALUDM2TAS9 ,  WYBUSF0U7PUCTTH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  557.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 302 ,  2 ,  1 ,  7EXSVKUKKP6C6HP ,  HSGCBDQ0SAKSGTI , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  327.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 303 ,  1 ,  1 ,  ERRVSWWM90OYV59 ,id  L6NRD96YQHWEW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  547.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 304 ,  2 ,  1 ,  H7NIJ9HVV2EI8BL ,  AVNUFUU1X7YP5XO ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  507.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 305 ,  3 ,  1 ,  90IMVADMK3VDBEF ,  RWSVR1YPU509F6Q , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  169.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 306 ,  2 ,  1 ,  11D5PTOXPZS7EQU ,  4ZZK84PMFLWEZWM , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  836.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 307 ,  1 ,  1 ,  QQRR9UZRKYYJQRY ,  DVUO1DPALSD5WQK ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  125.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 308 ,  2 ,  1 ,  2DTZUMQUNCEYRFI ,  BFPOM9C6YXNAX6Q ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  599.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 309 ,  3 ,  1 ,  1Q1KZQGLZHOQVX4 ,  SHQASTPKBV1EFTA , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  579.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 310 ,  2 ,  1 ,  XUAGCWTF1SZRUFZ ,  5YXBNOOLPRVSA3O , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  629.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 311 ,  1 ,  1 ,  5Q6GRIHYORJ2MM1 ,  BLPUI7JWJ4SKQUS ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  472.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 312 ,  2 ,  1 ,  WEJOPEOQ8EGYXUU ,  U9JYYTOR8995H8D ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  881.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 313 ,  3 ,  1 ,  HWKU4Z6KWIQX27B ,  ZCN0EDLJJ1SZD78 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  371.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 314 ,  2 ,  1 ,  WDLCGFXIQXRKL5Q ,  RDIO1SNE8JSXWMU , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  274.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 315 ,  1 ,  1 ,  PP3OHGQNLXVHR4T ,  HZQUM2HEQKHRQQZ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  843.0000 ,  TXN-001 ,  2 ,  REF-2001-1 ,  3 ,  11 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 316 ,  2 ,  1 ,  QUC1XJGMKLJCETX ,  0KAN4R0XEGN2YDR ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  298.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 317 ,  3 ,  1 ,  VWAIABNSA5AADCH ,  DGEMXUUJQSYQHEW , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  151.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 318 ,  2 ,  1 ,  LUCWQTGATTXUDOD ,  QYFQT9QXKOOXCKQ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  600.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 319 ,  1 ,  1 ,  ZERGZ2DBA1W2EX1 ,  AXRVYKNMKZDZPQC ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  107.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 320 ,  2 ,  1 ,  QKMCXPWGK3WLTCL ,  DP899H63V7UPU0G ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  245.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 321 ,  3 ,  1 ,  RMGRVQKVWH3TYSI ,  YPQVDQDDEA3T9AS , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  660.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 322 ,  2 ,  1 ,  QBR8D5CSXOEIFDW ,  EI0YSLLQ7K9KBWG , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  7.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 323 ,  1 ,  1 ,  W9UBKUBWG0PNRCK ,  4QAARBQDPFH0MNM ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  102.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 324 ,  2 ,  1 ,  G7YVBN0DDC5NLVX ,  QDZ5IPA0OUAKNXA ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  988.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 325 ,  3 ,  1 ,  N03LE2QPKVCVAEE ,  PZDOI5E0VWXIGU2 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  25.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 326 ,  2 ,  1 ,  Z5EKCRA3OILR3IK ,  OMTOXMIGDOSWDGG , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  952.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 327 ,  1 ,  1 ,  MKTOXSA7LQYIXAU ,  WXUPPGXNXJYIRCW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  323.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 328 ,  2 ,  1 ,  41ZSYF6RGCT323A ,  ZBEOVW5HXNBKUEA ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  875.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 329 ,  3 ,  1 ,  IZIFDM3YOZJIV9B ,  MXVC9ZGE2OBIQNC , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  430.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 330 ,  2 ,  1 ,  XTAJIMA3TCTHAX9 ,  HYVF99KTZHBWBKN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  486.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 331 ,  1 ,  1 ,  TB9AQGI2HOR99TI ,  34GFZHBOLRZGZJX ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  497.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 332 ,  2 ,  1 ,  ASZEK9UQVIHOJXJ ,  Y6NSW1LVHUFHBH8 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  908.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 333 ,  3 ,  1 ,  0JZ385QBPUO0KEF ,  WAKSKKUGA9T9KME , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  402.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 334 ,  2 ,  1 ,  95NLXALYRWUMTJX ,  D5HHRFQNNI57WTN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  655.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 335 ,  1 ,  1 ,  BDZLLHSVH7KC4DC ,  VU4KTF5GL9KMXHE ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  904.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 336 ,  2 ,  1 ,  OLMOM82AXND5FHF ,  ERYUY8BEFR0IKDT ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  665.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 337 ,  3 ,  1 ,  1EBEEIAVJ3NXDVS ,  GZOXV8ETNIEPAET , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  834.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 338 ,  2 ,  1 ,  E9H1S6UJFBFWKOK ,  ZSGQVL6T1MWKCWN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  639.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 339 ,  1 ,  1 ,  ELMK3VPUQPT7TTY ,  IZ3KD98LEZJD03F ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  550.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  11 ,  9 ,  2013-09-09 00:00:00 ,  2014-11-13 13:48:28 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 340 ,  2 ,  1 ,  M6X7KPKS3RTFWJC ,  DDUOKTBEPPJHFDC ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  876.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 341 ,  3 ,  1 ,  FKH9VDWJRR8SCPH ,  UN0EAKRZOGGDTS0 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  465.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 342 ,  2 ,  1 ,  FSVNO607G1CHKQG ,  KZU6AXDIJ4OQNX8 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  605.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 343 ,  1 ,  1 ,  XEZEQRUDVRPGAKS ,  GF4G0HGNLEWTKYK ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  910.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  11 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 344 ,  2 ,  1 ,  GQEJLMRXGGD63PU ,  3RLIP6L4Z9G7YCM ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  219.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 345 ,  3 ,  1 ,  UKB6VOCXSJDEXYB ,  ICYM1LAN3AHM1CB , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  208.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 346 ,  2 ,  1 ,  CF83JADWLG0BJ03 ,  X9F2YC3PESL6MER , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  494.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 347 ,  1 ,  1 ,  11WJJD5BHKV10JX ,  ABJH1XD4ARFY1PP ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  729.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 348 ,  2 ,  1 ,  YHVSEMNZRPA08JA ,  3IUTOHBIHZZZAY2 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  886.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-11 11:14:30 ,  1 ,  86.0000 , null);
INSERT INTO   transactions  VALUES ( 349 ,  3 ,  1 ,  HJNAEM8ZHRQEKHD ,  HZOY8E4SDG2KN8G , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  700.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 350 ,  2 ,  1 ,  W8DKKNN1JONCMOO ,  MBOZB1LAKA5CL8N , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  88.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 351 ,  1 ,  1 ,  UTK7CKAFNK6TPNU ,  USBERP375NHKQEO ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  798.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 352 ,  2 ,  1 ,  L7OHVQLVHSJANWQ ,  UGP0GKM44X1TZTH ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  290.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 353 ,  3 ,  1 ,  DFDASLD739IZLZZ ,  0GWNHZCG6EKCSXJ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  467.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 354 ,  2 ,  1 ,  CIMI1TKOCNJFOV6 ,  QKU4VIVDLCYUWQB , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  240.0000 ,  TXN-04 ,  2 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-04-17 17:58:10 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 355 ,  1 ,  1 ,  0Y8OLVMXE5A07S3 ,  9ONOKBN6GB4VIQZ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  521.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 356 ,  2 ,  1 ,  2ELS1F20SVFM5AL ,  DZU4ZCYCHTDCXVZ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  557.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 357 ,  3 ,  1 ,  IPE67YOQ2GA7ZKL ,  6EMGNHNJKTYNZNU , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  932.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 358 ,  2 ,  1 ,  7T9QG3HNVLBD4JE ,  EDFCLUBMTAFYXNO , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  888.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 359 ,  1 ,  1 ,  C55JFFDIC7SFLZ9 ,  0DQ7U1AYAYPPLUW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  313.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 360 ,  2 ,  1 ,  GRNG9UREGQAITFC ,  IERM0QN2YZ0O6S5 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  768.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-10 19:04:19 ,  1 ,  68.0000 , null);
INSERT INTO   transactions  VALUES ( 361 ,  3 ,  1 ,  MCN5TM0GMD6VGDK ,  3USU4WMK572HLDC , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  275.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 362 ,  2 ,  1 ,  XIUEOWYY9DOZAFO ,  HAM7GHOQNN6KMDK , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  621.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 363 ,  1 ,  1 ,  WN1GUDYDZPCSI5S ,  AXYRQRMVDM70EUP ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  248.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 364 ,  2 ,  1 ,  JCK4F51MCTZZVTL ,  LRNH0VHOTJN6KCR ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  212.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 365 ,  3 ,  1 ,  KVCQTQDB2KUXBYO ,  OIVVUJQ3PRMJ5IZ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  377.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 366 ,  2 ,  1 ,  CMXG4PYMTFVYYTO ,  JMCIXPQNMFZPASD , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  39.0000 ,  TXN-04 ,  4 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-10 17:27:14 ,  1 ,  9.0000 , null);
INSERT INTO   transactions  VALUES ( 367 ,  1 ,  1 ,  FCATSB8KQPM_id GI ,  SPT6ROWUFHZ4X2P ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  141.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 368 ,  2 ,  1 ,  6LFLPWKJSVOUTUS ,  OWZO54TCEWRTE6Y ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  943.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 369 ,  3 ,  1 ,  VTSY6VHLINHEUYD ,  MO0BUPBRMCSLHVM , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  845.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 370 ,  2 ,  1 ,  KEYB4RB7TWQFZHM ,  FKOQ7XOORBU4P4D , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  604.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 371 ,  1 ,  1 ,  9OOGZNAEI6ENAVK ,  FFTEGRVMHYLBEE8 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  37.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 372 ,  2 ,  1 ,  SNO2HANJGHKNW5S ,  5YYBVVBFFMLPJUB ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  292.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 373 ,  3 ,  1 ,  C8ATTNMN1MDSYLP ,  IKZKYDLYBDKLNWN , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  548.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 374 ,  2 ,  1 ,  PDNRZ8P8S1S0G5C ,  HV1RHZTNYZK2C4N , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  724.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 375 ,  1 ,  1 ,  E3IGRWY92FD7Q1J ,  R0CJA1J75YNPD47 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  851.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 376 ,  2 ,  1 ,  0EST4ABINWQC8VP ,  CIJLRSSDF0JDGIQ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  906.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 377 ,  3 ,  1 ,  QQ4QHTUPN3PIJD9 ,  EIX6CZB21BP8J9B , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  780.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 378 ,  2 ,  1 ,  57WOTIAES8R02NX ,  MZJQSYAANSCOZYF , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  139.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 379 ,  1 ,  1 ,  Z66F5OPOHAP_id XG ,  WRPKB3EETCPOIQY ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  187.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 380 ,  2 ,  1 ,  Q2VNP6LD6UXQDZK ,  IQHLFADUA6F5T8C ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  252.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 381 ,  3 ,  1 ,  BMY6ANXS4EYDS3Q ,  QWHXVGUJZE8GIRH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  623.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 382 ,  2 ,  1 ,  MOR1SZISVDDQFXX ,  XD5DJV7EJJ0LK78 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  128.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 383 ,  1 ,  1 ,  4XLFZVCHTTJSZCI ,  G3GUHHA5APK5DPS ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  602.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 384 ,  2 ,  1 ,  W3VU90RYGPYQVVT ,  N3SDPQHJXWR3BU0 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  503.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 385 ,  3 ,  1 ,  DHM1ARUOPNHBDVF ,  TBZHPWEEAPYZEF7 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  996.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 386 ,  2 ,  1 ,  Z5P8GB7PT28FTMY ,  LD3AUVS5CFL1681 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  771.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-12-31 17:29:58 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 387 ,  1 ,  1 ,  HZWBCKULBAMXYOQ ,  N40FOXUXEX5DZA5 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  761.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 388 ,  2 ,  1 ,  2P6XMLM0LDNJPFC ,  97VNTST7FN21WJA ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  862.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-09 18:11:47 ,  1 ,  62.0000 , null);
INSERT INTO   transactions  VALUES ( 389 ,  3 ,  1 ,  7ZCEIBCHPNGZKMN ,  NAXBTCY5BKKXOEH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  625.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 390 ,  2 ,  1 ,  EI5FULLZR4RZWNM ,  2TCQAT4M5VPUAR0 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  116.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 391 ,  1 ,  1 ,  6KWQDFSEIAQBK8I ,  QXRPVZWIE82CYU1 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  752.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 392 ,  2 ,  1 ,  ME8WOD0RPEODPWC ,  VEED6C4WETVS99G ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  946.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-09 18:11:47 ,  1 ,  46.0000 , null);
INSERT INTO   transactions  VALUES ( 393 ,  3 ,  1 ,  G0VGDXM48YOSUO6 ,  9SSG7SFRJMNQHXJ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  653.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 394 ,  2 ,  1 ,  DBJWKL7ZJ1GZUX2 ,  EZP9IVWZCBHWMQQ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  977.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 395 ,  1 ,  1 ,  7IZ4ZLTZTOFNGCV ,  B95VKVQJVJ4G8KH ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  498.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 396 ,  2 ,  1 ,  5DJVZQQRUQKLNL5 ,  WTSVDAAEEOTBWJC ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  389.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 397 ,  3 ,  1 ,  IPWROHIOVUX9EKR ,  VF2DEPYH52A6FEQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  63.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 398 ,  2 ,  1 ,  MSO70M6L26ZQN08 ,  TRIB1I94PRFAPHG , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  977.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 399 ,  1 ,  1 ,  W88BFN20UOWJ53J ,  B05AZWPCIQ6J13G ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  767.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 400 ,  2 ,  1 ,  O2ZDBWGOK9JCYHK ,  1O6MJ8MEAVOU06G ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  6.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 401 ,  3 ,  1 ,  TB0XXTWKKSKW1CS ,  OW0NXOJEOUFLGM3 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  11.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 402 ,  2 ,  1 ,  HTI5XFG3SPALJZF ,  S2AY1AP0TU3QGCV , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  437.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 403 ,  1 ,  1 ,  EZNGCI9QQ8JAND0 ,  2MHFLKFP2FLPMXQ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  647.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 404 ,  2 ,  1 ,  YRDLOZTYPOGLH0F ,  XE6JY4B2OJKTO4T ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  235.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 405 ,  3 ,  1 ,  IOTGONK2VKWBF0J ,  DB1HH1YOGIYP9YY , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  746.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 406 ,  2 ,  1 ,  QWL8NSZADXQNDVY ,  W4JZT56ZC6WTJFM , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  824.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 407 ,  1 ,  1 ,  IVEBMCUAYTABEBJ ,  P6LUVIZ4OXDYWO9 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  152.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 408 ,  2 ,  1 ,  KATJJ7SVZJDZOQR ,  EYDWVQJH6Q9938M ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  5.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 409 ,  3 ,  1 ,  CCUW4Y2ADGRDZJO ,  837GUL8BWLA10IP , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  744.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-10 19:27:20 ,  1 ,  44.0000 , null);
INSERT INTO   transactions  VALUES ( 410 ,  2 ,  1 ,  6FAR3RNEKIFHUSD ,  KNVP6EXIQO4ULEN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  637.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 411 ,  1 ,  1 ,  MFM6XVMEFX7ZFGH ,  4SZ9KJW4N9RIE7H ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  475.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 412 ,  2 ,  1 ,  8NTI8XFKXWQOTTO ,  61Q8PXJDEHWNVJA ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  783.0000 ,  TXN-02 \nHello i am testing this ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-09-15 06:16:45 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 413 ,  3 ,  1 ,  TUZLUVYE7PBHO8H ,  SGFA3PTGJGETCNX , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  400.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 414 ,  2 ,  1 ,  01JGFPFPBGU4UYJ ,  L4VP6FYCOS6BXCF , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  514.0000 ,  TXN-04 ,  4 ,  REF-0343535 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-09 18:11:47 ,  1 ,  14.0000 , null);
INSERT INTO   transactions  VALUES ( 415 ,  1 ,  1 ,  9PPTMKITB9RIBDY ,  SGHWKN5C3BDHZMS ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  38.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 416 ,  2 ,  1 ,  FESM4VPZMRJAOB8 ,  U9VEXA4NUGBK7AM ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  692.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 417 ,  3 ,  1 ,  MU8039UIJQICIFW ,  7BFNAJUHDHPCYPK , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  794.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 418 ,  2 ,  1 ,  M8LL2LNN48AWAJU ,  Q9G4RJZPZBST7TJ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  277.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 419 ,  1 ,  1 ,  2RIMIZRLDHESWXP ,  GUNW2YBK2N89ZF8 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  395.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 420 ,  2 ,  1 ,  SMNE9AM16FNMXC8 ,  EFZR1CVDOVJQFGC ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  15.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-10 21:24:08 ,  1 ,  5.0000 , null);
INSERT INTO   transactions  VALUES ( 421 ,  3 ,  1 ,  W5AFYLB4K3R2613 ,  GBHJNKVHQL0EHJQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  966.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 422 ,  2 ,  1 ,  JS8ZQEX8XSPEXIF ,  TPBTNZTZHRLEAQW , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  853.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 423 ,  1 ,  1 ,  FDGNEJLXU9MZSZO ,  OR2ADVG0H2CQULM ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  940.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 424 ,  2 ,  1 ,  UK1GAKMQ3JF3K3F ,  GWKUNATTUSHM4N1 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  662.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 425 ,  3 ,  1 ,  OP0SYAGQASHHF4I ,  4EQIJPECN1FBYVX , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  84.0000 ,  TXN-03 ,  2 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:26:41 ,  1 ,  84.0000 , null);
INSERT INTO   transactions  VALUES ( 426 ,  2 ,  1 ,  12WKEXUMZA7IPFS ,  W6L2ACOLOSW1CAL , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  798.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 427 ,  4 ,  1 ,  IQGEFI4OWWJJYQN ,  NNFLORI89QZ9XCF ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  36.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  10 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 428 ,  2 ,  1 ,  OYDKW4YMONMLPOY ,  NH0CXPSNKPV2QPP ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  659.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 429 ,  3 ,  1 ,  SFUCQZ9RXAJR97M ,  ULKZSHEITWTFM2F , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  914.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 430 ,  2 ,  1 ,  CZ4N81FAGSUMQUQ ,  UCIGGQHTWE67VIF , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  597.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 431 ,  1 ,  1 ,  5K3XXA3RAQU9SEP ,  PCGEQPDM9JRYRRJ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  219.0000 ,  TXN-001 ,  4 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 ,  19.0000 , null);
INSERT INTO   transactions  VALUES ( 432 ,  2 ,  1 ,  WHJUYXRHWH5OQLL ,  XSKYBHXXODTI5MP ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  963.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-17 17:01:39 ,  1 ,  963.0000 , null);
INSERT INTO   transactions  VALUES ( 433 ,  3 ,  1 ,  TUF0MNELZTGMYRT ,  RYZ7QLHXYM3OHJ6 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  455.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 434 ,  2 ,  1 ,  AH4ZXOT2XVPTFYU ,  CFUB0MM0HJC3WTM , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  227.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 435 ,  1 ,  1 ,  VS9M31EWR0J9JPJ ,  JP4LD71PGNVKQO0 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  485.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 436 ,  2 ,  1 ,  O474FSZS3ZQZWT1 ,  WDG4KTZFUQ2ESKW ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  987.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-17 17:01:39 ,  1 ,  987.0000 , null);
INSERT INTO   transactions  VALUES ( 437 ,  3 ,  1 ,  PPDY2JNFQUHOGSP ,  LEHT9WUYKMYUTSH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  812.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 438 ,  2 ,  1 ,  F1UTAE70NOMXJVS ,  3HGSUJHHJN3JZKQ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  699.0000 ,  TXN-04 ,  2 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:26:41 ,  1 ,  699.0000 , null);
INSERT INTO   transactions  VALUES ( 439 ,  1 ,  1 ,  ZFZKKPX37KXRIZW ,  XIKIAAQIL3HFUYI ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  266.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 440 ,  2 ,  1 ,  3BB9IBM8XPLBSJ2 ,  CV10JRZFGUAVJ83 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  687.0000 ,  TXN-02 ,  2 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:26:41 ,  1 ,  687.0000 , null);
INSERT INTO   transactions  VALUES ( 441 ,  3 ,  1 ,  W0P3PGIOH2CZU8U ,  RW4WR7FAGJCO8OS , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  477.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 442 ,  2 ,  1 ,  QADV3U8PN8UHVWN ,  VJO0RPKE3QIUSMV , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  214.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 443 ,  1 ,  1 ,  G8JGGMOPODROL53 ,  6TZEFERQJB6QX4F ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  232.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 444 ,  2 ,  1 ,  LONZ1DSQGZ7VI90 ,  JRNVFMDHNFSC9XM ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  87.0000 ,  TXN-02 ,  2 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-10-22 21:58:05 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 445 ,  3 ,  1 ,  5ITUPL2QB5JGTGL ,  EVNNK1RQEGBHMZ2 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  481.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 446 ,  2 ,  1 ,  JN0FJIGJPDOSCKB ,  GQPHIP1ACATW7QR , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  354.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 447 ,  1 ,  1 ,  OIVFCKMH1ZP7WM9 ,  0UIXICLYDF9GIB8 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  101.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 448 ,  2 ,  1 ,  8QCLDPPS2TDYJFU ,  O7VPCRM6WYM3FWN ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  596.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 449 ,  3 ,  1 ,  OYXN1FW9GBNY8Z1 ,  FN2TVIXRVHZ4PWU , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  262.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-12-03 10:07:10 ,  1 ,  62.0000 , null);
INSERT INTO   transactions  VALUES ( 450 ,  2 ,  1 ,  WPT9CTCBQ0HIFXE ,  E9417YJDJBARP3V , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  600.0000 ,  TXN-04 ,  4 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-10 17:29:43 ,  1 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 451 ,  1 ,  1 ,  KTXG3XIBLBTEVL8 ,  27BC2OPSCYTQWJH ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  445.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 452 ,  2 ,  1 ,  C5VQ9IYBPDEWZYD ,  QWRZAOIHZTLCNCX ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  664.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 453 ,  3 ,  1 ,  O5EA8ZRCHCVE1JD ,  P4DXNQDXSDFQKN6 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  350.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 454 ,  2 ,  1 ,  QU4MAX33EVBZKNI ,  V0T3ZONZIKCVANM , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  168.0000 ,  TXN-04 ,  4 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-05 11:37:50 ,  1 ,  68.0000 , null);
INSERT INTO   transactions  VALUES ( 455 ,  1 ,  1 ,  N2F6RGJ7YX30PUE ,  I81_id 3DLKTW0PT8 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  84.0000 ,  TXN-001 ,  2 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 456 ,  2 ,  1 ,  LDEEOIYBFHYHFTI ,  BRWHLFAIEQDO05Q ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  488.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 457 ,  3 ,  1 ,  IQDI6ZNAWX1M8RA ,  8TY1J7UPNCBIJ5J , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  257.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 458 ,  2 ,  1 ,  5FAR5TRCFU4IOS0 ,  BBSMY72RHZNX8R6 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  416.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 459 ,  1 ,  1 ,  EHXWPPNJQJMMKMO ,  FAFUHJ9XPC4KOGB ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  73.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 460 ,  2 ,  1 ,  NFSGZRE0NIX3FGH ,  7TFFY8PAQXEXJCY ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  908.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 461 ,  3 ,  1 ,  V3JMAU7DL92MBSB ,  K3LVA98NEADQT7M , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  541.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 462 ,  2 ,  1 ,  WCKOBEYOK772ULV ,  7ICZFXXAG9AWKFA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  693.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 463 ,  1 ,  1 ,  JO3GIOUIUXDEOGF ,  BBSPH23BY7TTLME ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  479.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 464 ,  2 ,  1 ,  09C969AUKIRYW4K ,  TZUKQ4ELRV6OCHB ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  832.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 465 ,  3 ,  1 ,  Z7DB0QIOFOILGCB ,  4Z56WYIC2ONXMRQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  309.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 466 ,  2 ,  1 ,  QGQI9TLDMNGHA08 ,  SVNSHITJYS88XUC , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  774.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 467 ,  1 ,  1 ,  AAHFDYEXXUK6B7R ,  BJ3EBJFU8LWRC4J ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  974.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 468 ,  2 ,  1 ,  Z59Y1ULEUS1TZYH ,  D10X5KQ5DDO3RBG ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  632.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 469 ,  3 ,  1 ,  A0YQOGBOVBL5AMH ,  EQYWTVQTZOFCFLQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  573.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 470 ,  2 ,  1 ,  0FP2KWEHUWYBCUQ ,  RM6P7Z0GGNLDKQ2 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  290.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 471 ,  1 ,  1 ,  YIMF6UUU02192DW ,  RHSEDYPZR9TJUJI ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  393.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 472 ,  2 ,  1 ,  NL6SKZA1LCMLBGU ,  HFALCPYJLEU0LA5 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  476.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 473 ,  3 ,  1 ,  H3HVJEMVMHXBWPA ,  AF6IAKK8TMGKKOB , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  121.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 474 ,  2 ,  1 ,  7MHKZFWKX8ZQKEN ,  SLETIPK7P1CJE92 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  916.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 475 ,  1 ,  1 ,  I6AK2EP4FISAGA0 ,  OLTE3RJXJBODPTT ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  780.0000 ,  TXN-001 ,  4 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 476 ,  2 ,  1 ,  D_id RG5CBQNL4V1B ,  GQABPW9FFJ8G1L9 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  959.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 477 ,  3 ,  1 ,  AU2NBLOEHNFHU2S ,  2AG8FMP0TENGOHH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  707.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 478 ,  2 ,  1 ,  NQ1UH5HMTR31NX9 ,  FL5HYGIM2NKKPFS , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  189.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 479 ,  1 ,  1 ,  AUUGCKUUJBOOKOF ,  HTFSI08NSUYT2TG ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  719.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 480 ,  2 ,  1 ,  NCBWEIXPLXREJAM ,  6CND5KV4ILKF4OF ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  733.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 481 ,  3 ,  1 ,  7GNOBRXUQU7CDYV ,  JGU6FRW2VKO0QKV , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  383.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 482 ,  2 ,  1 ,  2XOQMOSQA7V7I8Z ,  ICNIIBUTDBVFVB7 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  809.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 483 ,  1 ,  1 ,  DSRQLFF0RK4GYXK ,  DNUMZIODKQ4KAKA ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  45.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 484 ,  2 ,  1 ,  B2LO1HEWXOYBV6Y ,  QODVPZDVIF1GFNF ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  894.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 485 ,  3 ,  1 ,  9IQPBLKDVAT1SPJ ,  ZUDMZZEPCGR9G5A , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  0.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-08-10 21:48:38 ,  1 ,  3.0000 , null);
INSERT INTO   transactions  VALUES ( 486 ,  2 ,  1 ,  RUIIJVIQR1KPHQ3 ,  KCZ99B6ZTTTTVGY , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  936.0000 ,  TXN-04 ,  4 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-05 11:37:50 ,  1 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 487 ,  1 ,  1 ,  XS41FWCPYJS4FER ,  JBZMFKJOFAOBGIZ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  647.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 488 ,  2 ,  1 ,  MKKTT3E4EE3HKVK ,  5JXH3RG9CVYFSPV ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  516.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-04 13:45:46 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 489 ,  3 ,  1 ,  Z3EBFNN54USCEA3 ,  YOCYNPCRMFACIIV , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  388.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 490 ,  2 ,  1 ,  OBBWXHNW8T41UAF ,  FVQVMHNTZZDHDZO , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  59.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 491 ,  1 ,  1 ,  H2CGQELENQ0WWOW ,  YYVYQUJEBVBZYHN ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  628.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 492 ,  2 ,  1 ,  R9FSPGOO0EOJCNY ,  UQVS0AVLDJATQ2F ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  244.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 493 ,  3 ,  1 ,  XPKCH95XVY8CCH3 ,  CKAJOINBVQ5OA1Y , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  928.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 494 ,  2 ,  1 ,  IGE2OVFBJHMXL5G ,  3QBHDDGRMV2I1UK , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  398.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 495 ,  1 ,  1 ,  Q64NIYYOBZ63TFD ,  7KAZMNOIBLY7TRS ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  675.0000 ,  TXN-001 ,  2 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 496 ,  2 ,  1 ,  AYLMEXEZ0FZ1HHV ,  DTZZCSUBXUGQT2R ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  974.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 497 ,  3 ,  1 ,  PV6BFSQMFJTZ7AL ,  KT3B3SWYALKEZD8 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  129.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 498 ,  2 ,  1 ,  ZPFXMFA5MOFABR3 ,  FD2QLC6HS4MHEK3 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  779.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 499 ,  1 ,  1 ,  N3ODQX3W8XMGRVO ,  H3T06NUQIRNNAQQ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  729.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 500 ,  2 ,  1 ,  UMRZRK4DNITGOKR ,  EMLQBAWSEGHXQLE ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  117.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 501 ,  3 ,  1 ,  IL2W3LNHPCKNF12 ,  5I6ROSK8AIMRDIJ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  101.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 502 ,  2 ,  1 ,  893XWT9HANAA4ZX ,  8ZDRKGT55CYSWEB , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  168.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-04 13:45:46 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 503 ,  1 ,  1 ,  DMNLXIUHTXPUWKN ,  1USE85GTHKMAHDB ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  415.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 504 ,  2 ,  1 ,  EX5COBURI5WMSH2 ,  W9XIOZU9KPXEJRO ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  261.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 505 ,  3 ,  1 ,  JLDICSYW8TZJFO2 ,  GRHR5L6ZRQLL03X , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  5.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 506 ,  2 ,  1 ,  QQIK54OHICQ2TIR ,  1E8T7XVQWFRLEOD , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  256.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 507 ,  1 ,  1 ,  DEBCLRCWSABSONU ,  4FMLMBTE3ZXVEPQ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  212.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 508 ,  2 ,  1 ,  ADO86YNNLQBK0SB ,  DGZYLQIWSZQBUR8 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  80.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 509 ,  3 ,  1 ,  NPVG9EFO6LRXGAK ,  DXHNUY4LHSBHT61 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  602.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 510 ,  2 ,  1 ,  MPKXKDOT76KNTOP ,  CFRXIGLETVPG8MU , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  968.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 511 ,  1 ,  1 ,  LAG1BI4GD0DCSSP ,  Y1JHMEUB6FFD6YD ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  797.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 512 ,  2 ,  1 ,  VLQNYUOBK3EYTGP ,  5VYRPKQVATRAUDX ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  764.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 513 ,  3 ,  1 ,  BC6JRQ9UNL5D1KB ,  KNMWA4G2GTPTT2U , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  989.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 514 ,  2 ,  1 ,  KUW8OAAKGGNVWCT ,  LLRXCYY1XOK7J7N , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  893.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 515 ,  1 ,  1 ,  DVJB3KNZPBULUQ ,  WM4W5THTIWM8QNT ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  336.0000 ,  TXN-001 ,  2 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 516 ,  2 ,  1 ,  MYJKOCOVEBOJX9 ,  G0LNHEM8QCNYHO ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  650.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 517 ,  3 ,  1 ,  UVGAYN5EIKWWPMF ,  UISY7LQ6WOZBZ9 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  92.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 518 ,  2 ,  1 ,  SXERDZTZCB ,  WCZ25U3ALENC , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  690.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 519 ,  1 ,  1 ,  YWU9AIGITDVPGGK ,  GRTXDVOJ71HTU3V ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  168.0000 ,  TXN-001 ,  2 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 520 ,  2 ,  1 ,  RNPJG33IPVTDZG4 ,  DXD4UTDVT9YJX3N ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  327.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-03 21:49:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 521 ,  3 ,  1 ,  8GHK2FUXQDKHHJX ,  JNYY6ALCJUUOLRF , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  982.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-11 20:36:31 ,  1 ,  82.0000 , null);
INSERT INTO   transactions  VALUES ( 522 ,  2 ,  1 ,  VSDYGYAYAVZN11R ,  D6RSREAYCMG01YP , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  151.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 523 ,  1 ,  1 ,  JQJCGHERVDP1KYB ,  TY0XCWTWUZJBPQA ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  514.0000 ,  TXN-001 ,  4 ,  REF-2001-1 ,  9 ,  11 ,  9 ,  2013-09-09 00:00:00 ,  2014-11-09 21:54:25 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 524 ,  2 ,  1 ,  GG244QMJEQEU327 ,  YEYWIPEY40TMVXT ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  975.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-04 13:45:46 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 525 ,  3 ,  1 ,  YH0N5CQUUB6TXRK ,  PYJICGSRYU84CMS , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  138.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 526 ,  2 ,  1 ,  OWQTJYR3BPUVXDU ,  LPKZ2RXKFRBZ2UB , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  875.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 527 ,  1 ,  1 ,  FZAJGBO357OGYR1 ,  LQTUAYWUSZL0OGB ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  694.0000 ,  TXN-001 ,  4 ,  REF-2001-1 ,  9 ,  11 ,  9 ,  2013-09-09 00:00:00 ,  2014-11-09 21:54:25 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 528 ,  2 ,  1 ,  US1ZLK223UZ8IFX ,  TKYELXWFTE3GCLB ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  819.0000 ,  TXN-02 ,  2 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-07-15 11:27:55 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 529 ,  3 ,  1 ,  3YMT3TSI59S7MRJ ,  UMH1TCV3C42LDPW , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  870.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 530 ,  2 ,  1 ,  MG17R2OUIY0PRCY ,  KPKU2BDMX6SLTFB , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  760.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 531 ,  1 ,  1 ,  F4CRCAY2UFDNMN7 ,  SFHGYLLLAWWNJRI ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  528.0000 ,  TXN-001 ,  2 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 532 ,  2 ,  1 ,  GAELL4NEW1XWZPX ,  2RUML4ZNHOAV2JO ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  597.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 533 ,  3 ,  1 ,  U9DFTYEW5UUWVG2 ,  BR6XMBRI8CCOQIB , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  208.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 534 ,  2 ,  1 ,  JSSBSZLPQSTV9IZ ,  FJED8X5INDQ81YA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  720.0000 ,  TXN-04 ,  4 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-08-10 21:48:38 ,  1 ,  4.0000 , null);
INSERT INTO   transactions  VALUES ( 535 ,  1 ,  1 ,  S0MO4FR7U5WUMUK ,  ET1Y3DEXJYGD06P ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  451.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 536 ,  2 ,  1 ,  P7JALPVJJDIVUB7 ,  KNCK25VYVKW5MJS ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  174.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 537 ,  3 ,  1 ,  CCXEJ7LKHBPFBUG ,  EU4ZETKWP7NOY7E , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  392.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 538 ,  2 ,  1 ,  VN6M6G1LFGWKRT0 ,  E5E53GXJJFYEKPS , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  960.0000 ,  TXN-04 ,  4 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-31 14:53:43 ,  1 ,  960.0000 , null);
INSERT INTO   transactions  VALUES ( 539 ,  1 ,  1 ,  WRYBSX6ZVWDCNOT ,  QAD2ZS0SOQTUHAJ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  89.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 540 ,  2 ,  1 ,  M9YPEKQT6PTI1WB ,  CPQMOMBVY5LPSQV ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  16.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 541 ,  3 ,  1 ,  CETB6ACDF8YSOOS ,  NMKUYMC8QLLGYD0 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  620.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 542 ,  2 ,  1 ,  ORJKH7LHXTCXZ4J ,  S2S0KWNGA4KGBJX , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  44.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 543 ,  1 ,  1 ,  21ZZIKU0J4FO7DY ,  7FLAPLMRCJ6LYPF ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  611.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 544 ,  2 ,  1 ,  KQVPHBRJQUTPD0O ,  LRZKY6HNMI3VHQN ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  978.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 545 ,  3 ,  1 ,  RQBYL55IGJSW02I ,  09ZNXBROZT2F67B , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  886.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 23:31:03 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 546 ,  2 ,  1 ,  5GEPTOZXEWZLJTW ,  SE6AXFY5UMYSU8E , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  971.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 547 ,  1 ,  1 ,  6BAO41M1ARSVEIR ,  99PK0XKKM8ZROO3 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  601.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 548 ,  2 ,  1 ,  T9I0VBXPDY57T5A ,  E69OYKU3YSU50P8 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  384.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-28 16:31:42 ,  1 ,  27.0000 , null);
INSERT INTO   transactions  VALUES ( 549 ,  3 ,  1 ,  CPPLEHR0EL6EXT2 ,  DECQ5R6UXLOHW9J , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  784.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 550 ,  2 ,  1 ,  RQJIMKNIUEWGPKT ,  1AX2GURMBOFXOHD , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  204.0000 ,  TXN-04 ,  4 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-28 16:31:42 ,  1 ,  65.0000 , null);
INSERT INTO   transactions  VALUES ( 551 ,  1 ,  1 ,  5FYX5C0PPRPZWCY ,  H58VRYJDMLKI_id Z ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  903.0000 ,  TXN-001 ,  2 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 552 ,  2 ,  1 ,  95ULQUZODWOFPBF ,  3DKB2NGSHBWXAR8 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  683.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 553 ,  3 ,  1 ,  HKLXQHUXYQAS3DO ,  A6ZHTJYXNK4G1FO , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  96.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-28 16:31:42 ,  1 ,  20.0000 , null);
INSERT INTO   transactions  VALUES ( 554 ,  2 ,  1 ,  CQYOBNFVUK5EBZJ ,  NHX7P19QIVKCMOH , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  702.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 555 ,  1 ,  1 ,  LAAPLKF2P5CCUEO ,  RJDGTQ7MXVWXRIR ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  799.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 556 ,  2 ,  1 ,  T_id MBBDZNIJBLV7 ,  TSOQPH_id ZCHSXZR ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  571.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 557 ,  3 ,  1 ,id  NOXIQ1RTD19TA ,  JW6OJKXPLT6DLXA , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  190.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 23:31:03 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 558 ,  2 ,  1 ,  W121WWX6NQFIL37 ,  ALT6SX7OH59N2QO , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  368.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 559 ,  1 ,  1 ,  CZR0XJXVAF55AZQ ,  D35TLSI4YNOQZT0 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  312.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-04-09 18:56:07 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 560 ,  2 ,  1 ,  RSIGPFXVTWYSGBR ,  O0SIQ4HHHMAOJRK ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  77.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 561 ,  3 ,  1 ,  ZPPFU7EIHUPF2WG ,  JNAZDPYYFULAC4Z , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  108.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-31 14:53:43 ,  1 ,  108.0000 , null);
INSERT INTO   transactions  VALUES ( 562 ,  2 ,  1 ,  KA5YNDLKPBFULBA ,  9TFQLEHFO5BSODS , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  98.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 563 ,  1 ,  1 ,  T1TZDTC8L1S0TU6 ,  MSDRLUTJLAOIPPK ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  357.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 564 ,  2 ,  1 ,  D9ELYCEMEQJRVXM ,  QK6OY4NWLKNZT3F ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  722.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 565 ,  3 ,  1 ,  NQJPKT4Z5FERNXI ,  JTHYYGDUA2A2EH5 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  535.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 566 ,  2 ,  1 ,  BJB7RHFJ1CXDKVV ,  YBZ8JKD1X8TGRYN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  74.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 567 ,  1 ,  1 ,  FR11J90RFXETXHQ ,  TVJOJNFVZOTX6BF ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  63.0000 ,  TXN-001 ,  2 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 568 ,  2 ,  1 ,  RKRYDRZQGPBLKNO ,  2LZOMZYCLO2LW8G ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  323.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 569 ,  3 ,  1 ,  N8BG5FPKDHN0TPN ,  GCFX5H95E4QUVZ6 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  300.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-28 09:43:08 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 570 ,  2 ,  1 ,  LAYLVDM2MRKMMSI ,  FEOL1SUG5H90ERV , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  536.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 571 ,  1 ,  1 ,  ZMV4FN6P4RYZY7Z ,  WYRIMM9GNK16AZY ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  614.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 572 ,  2 ,  1 ,  LOUNRX0I9CC1AAD ,  OXBRPQCOSKSDF4V ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  438.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 573 ,  3 ,  1 ,  QSYJVK59IHEAOIP ,  RLHC4CLYBUUPAOY , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  928.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 574 ,  2 ,  1 ,  WWE3W5R9HLX4TVO ,  BRJ3AP16SJWCZC5 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  968.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 575 ,  1 ,  1 ,  FRBLIP95G_id BX7B ,  NSDFDYCR0SGNQ7O ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  77.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 576 ,  2 ,  1 ,  JKPCSA6OGZZUWK7 ,  HXDKVA9AMRECG3M ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  707.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 577 ,  3 ,  1 ,  TGMS2S1OKRXHEA2 ,  YJDHAVH931T9NTQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  354.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 578 ,  2 ,  1 ,  K2LI288VMJJTAL4 ,  HPI56BSJGEUYVQO , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  358.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 23:31:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 579 ,  1 ,  1 ,  SII2TNQCC7HFWTT ,  ANXBBCPZBROBYXU ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  366.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 580 ,  2 ,  1 ,  J9ZNWUASPBGSERE ,  YOWDYLW1SGYWSV7 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  50.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 581 ,  3 ,  1 ,  YAGU3XKM1UZHLRS ,  K7F7NAACGEH5OQB , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  252.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-31 14:53:43 ,  1 ,  252.0000 , null);
INSERT INTO   transactions  VALUES ( 582 ,  2 ,  1 ,  9RM1HTUUZWMO6XW ,  GN58BGV1LYXDMIM , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  875.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 583 ,  1 ,  1 ,  I2IERIXJX5UX34T ,  H6TECXGDN4Z9KMC ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  21.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 584 ,  2 ,  1 ,  RWR0B4SU8H3RGK8 ,  XN977OXUQJRFXFI ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  736.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 585 ,  3 ,  1 ,  VCG5XANF3OD0EOE ,  27TJGENHFWCKQK6 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  98.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 586 ,  2 ,  1 ,  E6QERJARVTSXLMI ,  0X7TLNSUUBKPHJ6 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  407.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 587 ,  1 ,  1 ,  93RSDU3UZJCJO65 ,  6BTFBHIOP93M330 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  284.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 588 ,  2 ,  1 ,  K6BNQJD5GRQBDX1 ,  LV4D3ZLTZ9CEKQM ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  535.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 589 ,  3 ,  1 ,  VU7BZVMFN7TT7HT ,  DFFI8OZAL6F2KIJ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  855.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-10 19:14:52 ,  1 ,  55.0000 , null);
INSERT INTO   transactions  VALUES ( 590 ,  2 ,  1 ,  30SBQXT7RNDVCUR ,  TYR2F8SVEE2ULA0 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  560.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 591 ,  1 ,  1 ,  YVWZM8O5PENW4XS ,  PP6VLDURFRTVPUP ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  16.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 592 ,  2 ,  1 ,  BNLRG24GGHXXZSI ,  DASHYB4SFYJC5WN ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  471.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-28 09:41:31 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 593 ,  3 ,  1 ,  AZFPPGCADT0HPZP ,  XXB9GQ42LEH7LQM , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  99.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-28 09:41:31 ,  1 ,  99.0000 , null);
INSERT INTO   transactions  VALUES ( 594 ,  2 ,  1 ,  RPGKAFWC8MAKWAP ,  6TV7KCMCA9M4WNA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  442.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 23:24:08 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 595 ,  1 ,  1 ,  2XZY7ZTDGHWWPQV ,  LSDMQX8OA6P5Q2X ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  554.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 596 ,  2 ,  1 ,  OWRP9ZELG6ASWV8 ,  OKD3UA4WR4UOILR ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  150.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 597 ,  3 ,  1 ,  2Q5Z0N0ANI9W7QN ,  EZSEAUICS97QPJZ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  751.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 598 ,  2 ,  1 ,  AABH5SPDOXZMVVV ,  TONCYDF8WXYDD2E , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  769.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 599 ,  1 ,  1 ,  DUHM7TMSNNDDACM ,  8ZOOVQED8BZ3ZV8 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  645.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 600 ,  2 ,  1 ,  HHCETW8JVJHX46B ,  CKJVSYOZMAANZKG ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  138.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 601 ,  3 ,  1 ,  FRFBQOIKB5KDRXC ,  JCJ5WOCCCH2V4LI , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  249.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 602 ,  2 ,  1 ,  5Y5Q6D5J4QPO5XU ,  YBHUOR7GMBFCS8Z , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  781.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 603 ,  1 ,  1 ,  HVAVQVF6YZKUJ0X ,  9GL9A2RN4PK56ZW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  575.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 604 ,  2 ,  1 ,  BVTAQSLR6JMOVYJ ,  NGZWRFS5DMTRWZ3 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  184.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 605 ,  3 ,  1 ,  XU16O8SVNU0ILMD ,  RMFUNLBXOLUMGLI , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  535.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 606 ,  2 ,  1 ,  MTHAFQTHIVMYGKP ,  QX3PZUJMWKXTCIK , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  785.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 607 ,  1 ,  1 ,  FMYUGRNAXQUNHO3 ,  POYELBJNDE9EDRC ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  804.0000 ,  TXN-001 ,  4 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-04-02 16:42:55 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 608 ,  2 ,  1 ,  Y2SDHPFBHGFJKRL ,  S63QQ6N1ATUCJ7X ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  583.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 609 ,  3 ,  1 ,  SEHJFX55ATVP2UU ,  MEPOODDIN5GCO5B , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  297.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 610 ,  2 ,  1 ,  M1ITEEGTUGQ1SZR ,  9LLEFIKMUUNUMH3 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  68.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 611 ,  1 ,  1 ,  1TZDGAPUABRNL5U ,  AHZGZITNPLHUPJV ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  675.0000 ,  TXN-001 ,  2 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 612 ,  2 ,  1 ,  ZTENWI8X2HJPVKU ,  2CURUSPYJMQM7NI ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  921.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 613 ,  3 ,  1 ,  RXXNKBD9LEBAZC7 ,  XDMFGTCAFQK0QMV , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  845.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 614 ,  2 ,  1 ,  LXNCYENWFZEEMWW ,  F3C3HLTRENTSH6W , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  276.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-28 09:41:31 ,  1 ,  276.0000 , null);
INSERT INTO   transactions  VALUES ( 615 ,  1 ,  1 ,  G8VBPAVS3FPH8WW ,  GNQFPXWJAADVSN9 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  302.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 616 ,  2 ,  1 ,  GNMC9RV0D8GEDGH ,  NE8PVZNC7TENZ9P ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  47.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 617 ,  3 ,  1 ,  NEGPRXXELAHVJG3 ,  E5VXH8OFH7038QJ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  718.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-12-12 07:54:57 ,  1 ,  18.0000 , null);
INSERT INTO   transactions  VALUES ( 618 ,  2 ,  1 ,  GETNX0RKZENYNHO ,  7OMWPWWVTTHCRGD , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  961.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 619 ,  1 ,  1 ,  OHLVC2KSE9XIPIK ,  YKNXJ4C1IVLHETH ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  557.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 620 ,  2 ,  1 ,  SYQDUQSPW9KHXDL ,  9SYPBAIK5WPYGAM ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  986.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 621 ,  3 ,  1 ,  KUYQFQF5AI32ZRZ ,  OLITP7BHETOTFQS , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  910.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 23:12:05 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 622 ,  2 ,  1 ,  C1LFZ2FEFJL7_id E ,  QHRYN4T9Z0GXXC1 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  780.0000 ,  TXN-04 ,  2 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-08-26 20:43:40 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 623 ,  1 ,  1 ,  YVHD2HG5IUPKSVD ,  OYALI4SMQIBAPU5 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  932.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 624 ,  2 ,  1 ,  F26A3SWKEMEVRND ,  OYHK4IFXRV3PHYF ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  105.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 625 ,  3 ,  1 ,  EEH55NPVARIK4HW ,  UIMUQ3I2VV4HYG9 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  823.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 626 ,  2 ,  1 ,  8LMJU1GXY4CCVNU ,  XNQ544O73BEYDOF , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  8.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 627 ,  1 ,  1 ,  W8F4K0TFODCAIAB ,  CAF9N3MTDQ19OT5 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  553.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 628 ,  2 ,  1 ,  LXN12DAB6HQOJND ,  3YQSEQRHSMZMRFX ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  784.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 629 ,  3 ,  1 ,  9BVCDZYB93UV3QD ,  JFFNYNBJFAEZGCM , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  727.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 630 ,  2 ,  1 ,  QSWHUWLIRWMPYN7 ,  XF_id PU9URPPC16B , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  557.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 631 ,  1 ,  1 ,  OGST8CZNKJ0RHGI ,  F2PLEI64ICBHPMU ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  357.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 632 ,  2 ,  1 ,  GQCN0MC83KAXMQS ,  KOARY3BYIZIHBHV ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  408.0000 ,  TXN-02 ,  2 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-05 11:15:06 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 633 ,  3 ,  1 ,  UX2IT6O6D_id QG09 ,  MTJA96M4HD9SOS5 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  696.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-08-26 17:32:23 ,  1 ,  96.0000 , null);
INSERT INTO   transactions  VALUES ( 634 ,  2 ,  1 ,  CCG6KHPJWCPRCTO ,  EVDWUC8GZL72UDN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  108.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-09 18:51:48 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 635 ,  1 ,  1 ,  VQVMCOMYQ6VPFEH ,  YQ9TMQNVQMAYFTW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  37.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 636 ,  2 ,  1 ,  ZQQYAS7XJEHBXTI ,  QABPWITEE87YFFT ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  640.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 637 ,  3 ,  1 ,  YE7J1RRXEGTODUJ ,  3QXYKBC6A6XDUIN , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  683.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 638 ,  2 ,  1 ,  HFL6AA0ZQ5IQO5W ,  EATQK4SB2BGNESN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  473.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 639 ,  1 ,  1 ,  B0P13HBQKQ4ZBYF ,  P9FGMDSJ4THFPSW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  530.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 640 ,  2 ,  1 ,  SY92BZVCCTMPERA ,  8EEWEV5H9BJLT6L ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  240.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-08-11 08:47:14 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 641 ,  3 ,  1 ,  KN2FKJNDF6UAQLB ,  V0FUDIYOFNIMWDE , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  441.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 642 ,  2 ,  1 ,  PNA82G4H5K4Q85S ,  ZSGTYULE7NEJY0R , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  419.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 643 ,  1 ,  1 ,  XQUJFHEK54EJ6XN ,  JF6B20HQY0UQ2ZX ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  985.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 644 ,  2 ,  1 ,  DDMDI1CBAYZWYGM ,  DR9ZZX6R9GPRHXP ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  191.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 645 ,  3 ,  1 ,  ULNF0FYRRODELJR1 ,  RHMCWLOYVD05NJQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  759.0000 ,  TXN-03 ,  2 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-07-09 07:37:18 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 646 ,  2 ,  1 ,  BKE5R8NLYMOPSPJ ,  RPBSHR6V6BGCNIP , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  802.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 23:19:43 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 647 ,  1 ,  1 ,  ZKQVFGOUTGUHCHA ,  SAM6OAZ6XS0ERCF ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  61.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 648 ,  2 ,  1 ,  QGUQO20496HWVFK ,  OWU5GYCIRCYFJYF ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  456.0000 ,  TXN-02 ,  2 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-08-26 20:46:41 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 649 ,  3 ,  1 ,  2WJAP6LV9DCPZF1 ,  ZU1HHS9UPCAO75H , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  557.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 650 ,  2 ,  1 ,  QBFJ3GSKIRH1CSF ,  SES2Q4REZMG744V , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  667.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 651 ,  1 ,  1 ,  T0PSCQY13OZ5STK ,  RYVVZ1ZBFJSKZR4 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  71.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 652 ,  2 ,  1 ,  U2JQWBNYBWPYLIA ,  MXWMCVB0T9Z2QKF ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  997.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 653 ,  3 ,  1 ,  6JFYNLIR8CLIMPL ,  PNGTKCYCLRMOZIT , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  739.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 654 ,  2 ,  1 ,  J9IXFG1BNNDLZUS ,  LS4EYWSUVIZBXUE , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  823.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 655 ,  1 ,  1 ,  YV0KIAUOZESHZ1F ,  ASNSJDFSOYGU1TI ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  778.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  11 ,  9 ,  2013-09-09 00:00:00 ,  2014-11-05 23:14:08 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 656 ,  2 ,  1 ,  RGFK58ZJGMNMCUP ,  UBI4PZITZB1UA7X ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  210.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 657 ,  3 ,  1 ,  3AGIOQZR_id 1GFJF ,  6DGPWOI3LLU5OUD , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  273.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 658 ,  2 ,  1 ,  NNFN9WFL958DC3U ,  9SBLNNEQLA6TAHB , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  939.0000 ,  TXN-04 ,  2 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-07-14 07:09:21 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 659 ,  1 ,  1 ,  3AVJMSONJSCPKRC ,  OGMUBDBCM96EGQA ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  980.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 660 ,  2 ,  1 ,  07JW3BNGZ9OY4KU ,  CQZZQKSHPOHKHDR ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  643.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 661 ,  3 ,  1 ,  CFS215PXQRYWLCZ ,  OZZMM84NMHDA2E8 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  548.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 662 ,  2 ,  1 ,  HIRGYJI3LKR7LNS ,  ACYET2ZM0D8KZZL , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  592.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 663 ,  1 ,  1 ,  SWFJEU6DQOPTXON ,  YRWKRFTVD17EL1T ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  509.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 664 ,  2 ,  1 ,  FTJT245RW7VE8OL ,  XKDMGGIFZ3RR5OZ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  314.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 665 ,  3 ,  1 ,  CKM4SB0WPDPADUW ,  RAJUQATGFSS9UG3 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  665.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 666 ,  2 ,  1 ,  TGK5DSIHXCAIMRW ,  LPYGXT3GQMKRJ5F , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  28.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 667 ,  1 ,  1 ,  Y2IETFLGJSAJR8P ,  YSNK54HDV5HJDW6 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  946.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  11 ,  9 ,  2013-09-09 00:00:00 ,  2014-11-05 23:09:05 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 668 ,  2 ,  1 ,  7EXBE9DCZVRTFM9 ,  7OZUEPYU35UCXEK ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  153.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 669 ,  3 ,  1 ,  VNBLMJMGJQG_id L4 ,  NEVVJIPBRCW67WH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  772.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 670 ,  2 ,  1 ,  OTFIMGZNCMDIURW ,  WSAZWJOKJLAUJLM , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  871.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 671 ,  1 ,  1 ,  MZ3YWS0V3TISYSR ,  O6X4L3LJ084EYTP ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  873.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 672 ,  2 ,  1 ,  AJPP1STJ0C5ZJHJ ,  S6ED8HNOBSBEAUC ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  76.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 673 ,  3 ,  1 ,  HAYXKWKGQDS7ZFF ,  MV9VSJLOTWJXZMU , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  807.0000 ,  TXN-03 ,  2 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-07-31 17:47:09 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 674 ,  2 ,  1 ,  LQKWNAMAGF06ZK9 ,  T757HMCGMP8AVMD , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  666.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 675 ,  1 ,  1 ,  RIBYZPAKKU0QFRO ,  BIUOFDUYMIOYI1R ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  788.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 676 ,  2 ,  1 ,  ARESEQCZO4MNQRB ,  IFIMQ0ICE6J1UDG ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  695.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 677 ,  3 ,  1 ,  VQCSOIHX94FEUSD ,  VIJVAGSFZWPARTE , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  839.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 678 ,  2 ,  1 ,  MPN2MIISLZRYLT2 ,  XALK7CCIGG5JJF2 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  433.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 679 ,  1 ,  1 ,  OTVRMETLSNEQSX4 ,  YBZF7TYX1DANKJG ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  257.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 680 ,  2 ,  1 ,  P8H4PUSYCJRK5MY ,  GH48FQXTT1ILD7W ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  328.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 681 ,  3 ,  1 ,  UCKEQN4KUSTFLJM ,  7CBG0X9JM4GROWQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  889.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 682 ,  2 ,  1 ,  UO7BKPWXTG1GLRZ ,  HIXOC2WMPPXMHR8 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  345.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 683 ,  1 ,  1 ,  SATF3EU9SNH8ZCF ,  1QILNOJOJHG7STB ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  47.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 684 ,  2 ,  1 ,  GHFCRRDJFYHOYFJ ,  G6TYXDONWJHNJJG ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  148.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 685 ,  3 ,  1 ,  AODAP3FKOCJIHTG ,  7F6SLYR6SRBRYIP , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  957.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 686 ,  2 ,  1 ,  RGANVYF5RR5KEOJ ,  UCPXYPNPZNQVJKA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  909.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 687 ,  1 ,  1 ,  DAOXV4XODIFGWFL ,  GJZJDBKZ5IYHSQJ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  635.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 688 ,  2 ,  1 ,  1PNGOZCTNM4L2X3 ,  1NQV1YOEJCSAKAC ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  562.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 23:09:02 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 689 ,  3 ,  1 ,  U7HHW1O8BDYWMPY ,  QQUNKOZYNFYH3SW , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  197.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 690 ,  2 ,  1 ,  WTAKJALYFWSWQXT ,  O3BRP0KRYEN5IYV , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  217.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 691 ,  1 ,  1 ,  F7WVWELIVPHGJFC ,  YZUFV3MIABR7R2J ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  614.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 692 ,  2 ,  1 ,  EB1JRXLKTLQTMRB ,  Y79VV6GMFO9OJRN ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  102.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 693 ,  3 ,  1 ,  UBRANUFOJBDZVT6 ,  RB5G3XNDQN0H1UE , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  642.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 694 ,  2 ,  1 ,  QPHUJMOWBF4FCV5 ,  NWJMCTECRJJCXJ4 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  172.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 695 ,  1 ,  1 ,  ELUS12W4LIEPBW7 ,  TMMWRXBCUBP48NE ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  559.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 696 ,  2 ,  1 ,  WBRJFTRCRJNFYFV ,  T9AJ0KNHZ8VGY2J ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  599.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 697 ,  3 ,  1 ,  7RYA83OLDOYV0QH ,  HKPHFQP4MZ6JQFP , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  581.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 698 ,  2 ,  1 ,  CCPQAPHOEYH3AXH ,  XB7S50ZQQUSGMIZ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  141.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 699 ,  1 ,  1 ,  D8SBVWPVJ326E72 ,  57EJT4YFOSUYNW5 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  292.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 700 ,  4 ,  1 ,  O8VDIKBLHCQTLVT ,  Y3EEINMYE3RZGEB-1 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  636.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-06 09:48:35 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 701 ,  3 ,  1 ,  8MA8XJV5HE7EFHG ,  IT5F8XVFTBR53FW , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  297.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 702 ,  2 ,  1 ,  YZY00N3OEBRBRAA ,  MSZKWMIR4WHUNSI , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  479.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 703 ,  1 ,  1 ,  HRFM48UMUVGUTSE ,  5RYVOQM3Z1OUYP8 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  881.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 704 ,  2 ,  1 ,  M1A7RFLQRABSKAU ,  D95WB3FXNDOGJBB ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  628.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 705 ,  3 ,  1 ,  RISQZYYLMGBFF6X ,  49XVSNZMLBT9A5U , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  389.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 706 ,  2 ,  1 ,  DBLQGS1M7JNXIFH ,  58WJ4VQTSSSQIZG , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  140.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 707 ,  1 ,  1 ,  CZHHR8NZJGDD7GI ,  GN5O95FNPSM98SQ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  126.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 708 ,  2 ,  1 ,  PAPEYI9XFSUNUOB ,  GQADWFISLKYS6PH ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  826.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 23:06:16 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 709 ,  3 ,  1 ,  EOVERA8GGIBVJSO ,  AJP8B4ZNXISX3TU , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  701.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 710 ,  2 ,  1 ,  CGTBVME7BI43JUQ ,  S8I3OHRF6MSKZPS , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  750.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 711 ,  1 ,  1 ,  BDAIJMOWO10RKGC ,  INTGYGXNSXY9T05 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  552.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 712 ,  2 ,  1 ,  QKLSHIVLIJBFBMQ ,  AKLLXYODM8FZWPH ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  147.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-23 16:26:02 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 713 ,  3 ,  1 ,  375DFTELQM6VJG4 ,  130YV9TR7YARW3P , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  975.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-28 09:22:28 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 714 ,  2 ,  1 ,  IKYSYEXU7HDXVQZ ,  JU7ZQ8UGNHA3ZNV , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  211.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 715 ,  1 ,  1 ,  EVYX8GWGN6FDP5G ,  I92RHJX3CJTJXLF ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  595.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 716 ,  2 ,  1 ,  OFDLUJZRACHYCHX ,  1NYNM19KYEL7W8S ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  0.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-06 09:49:51 ,  1 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 717 ,  3 ,  1 ,  CSYP57D0FJ6RUOY ,  2GHGH3EMYU7NFGY , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  414.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 718 ,  2 ,  1 ,  CRO6RM2GK5IEJSC ,  ZEMDBVNEIVKYGWU , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  198.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 719 ,  1 ,  1 ,  WCMPXBTMZFUFDJH ,  COLITDOC7LWFFJK ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  940.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 720 ,  2 ,  1 ,  TB6WMI00BIISDNM ,  4RFDBOPLT1NTZHS ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  239.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 721 ,  3 ,  1 ,  ES1EEOHHV2HSOGE ,  BWEURZNFQ9AJDY7 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  596.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 722 ,  2 ,  1 ,  ALVQU2NADVWMRIY ,  OAGXZMPDMRNT5C3 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  855.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-04 13:18:44 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 723 ,  1 ,  1 ,  HJBOU0OCZIAU4EY ,  3M90KWW6YCIVRZ8 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  229.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 724 ,  2 ,  1 ,  PG9JALTOYBAOVBR ,  FQ3IUUUYXGXLYBF ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  842.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 725 ,  3 ,  1 ,  ANOPCZRUCH0YTZH ,  VSDF0I5DI1GINGF , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  56.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 726 ,  2 ,  1 ,  SECT5HJLAPYTF4Q ,  O7ZSTZPRR0BVRHN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  267.0000 ,  TXN-04 ,  4 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-08-12 06:14:59 ,  1 ,  67.0000 , null);
INSERT INTO   transactions  VALUES ( 727 ,  1 ,  1 ,  E0OCYMSIINCA3HB ,  UJBJSQYVSDKATOW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  857.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 728 ,  2 ,  1 ,  HFLOQWXHWABNK9U ,  BQ7ICSEHW6HDGVV ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  916.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 729 ,  3 ,  1 ,  TBCCRBHONSGJX6Z ,  GPCKV3RMX9OIUHN , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  41.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 730 ,  2 ,  1 ,  2YPPRURHS201MVH ,  OOSLT3D5RHXUHEI , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  377.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 731 ,  1 ,  1 ,  WXLEZLUSQBCV35A ,  ST68UDBU473AZOC ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  129.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 732 ,  2 ,  1 ,  VXQXECYOVQSSDUT ,  L7EFOKNM0BC4TN8 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  357.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 733 ,  3 ,  1 ,  ZBFHQV4QBOZ8ND2 ,  IJ6IEPFJ1KW59VK , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  156.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-28 09:14:15 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 734 ,  2 ,  1 ,  CA6AMLSCP9FINHZ ,  HXA2FQEU3YAPFAZZ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  435.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-07-08 09:03:39 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 735 ,  1 ,  1 ,  QSH9CYCQJGS9N28 ,  SWVHABOCCBMJU1T ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  54.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 736 ,  2 ,  1 ,  DMXAPGUZDLOERH5 ,  CVKOOH53PRS6IJZ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  359.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 737 ,  3 ,  1 ,  XMP4TSXDNTSCPKI ,  PEJPXRTDPHU5XSB , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  115.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 738 ,  2 ,  1 ,  CHW45NAYJEQ90IA ,  QHB1V6QHO5DWRPN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  751.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 739 ,  1 ,  1 ,  69LNMBR1SU0GCFG ,  1B1GC1OVVWDUKZJ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  740.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 740 ,  2 ,  1 ,  6K2MBSZHJ6UMLGH ,  VZHXIRIFCXA329B ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  202.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 23:06:16 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 741 ,  3 ,  1 ,  PUQ5J5MOTZRLEAY ,  W9LM9OQKPB937Q4 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  144.0000 ,  TXN-03\ni added payment conf number and it does not reflect in Payment Confirmation No\ s ,  2 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-24 11:34:20 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 742 ,  2 ,  1 ,  EVGWVX7D2U2PRFP ,  C5UU7NYK5QKFWRJ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  704.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 743 ,  1 ,  1 ,  PBBU8ZYS8YW539S ,  KHFM_id ZAWIUQGHS ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  858.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 744 ,  2 ,  1 ,  BB4C7GSVAKFZHSK ,  ZNYDFB0FXOS50C6 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  944.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 745 ,  3 ,  1 ,  V5TZ1H34AQW0F3U ,  JW6YM2I2IA1M2XH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  354.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 746 ,  2 ,  1 ,  8QDO2CVVZSQ22XC ,  AR9HQGCE57AV1PV , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  808.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 747 ,  1 ,  1 ,  4J3F17XQTZ7YD1Q ,  CXS81O5DUQNWJXI ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  66.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 748 ,  2 ,  1 ,  PTAKJHUTIU8MN83 ,  T2CA4ANLRI6MCGF ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  387.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-31 14:51:57 ,  1 ,  170.0000 , null);
INSERT INTO   transactions  VALUES ( 749 ,  3 ,  1 ,  HPMSNIU3Q0XSPKV ,  X6A8C46HSPIQNAQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  56.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 750 ,  2 ,  1 ,  FEMFMOO3HH8S89S ,  LTTKD85PGBAP3RN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  282.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 751 ,  1 ,  1 ,  BEGPMGVVDQC6FWB ,  YWS6GXHPZV63W8G ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  563.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 752 ,  2 ,  1 ,  EHCWWPWMMSG8VTS ,  N6GHZOCVC3HBOCU ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  720.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-25 18:43:50 ,  1 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 753 ,  3 ,  1 ,  OPXGYEYDZYO1U1E ,  0F8OJSFON0IS3YL , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  115.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 754 ,  2 ,  1 ,  EBENQILNZFIHEXE ,  I6UNIF20FWBHJIO , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  171.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-31 14:45:30 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 755 ,  1 ,  1 ,  QTKKDWSDY6DWW0M ,  OXXF1JRQ1FNSEHQ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  170.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 756 ,  2 ,  1 ,  XL7GD2WB6QH3GHV ,  GM5Y2NOQW6FEFIN ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  261.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 757 ,  3 ,  1 ,  KUGJ8VNWKQ9E5Y7 ,  T1WLI4M2GT4H3IH , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  829.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 758 ,  2 ,  1 ,  DZNK69JH8ZO42NF ,  5MNQUDFR1TDT4V8 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  732.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-28 09:37:50 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 759 ,  1 ,  1 ,  RVPWJIKJH1BSIXJ ,  MI2AWBOPMTKTYUK ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  481.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 760 ,  2 ,  1 ,  FUTKOOZU8COM0LO ,  Q0TZPNOZRIP4KV4 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  249.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 761 ,  3 ,  1 ,  X3IMTQ1WLKPDBFC ,  ICXDKECPASPGIB8 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  217.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 762 ,  2 ,  1 ,  WEEANG9HTE8MPGS ,  7JDCHXQNNMXTGGS , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  879.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-27 21:12:51 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 763 ,  1 ,  1 ,  PB8QABJLSBSWO5B ,  HGV2DIHP1JY8TSM ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  79.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 764 ,  2 ,  1 ,  BENTRWXZBLS5KSF ,  QIRO6GKI2CVRGNX ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  616.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 765 ,  3 ,  1 ,  MRWQBR9QCDFTPXM ,  PXXQ6CNKDEWRL7B , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  9.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 766 ,  2 ,  1 ,  CJXERPQLLLVDBQR ,  ZA1HKMPIRMSA1TW , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  997.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 767 ,  1 ,  1 ,  CXM59ALMITASRGP ,  6SNF3DFRLX5MDRE ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  88.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 768 ,  2 ,  1 ,  VF0E5MGWJYKRVUJ ,  D7Z5OLPQ1GQPCYH ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  389.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 769 ,  3 ,  1 ,  CPT8LTZAPACSNQQ ,  GHXU55WDKS2KAIY , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  954.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 770 ,  2 ,  1 ,  1WTEINTJSBTXAYR ,  X3GTQQZ1BGOBNU8 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  742.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 23:05:02 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 771 ,  1 ,  1 ,  2EIMSZTVQHS9QRF ,  L4COTHKDDNXQPN0 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  120.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-05-23 16:58:56 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 772 ,  2 ,  1 ,  2A4R7HYP41RT5MK ,  QEC6TWWMAATRXUW ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  508.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 773 ,  3 ,  1 ,  0LE2GGGVZBLCMJK ,  1XC5OE5PYMVETLT , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  485.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 774 ,  2 ,  1 ,  YFGPY57C85S9UYU ,  N9LUFFYM44NCSJN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  896.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 775 ,  1 ,  1 ,  WHGCXZHPUC1ZCJ6 ,  MS6XDLETCG7IXXA ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  207.0000 ,  TXN-001 test ,  2 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-11-06 22:29:59 ,  1 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 776 ,  2 ,  1 ,  8NLOIJCEESOOGEM ,  QGLF4Q5OAXYCYL7 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  158.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 777 ,  3 ,  1 ,  RY5FACJF7LF3VIG ,  VXWRM5SCE5TPPUV , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  627.0000 ,  TXN-03 ,  2 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:29:59 ,  1 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 778 ,  2 ,  1 ,  6YTEXY8ULKVPB2N ,  2W6GEXEHI01B34L , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  295.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 779 ,  1 ,  1 ,  3MX2K4MZRKCZRVV ,  IQWTG4NUIOBNHS2 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  719.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 780 ,  2 ,  1 ,  QGWXIOFD7L3UPMO ,  DVNBXOI4QELVDLL ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  153.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 781 ,  3 ,  1 ,  PWMH0UNAQ0B0QBN ,  ZRVP50CPOBRF0JO , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  776.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 782 ,  2 ,  1 ,  MRLPH2AL0OPRNH9 ,  Y0TIQNBPRPZISGL , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  512.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 783 ,  1 ,  1 ,  DHRYKGRX3AM0YNF ,  HEVU1QHXQSSOIXP ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  194.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 784 ,  2 ,  1 ,  POMW7REJRNR1GLF ,  S3X0BXRWA9M71LV ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  881.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 785 ,  3 ,  1 ,  PZCIUUXMFRTZURA ,  2BGFQWWTVR2B2FS , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  859.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 786 ,  2 ,  1 ,  1IZGIZM5ZQAJXKV ,  TRIANKD4XF4HYU8 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  354.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 787 ,  1 ,  1 ,  IW5E50PJDBP_id 7H ,  NLHRVD2FBUBS6GC ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  623.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 788 ,  2 ,  1 ,  U2SRCJCTP3BWO8C ,  NBZL4M1MOHVLFT4 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  434.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 789 ,  3 ,  1 ,  1JVQWU1JF5SBKDR ,  N1LXDUTISVN9X2I , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  877.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 790 ,  2 ,  1 ,  1BKEZE1QJE9INWQ ,  VWJVDCPXAPEVFMX , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  415.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 791 ,  1 ,  1 ,  FCIYT4AOQLBSTJR ,  R6RPX6EIYMADDTD ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  919.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 792 ,  2 ,  1 ,  VGNBOQV8CVTXDTV ,  FQPPNUNQSPHUWLT ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  580.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 793 ,  3 ,  1 ,  WKNOFHMWEXQS8L5 ,  B9BPFUJFHIWPAGD , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  37.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 794 ,  2 ,  1 ,  2BSTI6VRMVE561A ,  TZNQFTOSGBZZ0LQ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  732.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-23 16:57:47 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 795 ,  1 ,  1 ,  LVC9M_id FPIEDGPO ,  GGFHK9FDOPX4MYT ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  266.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 796 ,  2 ,  1 ,  KEBFMIKEOIK8PLI ,  S3VP5AWTFPPMQIR ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  271.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 797 ,  3 ,  1 ,  LTZ8FOCC3JE3RKL ,  SRZDYWEJT8BN4BP , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  592.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 798 ,  2 ,  1 ,  QUXWT29YZHAXO5C ,  XWUPSDX8O0XZ9ZJ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  787.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 799 ,  1 ,  1 ,  3WR2BT9BBNVTHAJ ,  ZT8CUGIQPNFFMIN ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  118.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  11 ,  9 ,  2013-09-09 00:00:00 ,  2014-11-05 22:57:31 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 800 ,  2 ,  1 ,  RY6BA8WYQQZJQMF ,  LH7F5X1WPBLFCEO ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  599.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 801 ,  3 ,  1 ,  VM887DTBUQIGFXK ,  VSNTGFMNCFR9OHB , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  773.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 802 ,  2 ,  1 ,  1YUBCYEUJ7EOTP5 ,  VNJBYYQP63KV9GO , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  787.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 803 ,  2 ,  1 ,  XL2JLDXO7YDB2HF ,  PFSA7NCOJWBSZ7Y ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  204.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-05-23 16:57:47 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 804 ,  2 ,  1 ,  U2NAPGGCADEBIRN ,  NIAOMJEKUGUNS5K ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  290.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 805 ,  3 ,  1 ,  E92IJ629O55HS58 ,  XFZTYUHSQAXF5QL , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  463.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 806 ,  2 ,  1 ,  RBNUCW7Q5IVBIFQ ,  8BMMAYVQCZG5ECF , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  75.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-25 18:41:01 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 807 ,  1 ,  1 ,  SV9UY6RKTMMCYOC ,  BI8WEYUXT_id TZBR ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  207.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-05-23 16:57:47 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 808 ,  2 ,  1 ,  8NJF8DAKJFNGAOS ,  W6XLME9UXDD4IXL ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  29.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 809 ,  3 ,  1 ,  219EB8K4QZH1RLG ,  ZJ9J5J62V2GJ4CG , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  24.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-05 21:45:39 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 810 ,  2 ,  1 ,  AARJ61EUNGZJ7EL ,  ZTI1GEAREALLQOA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  236.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 811 ,  1 ,  1 ,  FCOLPHO2NBVFIWQ ,  0I89XC2QUVV0ZIW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  603.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-11-09 16:47:21 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 812 ,  2 ,  1 ,  UVBMMAWT8DCVRAJ ,  JQVJUONUGHQ0Y13 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  275.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 813 ,  3 ,  1 ,  TULRMJHWPBBO5GM ,  UYKMECKCJO8O0YS , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  479.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 814 ,  2 ,  1 ,  HP4WQTP5SQ8LSQS ,  DETATLSV189IAXM , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  10.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 22:57:04 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 815 ,  1 ,  1 ,  7HM2IFX9JGSALFY ,  XE6MPO3YF4BT0EW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  326.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 816 ,  2 ,  1 ,id  MY7PRDYVJKTTR ,  YGEZXQVNFRWQNN3 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  964.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 817 ,  3 ,  1 ,  KEECSA489WQHYSQ ,  PJTJFCIGVDJFNJD , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  269.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 818 ,  2 ,  1 ,  C33AYDQF9WKH24X ,  FT16KCWZPOKPHUO , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  564.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-22 22:43:58 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 819 ,  1 ,  1 ,  AJTBD6QHINPKEBH ,  ZNAA8REO0JXTGZB ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  106.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  11 ,  9 ,  2013-09-09 00:00:00 ,  2014-11-05 22:48:38 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 820 ,  2 ,  1 ,  NG8DDKBQJV6XZHH ,  VMLFNYXRKLHUPQH ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  54.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 821 ,  3 ,  1 ,  TDVFWX3W5PQKY50 ,  OFONKUGLFRWY57L , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  566.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 822 ,  2 ,  1 ,  CA2CPYQLD6GPHB7 ,  FTTRZKCUZNDPW6J , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  390.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 823 ,  1 ,  1 ,  KNRGVKQAYJWXIEU ,  LLUAHABT2JRY5NK ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  524.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 824 ,  2 ,  1 ,  5DUBL3NWQTPGPVH ,  JEEEUJPUVWLLVFJ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  14.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 825 ,  3 ,  1 ,  E8FCJKA0PY3PWPY ,  MRQTECCTR06ZDRW , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  598.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 22:46:41 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 826 ,  2 ,  1 ,  PA2G3VCWJPDNQDZ ,  MUWEX7SKB5HQNAF , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  894.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 827 ,  1 ,  1 ,  ULB0BEQSWUJT9OV ,  GYLUJSCWSWGFBVG ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  993.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 828 ,  2 ,  1 ,  NXB8ZGRZIAMGBOP ,  SMTVEBCEHYLVA2P ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  807.0000 ,  TXN-02 ,  2 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-09 07:49:57 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 829 ,  3 ,  1 ,  VVCAUYFAOMUUF4R ,  GWZ10WXCEBEOJFZ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  649.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 830 ,  2 ,  1 ,  AIALKWPEG6WCT2W ,  GYOFCCQWPUEWMT4 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  566.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 831 ,  1 ,  1 ,  CLFYZ1QSHKHLBHA ,  CPWXR1X8JMEMMMB ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  390.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 832 ,  2 ,  1 ,  U3M1OW1UC6BKQPL ,  EAMZTV0SYQVA97I ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  112.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 833 ,  3 ,  1 ,  ES1UOGSMRDNDMYN ,  TWWFRVHAAVB4HMQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  495.0000 ,  TXN-03 ,  2 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:27:24 ,  1 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 834 ,  2 ,  1 ,  P2PBKEWIYJTUYYZ ,  5I3NDON6IBDGRYA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  374.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 835 ,  1 ,  1 ,  FLWIKZYHMXW310L ,  WLN8IAP6QAKFEGA ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  519.0000 ,  TXN-001 ,  2 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-11-06 22:27:24 ,  1 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 836 ,  2 ,  1 ,  FXAKEGHWZ3AITIP ,  3GGUJ1FAKUQDEYE ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  376.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 837 ,  3 ,  1 ,  VEWOLTDRUQZH5M3 ,  TB0XKOIZYHJZ0BB , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  82.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 09:39:15 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 838 ,  2 ,  1 ,  QVRAWSVACSRA4PC ,  FVMYMYJSQLGXRYI , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  889.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 839 ,  1 ,  1 ,  WXIMZ8E1XEW0N4Y ,  77STHGZRYETZGNW ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  982.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  11 ,  9 ,  2013-09-09 00:00:00 ,  2014-11-05 09:39:15 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 840 ,  2 ,  1 ,  V1ULOTWDQJGSZXJ ,  73JF6BSQGRQFSRI ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  996.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-06-17 13:16:01 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 841 ,  3 ,  1 ,  VHHGHK0EXPYGEOB ,  P5KRYW9SEKUKFHA , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  891.0000 ,  TXN-03 ,  2 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:27:24 ,  1 ,  91.0000 , null);
INSERT INTO   transactions  VALUES ( 842 ,  2 ,  1 ,  PRSSFKJPYBIT4CP ,  2HNKVZO69DMYMA4 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  320.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 843 ,  1 ,  1 ,  XMBL4OLSOFBJ3SC ,  E9EJXFXDF5SEH5H ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  388.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 844 ,  2 ,  1 ,  WUBVKSMXTR5Q5VG ,  COC62L9PBGW0UYS ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  749.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 845 ,  3 ,  1 ,  LB6OZP665GUJZ3X ,  PUVRITJICWVYTAC , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  21.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 846 ,  2 ,  1 ,  H8HFMMJ9XWXER1C ,  KJB8SZ1YLEKG2IP , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  867.0000 ,  TXN-04 ,  3 ,  REF-0343535-1 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-27 23:41:44 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 847 ,  1 ,  1 ,  ROYE6SHN3KDGFER ,  XICYPZBGN2YMCTJ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  791.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 848 ,  2 ,  1 ,  WYORC1XMZZ0J58U ,  WHZYCFHULCNXAGL ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  509.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 849 ,  3 ,  1 ,  X9I7P4QCXPXFVAO ,  PJK7QXUVEM6AB5Z , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  536.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 850 ,  2 ,  1 ,  R1Z6KVIVNPNRIRM ,  5O5UPP9EHXRHARL , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  804.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-26 18:23:52 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 851 ,  1 ,  1 ,  ANVDMSVBVVODPZ2 ,  PC6VGCSPRKGNB4B ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  726.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 852 ,  2 ,  1 ,  JTNWBRHGLIS9BQ099 ,  RMV0MEFSUMSTB56 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  750.0000 ,  TXN-02 hello and thank you for calling ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-04-27 14:30:27 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 853 ,  3 ,  1 ,  ERIEEXZOQ2LYMJG ,  Z5MCL83TIXIBBZE , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  619.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 854 ,  2 ,  1 ,  OLW4FDORLC0J1GZ ,  BHS5UDWCN96SRYP , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  210.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 855 ,  1 ,  1 ,  Z_id GFN33M1T0SB4 ,  LAMTMZGTPDKQZ2P ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  262.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  11 ,  9 ,  2013-09-09 00:00:00 ,  2014-11-05 09:39:15 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 856 ,  2 ,  1 ,  M1TZN6XW40TX0OH ,  WKHDKCOXFCQQTA6 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  802.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 22:46:15 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 857 ,  3 ,  1 ,  HDZ2BS7G7E8ZSOK ,  VU0EXCNLZPKNB2Q , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  518.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 858 ,  2 ,  1 ,  MXP76T22TFEKD7H ,  ONZTQON2ECZVYMM , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  978.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 859 ,  1 ,  1 ,  UXDQULK1CTON8PX ,  VTAUBL1EQ4N42PY ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  547.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 860 ,  2 ,  1 ,  SAETF2UF1VXCIGC ,  UKUCPSUPUFPI1OT ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  545.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 861 ,  3 ,  1 ,  TFQ43QZUQXCODYO ,  PHXKMCYSTRBH0F7 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  51.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-08 07:56:23 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 862 ,  2 ,  1 ,  R1RXDASHEEKP9TD ,  HIKD8N5R318NLGQ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  546.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 863 ,  1 ,  1 ,  1FZN7PP0H_id KSHM ,  00DBB437R7LP4X0 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  8.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 864 ,  2 ,  1 ,  JKIAPHZU8DKWNUO ,  9KMFU1EQRVXL8L6 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  256.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 865 ,  3 ,  1 ,  CCIVM6GXFQ84ELV ,  LD63TPG1KIT7PZW , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  461.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 866 ,  2 ,  1 ,  VMTZCTCSEGZMM81 ,  BF6EPWSVRHOCXZR , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  73.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 867 ,  1 ,  1 ,  9JDWKM0OR7MW9RN ,  FX5JIIMPLRQB6BJ ,  Test Rcv ,  Crt ,  2 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  975.0000 ,  TXN-001 ,  2 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-11-06 22:27:24 ,  1 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 868 ,  2 ,  1 ,  AIVAIG1L6RGWE1T ,  TNBM8UESVYMAWNM ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  116.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 869 ,  3 ,  1 ,  9QWARUVBHLGEFVN ,  N7OMJRDRNJSZT3A , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  859.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 870 ,  2 ,  1 ,  Y321KSI67P2P7FL ,  ANNETDUTDGVCGJA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  220.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 871 ,  1 ,  1 ,  SZYSHLR7EKCCLDU ,  MVJRLYHUS3WR68P ,  Test Rcv ,  Crt ,  1 ,  2013-11-26 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  3900.0000 ,  TXN ,  3 ,  REF-2001-1 ,  12 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-05-23 16:57:12 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 872 ,  2 ,  1 ,  UBS5SZQFMC2NJE7 ,  B9Y9T6OSAZDXWWG ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  736.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 873 ,  3 ,  1 ,  NYJYKK4CEQQMJH6 ,  UWAFE2PXGWRIZFZ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  420.0000 ,  TXN-03 ,  2 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:26:41 ,  1 ,  10.0000 , null);
INSERT INTO   transactions  VALUES ( 874 ,  2 ,  1 ,  YJMSMWCZG5BGHS6 ,  MLPXHMJPD3CKT7A , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  719.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 875 ,  1 ,  1 ,  MZIKCJ95W72DMC3 ,  M6JQGLSNLOKRSRU ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  576.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-05-23 16:29:13 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 876 ,  2 ,  1 ,  NQJJANISSM1QD9X ,  NULW2JRM4RIBJ4T ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  546.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 877 ,  3 ,  1 ,  42YYYYOK4SVYUEQ ,  M1JPU4NMJSB9UWJ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  643.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 878 ,  2 ,  1 ,  0LQHYGNPSJSJGGU ,  LKB7RDF7ZWXUC0S , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  184.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 879 ,  1 ,  1 ,  GVN2RMBXAKRWF5Q ,  0WQEYX4ZBGY3MZX ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  68.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 880 ,  2 ,  1 ,  DGFVUA1A2OLL5PB ,  C21INZ502ZWIHBM ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  170.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 881 ,  3 ,  1 ,  WIYYNWWE6CDNLVQS ,  O7ZZMLSWUIIPL6P , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  468.0000 ,  TXN-03 ,  3 ,  REF-00234-1 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-05-23 16:24:34 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 882 ,  2 ,  1 ,  SGDCZZ5YGNYTCJO\\\\\\\\ ,  AVCJOSXO1Z6Q0BI , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  36.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-04-20 21:30:19 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 883 ,  1 ,  1 ,  Z0KGZ9ESOPAYMKD ,  OVUARCXFTBWAZYL ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  837.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 884 ,  2 ,  1 ,  80MCDDHC0NDGYFW ,  JOQLEVKHBTD24GB ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  550.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 22:32:09 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 885 ,  3 ,  1 ,  RDH6DZMWFBACAAL ,  4VKS27KJIKVPD7F , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  304.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 886 ,  2 ,  1 ,  SSFPXAWJ8F2ZQUY ,  SULU8TLSODI_id HN , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  605.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 887 ,  1 ,  1 ,  OGWEXEXSGCQJT8Y ,  8JKUVSEALDZLPWK ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  503.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 888 ,  2 ,  1 ,  4JGEGAMFVSHN4AL ,  IKKTVKD3EERNVMQ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  871.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 889 ,  3 ,  1 ,  JCDHY6ITFEJ0CTI ,  C1OTBR6SHYKUD7C , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  756.0000 ,  TXN-03 ,  2 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:26:41 ,  1 ,  120.0000 , null);
INSERT INTO   transactions  VALUES ( 890 ,  2 ,  1 ,  HKJULRRTA95TSZS ,  AV07HUCQTZDE0YH , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  914.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 891 ,  1 ,  1 ,  1BNOCHNIBVDZIKQ ,  ZLRT6CPWQFKH9W4 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  762.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  7 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 892 ,  2 ,  1 ,  VIZFONHGENADXLO ,  KFCB9RP3ALW36WC ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  454.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 22:32:22 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 893 ,  3 ,  1 ,  Q7KPVNJ2MSFRGT7 ,  1Q1TF7QMSKMJK00 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  786.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 894 ,  2 ,  1 ,  KMPF_id SSRELJEOB ,  6XONXUXZUI7KO9A , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  82.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  11 ,  9 ,  2013-01-01 00:00:00 ,  2014-11-05 22:32:22 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 895 ,  1 ,  1 ,  PSWNMPHVON44VND ,  JXOWDEZTMYHIYVT ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  57.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 896 ,  2 ,  1 ,  XYSJYYYNQMRLFCF ,  DXGPFX3ZGXMBCVY ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  434.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 897 ,  3 ,  1 ,  OPB4FUH8ZF1RJOX ,  VCFGAH4ZP673V0M , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  746.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 898 ,  2 ,  1 ,  QFRLGN0ZNI0HE0H ,  OYWYA0MJHNZZTX8 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  95.0000 ,  TXN-04 ,  1 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 899 ,  1 ,  1 ,  PESELWWZUYVPL2A ,  G2V1ALRCAQAVNCV ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  2.0000 ,  TXN-001 ,  1 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 900 ,  2 ,  1 ,  CYJD8DG2DSP9KAQ ,  ACXDABW2XVNWNYX ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  92.0000 ,  TXN-02 ,  1 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 901 ,  3 ,  1 ,  MXKNCDK9VKVT16H ,  CZ0ODD0XQX2KTML , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  811.0000 ,  TXN-03 ,  1 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 902 ,  2 ,  1 ,  OPV6AWE8ZDA4YLN ,  SIQ5VE7QXYLYXW7 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  534.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 903 ,  1 ,  1 ,  E3J3YQPOYPN2WQM ,  YQIZXDM06HK8O90 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  899.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 904 ,  2 ,  1 ,  4MAIVWEOXOEMAJG ,  H4N5RD9QY7YFUEU ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  203.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 905 ,  3 ,  1 ,  25RUBXDGM6KWA7Q ,  V2AXELKB5JVXVLQ , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  337.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 906 ,  2 ,  1 ,  8RHTLSS0YRPJXBZ ,  KTRREKJUH0GJIWJ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  803.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 907 ,  1 ,  1 ,  BKZ5TDMTGPDP0EL ,  I8SCXGMVTU20CQ3 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  704.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 908 ,  2 ,  1 ,  ISIEOW5D69YHIOA ,  XC9TEJXAIZL3XI4 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  278.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 909 ,  3 ,  1 ,  IF1_id D7ILKDGY8W ,  RJ3JPGTDDWF01GX , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  246.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 910 ,  2 ,  1 ,  6IFQHEVLXMLYBPW ,  TBBZGENRTTORUSY , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  424.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 911 ,  1 ,  1 ,  NEURRAQIQVNPY1Q ,  R6JY3EGAU6WSXKF ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  40.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 912 ,  2 ,  1 ,  YGEDG2YPJLHTYTL ,  MV0IUVMZYQF8TBH ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  233.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 913 ,  3 ,  1 ,  UVPZCCFSHAKIIAN ,  OJ5NEOBD67NN3RR , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  189.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 914 ,  2 ,  1 ,  ZUSYCQJ1FLW797O ,  NEJKXBN_id XXTDBL , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  456.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 915 ,  1 ,  1 ,  LYDZPFKPTYXLNLM ,  FLHRJYDMAFKYMDK ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  84.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-05-13 08:30:34 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 916 ,  2 ,  1 ,  3UWO1AJWFTFFCMB ,  CMOIPG7NXRGWXEP ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  690.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 917 ,  3 ,  1 ,  VWSFD9DYTRNI9Q4 ,  JMT0RKK2HJCSNSS , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  525.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 918 ,  2 ,  1 ,  TYHM8HG0VBRVEST ,  1GBTN6TBSAGBVY1 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  94.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 919 ,  1 ,  1 ,  73ABIB4ETWDDNO3 ,  HZUEUOTXLEAPZCK ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  381.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 920 ,  2 ,  1 ,  221IXOFKOBZT4XT ,  4WONFNUI2GKAIEN ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  149.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 921 ,  3 ,  1 ,  KPPZ8FLHV05AX32 ,  EWBFK277XIQZSWG , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  563.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 922 ,  2 ,  1 ,  K5ERY4ATOTHCUYB ,  FMDD3DB0OS97SWL , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  508.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 923 ,  1 ,  1 ,  0W7NWNAP4DBUI9O ,  MUD82JU6MZNGO4E ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  345.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 924 ,  2 ,  1 ,  VIGW98U3PJNN31C ,  2GCZPTJNEW3H0NV ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  894.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 925 ,  3 ,  1 ,  92KNYM3WSX39OWB ,  H49FZMX5NH46DFW , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  892.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 926 ,  2 ,  1 ,  BA0EAQKBEY5SJN6 ,  OOTRMIPXOTKZXYL , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  612.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 927 ,  1 ,  1 ,  UKN4S3MRJHZZ7JH ,  MTK1X1QLPOAIHY8 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  237.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 928 ,  2 ,  1 ,  T52KQCJSQUFYFX4 ,  JBY3DL3VP5TPB0S ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  105.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 929 ,  3 ,  1 ,  E0GWV8LNHRZQNUS ,  FFGPLHMLFIEAYAT , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  889.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 930 ,  2 ,  1 ,  VNSUQQQHTC3_id G6 ,  1UZNKO5LAGBR1KQ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  516.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 931 ,  1 ,  1 ,  LXVX5ZZ8WBGSGDP ,  1CF5K3U1W8DN9NN ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  116.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 932 ,  2 ,  1 ,  CUAB6TDCLOAU1Y6 ,  DMCPNI4SLD89VUL ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  114.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 933 ,  3 ,  1 ,  RO13XXRPUFRGKVY ,  MDHZKWFPWJUC3PF , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  641.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 934 ,  2 ,  1 ,  BRLVH7R146CDGYD ,  3FWNMJSVBENGBZD , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  4.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 935 ,  1 ,  1 ,  Y8QJD2Z4SPHYWNH ,  XSBASVRSI1LIWVS ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  188.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  9 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 936 ,  2 ,  1 ,  JYTJAFLTEOTKWYX ,  NCDMN3XFWD0YASH ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  786.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 937 ,  3 ,  1 ,  CS1ZDXXBFOX6LZA ,  YO0NV29VZQBDAHF , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  812.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 938 ,  2 ,  1 ,  UPJS6Y31A7ZEVC7 ,  UL3ESGVMVD9L6Q0 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  694.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 939 ,  1 ,  1 ,  MB3YPATDGUX5EEC ,  7VYQWKXWKPTBJOR ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  106.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  11 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 940 ,  2 ,  1 ,  IG9LQUPMXOCNAHE ,  LCPAEMWG0LALCDE ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  891.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 941 ,  3 ,  1 ,  6OLCYMXBDXXPA73 ,  BS2TZK3KWLRHTE8 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  359.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 942 ,  2 ,  1 ,  WAOT3EQEHQPPCVD ,  J8MTXZVQNNRDC49 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  980.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 943 ,  1 ,  1 ,  YU5E8ZCPETDQZHK ,  1LLVFPNLL7FWTMM ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  341.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 944 ,  2 ,  1 ,  HQSFKXGADKTDD5W ,  XREH23RMPBQVLQG ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  34.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 945 ,  3 ,  1 ,  PAKVOQGXGFSOPQF ,  6UV1WT6UAKGKCZX , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  36.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 946 ,  2 ,  1 ,  1KTI8OBFE486QPC ,  KUQJFGKEYYLUZMJ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  671.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 947 ,  1 ,  1 ,  AEQI6LM7KWPMRW8 ,  DDLK1Q4LRC6EWOL ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  859.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  8 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 948 ,  2 ,  1 ,  D4GM6OAHSOAA9XG ,  DKVRLIGZHKQEIUF ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  889.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 949 ,  3 ,  1 ,  PCVIRJFCX39LQP5 ,  91LJLYFJ9LUE9B1 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  718.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 950 ,  2 ,  1 ,  JYD0EAK5Z4XGQCD ,  BYXQI6VAPFFKTWH , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  340.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 951 ,  1 ,  1 ,  SZJ7ZG95STHMKLC ,  ODVDPWR0SK3HDVV ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  553.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 952 ,  2 ,  1 ,  WWBD9ZE8FIYVPQ8 ,  JI2IGVPXECLEN5X ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  658.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 953 ,  3 ,  1 ,  BAAWHFLCEGV2OYX ,  XT68C1OHK5KXW0G , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  91.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 954 ,  2 ,  1 ,  1M9IT1HP8USAQWZ ,  2OUCBEHMDTBQX3R , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  775.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 955 ,  1 ,  1 ,  HBTYAWN8XKFREAF ,  SDG1ADPOBOCEYRM ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  993.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 956 ,  2 ,  1 ,  FGAKDNHGYWGKPUP ,  2BT2M6XVHQDRZHJ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  257.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 957 ,  3 ,  1 ,  BPKVPKLNWLACVDO ,  F8BLDWXSCS7SIGM , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  145.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 958 ,  2 ,  1 ,  OA8URI5RTPC3MNK ,  8LNTLZSFEEL0MHY , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  760.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 959 ,  1 ,  1 ,  TDSMRXS5EXZYPVP ,  IC8ONKDHM2FXRFR ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  929.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 960 ,  2 ,  1 ,  SGHSTW4W66Z2QAP ,  WE5X5PBFXME7N0N ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  803.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 961 ,  3 ,  1 ,  X44U5MLAOSKSGQ0 ,  SMDNNWSAXFORYDI , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  827.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 962 ,  2 ,  1 ,  C6LAHHQKV86NJPF ,  5WKSN81VMTUACJK , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  675.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 963 ,  1 ,  1 ,  KI1KUDFOSV2SAFF ,  CCUSNLN2Y6GYMUD ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  287.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 964 ,  2 ,  1 ,  AMJQSS0GPVK2DRG ,  3EPITFJDKQHJAE3 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  120.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:46:24 ,  1 ,  5.0000 , null);
INSERT INTO   transactions  VALUES ( 965 ,  3 ,  1 ,  FWEEVKZMHCMSTAO ,  N8IYVBWW2OPBSD4 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  185.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 966 ,  2 ,  1 ,  Y9MXXWXHFN4PC9J ,  NMN2AO4T9XDLLI3 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  296.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 967 ,  1 ,  1 ,  JHQXF4LX7BSOUFI ,  SGBIM0Q8T1XNDHU ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  48.0000 ,  TXN-001 ,  4 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-11-06 22:46:24 ,  1 ,  5.0000 , null);
INSERT INTO   transactions  VALUES ( 968 ,  2 ,  1 ,  ALLOPEVZJJCPCUQ ,  HBTNGOHQKIOR7JA ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  837.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  10 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 969 ,  3 ,  1 ,  3DXNOALTGYZGXBB ,  WVJSEVZFL257TAR , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  625.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 970 ,  2 ,  1 ,  REJ2HJDLK8FEN15 ,  W7U77MWE50GDTAQ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  546.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 971 ,  1 ,  1 ,  AK0DUWDC8PDFC4M ,  HTNTO5NATIOPE3V ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  778.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  11 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 972 ,  2 ,  1 ,  ZFEWY36YXHUVAWW ,  HVWIRFMNEH6KWZY ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  778.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 973 ,  3 ,  1 ,  LISSILAUHNDRM1Q ,  VURJSSWFIPSNG49 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  163.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 974 ,  2 ,  1 ,  M3G4W0S631VASP7 ,  ZXAYC7WTLH6DCG1 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  531.0000 ,  TXN-04 ,  4 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:46:24 ,  1 ,  5.0000 , null);
INSERT INTO   transactions  VALUES ( 975 ,  1 ,  1 ,  XAGMKB9GWBEV6SA ,  FGTZCWAMTMPZJMT ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  245.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 976 ,  2 ,  1 ,  EACOQVKY25XDRKK ,  ND6XQMDIRTFOOGB ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  154.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 977 ,  3 ,  1 ,  QYOVSZOU1LKP4VJ ,  WQ9KOXWZ3OENAJF , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  529.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 978 ,  2 ,  1 ,  P28QTSU68HLS4SU ,  FYZBJ32QXYR02HC , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  283.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 979 ,  1 ,  1 ,  YM8TJQMYXLRZZOT ,  3C4DZWPUVAF80CC ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  193.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 980 ,  2 ,  1 ,  NMBKQXOIXWMQFQI ,  GYZ1ZPO76XWRKJZ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  68.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 981 ,  3 ,  1 ,  PC647GDAALEQGUS ,  ZDG767TZIBXHUMA , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  199.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 982 ,  2 ,  1 ,  DKIGYK22AXKBIWK ,  BVQTFIA8EP9PXCD , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  950.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 983 ,  1 ,  1 ,  DIT5MKFA29CYFEF ,  CK2G4XA5IO0TWP9 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  779.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  12 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 984 ,  2 ,  1 ,  1BLNSHYNQQUTCES ,  9W1AY0VMYWJ2IIR ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  966.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 985 ,  3 ,  1 ,  AV5C3FYRFNXOY7P ,  PHHQFGKU9RKNQRI , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  659.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 986 ,  2 ,  1 ,  AYLH77NJVMKWX2U ,  8VQSQB1Z15U5GR6 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  154.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 987 ,  1 ,  1 ,  LRBP8CCI0VWD2KG ,  12TSLRFI4D9XX50 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  957.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 988 ,  2 ,  1 ,  ZHHUQ2NXQXSGRYP ,  A0TQZOTITH806TS ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  320.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 989 ,  3 ,  1 ,  KKQSUH3KA5NVFRD ,  ZUYSLM6Z21KSGHC , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  426.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 990 ,  2 ,  1 ,  DLWKX4GDQRCZICE ,  UDNZEAIOFJOXXZZ , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  398.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 991 ,  1 ,  1 ,  WU7WYHECYDHDQ9W ,  X1WCLHELCMW9NGE ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  148.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 992 ,  2 ,  1 ,  JPUA9ZVHDG7QDK3 ,  XUDDHBSMUFRTPMY ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  98.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 993 ,  3 ,  1 ,  VCEROWDQ4A8EXDF ,  BFLAATP0UZCCTAD , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  14.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 994 ,  2 ,  1 ,  3XGH5E6GNJ5DIPN ,  9N7GJAWPTLMRPSE , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  774.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  7 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 995 ,  1 ,  1 ,  7QJQHKC5BH4E8CZ ,  5HVPBRH11BWGHR3 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  417.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 996 ,  2 ,  1 ,  CTVV0AJVTQ1YVDA ,  V924HXUUX9EVO2Q ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  648.0000 ,  TXN-02 ,  4 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:41:48 ,  1 ,  5.0000 , null);
INSERT INTO   transactions  VALUES ( 997 ,  3 ,  1 ,  DDDCNAW5GIYGDJA ,  PFSMNKSMD8OINCM , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  661.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 998 ,  2 ,  1 ,  J2XJTYUIB8JY7ZO ,  08UV25HCBLAWPJL , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  578.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 999 ,  1 ,  1 ,  V9BOYCJFSNE8ABN ,  LO36NBNSGOFD7AJ ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  855.0000 ,  TXN-001 ,  4 ,  REF-2001-1 ,  9 ,  3 ,  1 ,  2013-09-09 00:00:00 ,  2014-11-06 22:41:48 ,  1 ,  5.0000 , null);
INSERT INTO   transactions  VALUES ( 1000 ,  2 ,  1 ,  VPJTYABFY9GYSJ6 ,  WNMKDT9YVP32XSX ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  891.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-09 16:45:18 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1001 ,  3 ,  1 ,  TAYYRR93ADPQPF6 ,  GQPPL34YUFAK84Y , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  205.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1002 ,  2 ,  1 ,  FWDKPZIV4TQOF84 ,  HRLW5GKUTS7MFXD , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  540.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-09 16:45:18 ,  1 ,  540.0000 , null);
INSERT INTO   transactions  VALUES ( 1003 ,  1 ,  1 ,  2HIWOOFY5YMJ93C ,  TIO0EI0ZFFCDVFX ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  369.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  10 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1004 ,  2 ,  1 ,  AKHREPJRMDKJOQC ,  9WRDATMTNENUPED ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  632.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1005 ,  3 ,  1 ,  CMZR46XAMH6HAW9 ,  F4D1R70RB4RVR8P , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  55.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1006 ,  2 ,  1 ,  YBFAN2YYPMLGIFS ,  W3FZGZBSVVOYEP6 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  904.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1007 ,  1 ,  1 ,  SK8WUFAT4WCOLUP ,  EAZVPDMMWCALLH2 ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  712.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1008 ,  2 ,  1 ,  UKUMK49IJQQM38B ,  LTCUS0OJLZ8S6EJ ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  989.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1009 ,  3 ,  1 ,  4WLVFWTZZ0ORXRY-1 ,  ZLOSXNL2IEOKH54 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  684.0000 ,  TXN-03 ,  4 ,  REF-00234 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:41:48 ,  1 ,  5.0000 , null);
INSERT INTO   transactions  VALUES ( 1010 ,  2 ,  1 ,  M1Y4FIYLKGV9P6L ,  OSV3Q36JGKKGUB0 , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  370.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  11 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1011 ,  1 ,  1 ,  EFV3UXQ_id HKTMAB ,  S1FT1QCGQUD7SWD ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  445.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1012 ,  2 ,  1 ,  VGZEMZW7JL6AIM2 ,  6NGGPQETXJMSZE1 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  16.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1013 ,  3 ,  1 ,  6UYPELK5TY0PD2H ,  S7XCDY4JOBJHGY3 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  127.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1014 ,  2 ,  1 ,  UFMN3VZYOJ2JOYC ,  HWPNUW44TLUPOEA , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  67.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1015 ,  1 ,  1 ,  P8ACT6I0NWSGPC2 ,  O4ZZEJ9RP7NRIUY ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  70.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  11 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1016 ,  2 ,  1 ,  NKACR2AHJP1CV4G ,  6SITATSLL4JZLM5 ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  824.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  9 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1017 ,  3 ,  1 ,  4LHINQGXP1SLSTA ,  0ICBV7ZKOPDTKTA , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  503.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1018 ,  2 ,  1 ,  NJ74UJXJIRBED5F ,  0J3LLEEX3KAYFHM , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  661.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1019 ,  1 ,  1 ,  CMTYDEHRWCZBFPR ,  C4CR7QNJHC5VJAN ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  821.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  6 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1020 ,  2 ,  1 ,  P4MRF3IHMNKEX2Z ,  RLBOH1AAYD0ZFWR ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  511.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  8 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1021 ,  3 ,  1 ,  PUL3TIJ6QDQPWPL ,  TNZGYOMRWYZZTU2 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  293.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1022 ,  2 ,  1 ,  JODFY3KQR6SQAR4 ,  XLW25UW6P0GA1TI , null, null,  1 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  160.0000 ,  TXN-04 ,  3 ,  REF-0343535 ,  9 ,  5 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1023 ,  1 ,  1 ,  AD4FTO35BHLKHKT ,  V7TGCZCNLVW8WIC ,  Test Rcv ,  Crt ,  1 ,  2013-11-22 00:00:00 ,  2013-11-24 00:00:00 ,  2013-11-24 00:00:00 , null,  340.0000 ,  TXN-001 ,  3 ,  REF-2001-1 ,  9 ,  5 ,  1 ,  2013-09-09 00:00:00 ,  2013-09-09 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1024 ,  2 ,  1 ,  PMIPEVSA7RGO0T8 ,  VRBFB8FHEQH3QYU ,   , null,  1 ,  2013-09-09 00:00:00 ,  2013-01-01 00:00:00 ,  2014-01-01 00:00:00 , null,  491.0000 ,  TXN-02 ,  3 ,  REF-0000000 ,  9 ,  12 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1025 ,  3 ,  1 ,  L96A8EKFI2HBNXI ,  Q6XYIUCZJGFNOM3 , null, null,  1 ,  2013-01-01 00:00:00 ,  2013-02-01 00:00:00 ,  2014-01-01 00:00:00 , null,  62.0000 ,  TXN-03 ,  3 ,  REF-00234 ,  9 ,  6 ,  1 ,  2013-01-01 00:00:00 ,  2013-01-01 00:00:00 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1026 ,  2 ,  1 ,  NVVZMGOQXSBHPYD ,  IZAZZQKTWA0DSPJ , null, null,  2 ,  2013-09-09 00:00:00 ,  2013-10-10 00:00:00 ,  2014-01-01 00:00:00 , null,  579.0000 ,  TXN-04dertfyguhijokpluihygftdfyguhijokpj\nxfchgvjbklhkgfxdcghvjbknml\ngc hvbjknlm;jhgvcvhbjn ,  3 ,  REF-0343535 ,  9 ,  3 ,  1 ,  2013-01-01 00:00:00 ,  2014-11-06 22:56:02 ,  1 , null, null);
INSERT INTO   transactions  VALUES ( 1027 ,  2 , null,  333 ,  333 , null, null,  1 ,  2014-02-05 00:00:00 ,  2014-02-07 00:00:00 ,  2014-02-13 00:00:00 , null,  333.0000 , null,  4 ,  333 ,  3 ,  12 ,  1 ,  1900-01-01 05:00:00 ,  2014-08-07 19:30:40 ,  0 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 1028 ,  2 , null,  121212345-654 ,  maeu483759569 , null, null,  2 ,  2014-04-09 23:00:00 ,  2014-04-16 23:00:00 ,  2014-04-30 23:00:00 , null,  5800.0000 ,  asdfasfdvg\nsfgsfrg\n\naergsefgsdg\nsfgsefgdsfg\nsafgsegdsfg\nsdfgsefgsfg\nesfgsfdgsdfg\nafsfdaf\nwafsfafs\nwfsafsafsa\nfwrrfsfsfgg\nsfgsffdsgfdf ,  1 ,  REF biller 12-1 ,  3 ,  12 ,  1 ,  1900-01-01 05:00:00 ,  2014-04-17 17:50:50 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1029 ,  4 , null,  erer ,  erer , null, null,  1 ,  2014-03-05 00:00:00 ,  2014-03-05 00:00:00 ,  2014-03-05 00:00:00 , null,  444.0000 ,  There should be away to have people know that there is something in this field. ,  3 ,  eerer ,  3 ,  12 ,  1 ,  1900-01-01 05:00:00 ,  2014-07-21 22:56:05 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1030 ,  4 , null,  1234 ,  1234 , null, null,  1 ,  2014-02-28 04:16:57 ,  2014-02-28 04:17:05 ,  2014-03-01 00:00:00 , null,  34234.0000 , null,  3 ,  1234 ,  3 ,  12 ,  1 ,  1900-01-01 05:00:00 ,  2014-07-21 23:03:36 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1031 ,  3 , null,  FD76367483-3333 ,  MAEU73874768 , null, null,  1 ,  2014-03-07 00:00:00 ,  2014-03-22 23:00:00 ,  2014-03-07 00:00:00 , null,  30000.0000 ,  i AM ADDING INFORMATION HERE JUST BECAUSE ,  3 ,  567890 ,  3 ,  6 ,  1 ,  1900-01-01 05:00:00 ,  2014-07-25 00:10:15 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1032 ,  4 , null,  SAMPLE898656467879 ,  SAMPLE37682749 , null, null,  2 , null, null,  2014-04-08 23:00:00 , null,  4589.0000 ,  This transactionsis a shipment from NJ to Africa ,  2 ,  REF-36252984 ,  12 ,  3 ,  1 ,  2014-04-07 07:55:01 ,  2014-11-06 22:26:41 ,  0 ,  4589.0000 , null);
INSERT INTO   transactions  VALUES ( 1033 ,  3 , null,  INV89898989898-1 ,  MAEU59396040 , null, null,  2 ,  2014-04-02 23:00:00 ,  2014-04-30 23:00:00 ,  2014-04-16 23:00:00 , null,  3348.0000 ,  I am testing to see how many characters I can really add in the description field. I think that this field look pretty cool to add as much shit as you want to get the point across to all of the things you want to add in this field. I wonder how many characters I have actually written down already, I think I have written quite a bit in this field. I think I am going to copy this on to a note pad or work to count how many characters I have actually written down already. We should add a counter to tell you how many characters you have left. ,  3 ,  PAY-11989 ,  3 ,  11 ,  1 ,  2014-04-16 19:42:32 ,  2014-08-17 11:12:02 ,  0 ,  3348.0000 , null);
INSERT INTO   transactions  VALUES ( 1034 ,  2 , null,  4567898765dd ,  MAEU73874788899 , null, null,  2 ,  2014-04-09 23:00:00 ,  2014-04-30 23:00:00 ,  2014-04-18 23:00:00 , null,  5334.0000 ,  aqui estoy con Agustin.\n-Saludos de mi parte... El Pupilo ,  3 ,  r46tyu77865-1 ,  3 ,  6 ,  1 ,  2014-04-18 11:50:25 ,  2014-10-03 05:37:48 ,  0 ,  66.0000 , null);
INSERT INTO   transactions  VALUES ( 1042 ,  4 , null,  MAEU4367384 ,  43r3kljaj34 , null, null,  1 ,  2014-05-15 23:00:00 ,  2014-06-19 23:00:00 ,  2014-06-01 23:00:00 , null,  4590.0000 , null,  3 ,  srn347493 ,  6 ,  3 ,  1 ,  2014-05-29 12:26:49 ,  2014-11-09 15:09:37 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1043 ,  2 , null,  98876543 ,  543547 , null, null,  2 ,  2014-06-04 23:00:00 ,  2014-07-03 23:00:00 ,  2014-06-04 23:00:00 , null,  65000.0000 ,  the big blue box ,  3 ,  23 ,  9 ,  3 ,  1 ,  2014-06-04 13:31:30 ,  2014-11-09 13:18:17 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1044 ,  4 , null,  MAEU45678904 ,  55555 , null, null,  1 ,  2014-06-30 23:00:00 ,  2014-06-18 23:00:00 ,  2014-06-30 23:00:00 , null,  4100.0000 ,  This BOL is being delievered as a way bill ,  3 ,  PRN54354 ,  3 ,  12 ,  1 ,  2014-06-30 07:30:01 ,  2014-07-17 05:59:41 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1045 ,  4 , null,  111111 ,  mmmmm , null, null,  1 ,  2014-07-31 04:00:00 ,  2014-07-29 04:00:00 ,  2014-07-03 04:00:00 , null,  555.0000 ,  dfgjsfgjdfghsfgh\ndfghdfgjdfgjfgjdfgj\nsfgjdfgjdfgj ,  3 , null,  3 ,  6 ,  1 ,  2014-07-08 12:39:47 ,  2014-07-21 23:02:05 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1046 ,  1 , null,  44444 ,  44444 , null, null,  2 ,  2014-07-09 04:00:00 ,  2014-07-16 04:00:00 ,  2014-07-09 04:00:00 , null,  530.0000 ,  fghjhgsghs\nsghfsghsghshshsdfhsdh ,  3 , null,  3 ,  12 ,  1 ,  2014-07-08 12:42:38 ,  2014-09-22 17:14:30 ,  0 ,  25.0000 , null);
INSERT INTO   transactions  VALUES ( 1047 ,  4 , null,  67676767676 ,  34567892 , null, null,  1 ,  2014-07-10 04:00:00 ,  2014-07-23 04:00:00 ,  2014-07-10 04:00:00 , null,  5821.0000 ,  this is the description field that i am testing to see how it really works. i like the fact that the count down shows how many characters are left for you to write ,  3 , null,  3 ,  6 ,  1 ,  2014-07-08 21:39:38 ,  2014-09-22 17:51:26 ,  0 ,  5.0000 , null);
INSERT INTO   transactions  VALUES ( 1053 ,  4 , null,  234567890-7654 ,  3456 , null, null,  2 ,  2014-07-16 04:00:00 ,  2014-08-12 04:00:00 ,  2014-07-29 04:00:00 , null,  3200.0000 ,  hello and thank you for calling ,  3 ,  2345678 ,  10 ,  3 ,  1 ,  2014-07-29 09:53:20 ,  2014-11-09 23:14:04 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1056 ,  4 , null,  78678567 ,  876876 , null, null,  2 ,  2014-08-14 04:00:00 ,  2014-08-12 04:00:00 ,  2014-08-13 04:00:00 , null,  87687.0000 , null,  1 , null,  3 ,  9 ,  1 ,  2014-08-07 19:35:26 ,  2014-08-07 19:35:41 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1057 ,  1 , null,  696969 , null, null, null,  1 , null, null, null, null,  10.0000 , null,  1 , null,  3 ,  12 ,  1 ,  2014-08-07 23:39:17 ,  2014-08-07 23:39:17 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1058 ,  2 , null,  969696 ,  696969 , null, null,  2 , null, null, null, null,  6969.0000 , null,  1 , null,  3 ,  12 ,  1 ,  2014-08-07 20:41:36 ,  2014-08-07 20:41:36 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1059 ,  4 , null,  123321 , null, null, null,  1 , null, null, null, null,  1500.0000 , null,  1 , null,  3 ,  12 ,  1 ,  2014-08-07 20:42:29 ,  2014-08-07 20:43:18 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1060 ,  3 , null,  333 ,  44444 , null, null,  2 , null, null, null, null,  555.0000 ,  Adding something on the description field\n ,  4 ,  3333 ,  6 ,  3 ,  1 ,  2014-08-07 20:43:57 ,  2014-11-06 22:47:57 ,  0 ,  6.0000 , null);
INSERT INTO   transactions  VALUES ( 1061 ,  4 , null,  555 , null, null, null,  1 , null, null, null, null,  33.0000 , null,  3 , null,  3 ,  9 ,  1 ,  2014-08-11 19:09:18 ,  2014-09-18 20:27:30 ,  0 ,  22.0000 , null);
INSERT INTO   transactions  VALUES ( 1065 ,  4 , null,  634634-111 ,  34534-111 , null, null,  1 , null, null, null, null,  435351.0000 , null,  4 ,  34534-112 ,  6 ,  3 ,  1 ,  2014-08-11 19:26:54 ,  2014-11-06 22:47:57 ,  0 ,  6.0000 , null);
INSERT INTO   transactions  VALUES ( 1066 ,  1 , null,  696969 ,  696969 , null, null,  1 , null, null, null, null,  10.0000 , null,  1 , null,  3 ,  12 ,  1 ,  2014-08-12 09:20:08 ,  2014-08-12 09:20:08 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1067 ,  4 , null,  34291911 ,  RN4829442 , null, null,  1 ,  2014-07-28 04:00:00 ,  2014-09-05 04:00:00 ,  2014-08-19 04:00:00 , null,  4800.0000 ,  I want to use this because i thing it would be cool.  ,  4 ,  PRN32111 ,  3 ,  11 ,  1 ,  2014-08-18 11:38:35 ,  2014-09-08 22:29:30 ,  0 ,  2000.0000 , null);
INSERT INTO   transactions  VALUES ( 1068 ,  4 , null,  INV658728722 ,  76e3982 , null, null,  2 ,  2014-07-28 04:00:00 ,  2014-09-01 04:00:00 ,  2014-08-18 04:00:00 , null,  78000.0000 ,  testing this out\ \n ,  1 , null,  3 ,  6 ,  1 ,  2014-08-18 11:40:20 ,  2014-08-29 00:35:44 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1069 ,  4 , null,  696969 ,  435678 , null, null,  1 ,  2014-08-28 04:00:00 ,  2014-08-30 04:00:00 ,  2014-08-13 04:00:00 , null,  580.0000 , null,  3 , null,  3 ,  9 ,  1 ,  2014-08-26 18:03:16 ,  2014-08-26 23:28:32 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1070 ,  4 , null,  555-1 , null, null, null,  1 , null, null, null, null,  22.0000 , null,  1 , null,  3 ,  9 ,  1 ,  2014-09-18 20:27:31 ,  2014-09-18 20:27:31 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1071 ,  1 , null,  INV56789876 ,  MAEU567844 , null, null,  1 ,  2014-09-20 04:00:00 ,  2014-09-22 04:00:00 ,  2014-09-21 04:00:00 , null,  2000.0000 ,  This shipment is going from NY to London ,  4 ,  694733 ,  6 ,  3 ,  1 ,  2014-09-21 09:27:58 ,  2014-11-06 22:47:57 ,  0 ,  6.0000 , null);
INSERT INTO   transactions  VALUES ( 1072 ,  1 , null,  44444-1 ,  44444 , null, null,  2 , null, null, null, null,  25.0000 , null,  4 , null,  3 ,  12 ,  1 ,  2014-09-22 17:14:30 ,  2014-11-06 11:34:40 ,  0 ,  12.0000 , null);
INSERT INTO   transactions  VALUES ( 1073 ,  4 , null,  67676767676-1 ,  34567892 , null, null,  1 , null, null, null, null,  5.0000 , null,  4 , null,  3 ,  6 ,  1 ,  2014-09-22 17:51:27 ,  2014-11-11 22:00:52 ,  0 ,  3.0000 , null);
INSERT INTO   transactions  VALUES ( 1074 ,  1 , null,  MAEU5678987 , null, null, null,  1 ,  2014-09-18 04:00:00 ,  2014-10-01 04:00:00 ,  2014-09-29 04:00:00 , null,  8800.0000 ,  this shipment is going to columbia ,  4 , null,  3 ,  4 ,  1 ,  2014-09-27 12:02:24 ,  2014-11-06 11:37:13 ,  0 ,  800.0000 , null);
INSERT INTO   transactions  VALUES ( 1075 ,  1 , null,  3456765454 ,  Maeu748349 , null, null,  2 ,  2014-09-03 04:00:00 ,  2014-10-02 04:00:00 ,  2014-09-27 04:00:00 , null,  5656.0000 , null,  3 ,  REF734849 ,  9 ,  3 ,  1 ,  2014-09-27 12:08:34 ,  2014-11-09 13:18:18 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1076 ,  2 , null,  4567898765dd-1 ,  MAEU73874788899 , null, null,  2 , null, null, null, null,  66.0000 , null,  4 ,  r46tyu77865-1 ,  3 ,  6 ,  1 ,  2014-10-03 05:37:48 ,  2014-11-06 11:40:54 ,  0 ,  5.0000 , null);
INSERT INTO   transactions  VALUES ( 1077 ,  2 , null,  N0-00099789 ,  U-900909 , null, null,  1 ,  2014-10-19 04:00:00 ,  2014-10-12 04:00:00 ,  2014-10-20 04:00:00 , null,  35.0000 ,  TEST ,  3 , null,  3 ,  11 ,  9 ,  2014-10-21 23:32:58 ,  2014-10-21 23:33:23 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1078 ,  4 , null,  INV474893845 ,  2255444990 , null, null,  2 ,  2014-10-01 04:00:00 ,  2014-10-28 04:00:00 ,  2014-10-24 04:00:00 , null,  6900.0000 ,  This shipment is moving from China to Long Beach ,  4 , null,  3 ,  11 ,  9 ,  2014-10-22 18:04:59 ,  2014-11-05 22:20:36 ,  0 ,  25.0000 , null);
INSERT INTO   transactions  VALUES ( 1079 ,  1 , null,  MAEU73462384768 ,  47398364 , null, null,  1 ,  2014-10-01 04:00:00 ,  2014-10-31 04:00:00 ,  2014-10-24 04:00:00 , null,  10500.0000 ,  This shipment is an LCL that is leaving China to the Port of Long Beach and then by truck to NY. ,  3 , null,  3 ,  11 ,  9 ,  2014-10-23 05:34:00 ,  2014-10-23 11:26:49 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1080 ,  1 , null,  5643325785-1 ,  7755758 , null, null,  2 ,  2014-10-02 04:00:00 ,  2014-10-23 04:00:00 ,  2014-10-24 04:00:00 , null,  12500.0000 ,  We are moving 2 containers of TV\ s from China to Port of Long Beach when by truck to NY.  ,  3 ,  PRN736438 ,  3 ,  11 ,  9 ,  2014-10-23 05:45:18 ,  2014-10-23 11:26:49 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1081 ,  1 , null,  INV775590909 ,  73e6289090 , null, null,  2 ,  2014-10-09 04:00:00 ,  2014-10-30 04:00:00 ,  2014-10-24 04:00:00 , null,  43000.0000 ,  this is a shipment of tires\n ,  4 , null,  3 ,  11 ,  9 ,  2014-10-23 08:25:13 ,  2014-10-23 19:27:32 ,  0 ,  43000.0000 , null);
INSERT INTO   transactions  VALUES ( 1082 ,  1 , null,  MAEU711272 ,  INV93e843 , null, null,  1 ,  2014-10-02 04:00:00 ,  2014-11-06 05:00:00 ,  2014-10-24 04:00:00 , null,  33000.0000 ,  Shipping 10 containers from China to TX ,  3 ,  PRN83483 ,  3 ,  11 ,  9 ,  2014-10-23 09:33:04 ,  2014-11-05 22:13:39 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1083 ,  1 , null,  CMA746385 , null, null, null,  1 ,  2014-10-09 04:00:00 ,  2014-10-27 04:00:00 ,  2014-10-26 04:00:00 , null,  51000.0000 ,  I want to test to see how much i can write in this section, i may want to write a book about how long it has taken to build PAB. Yanier has grown his hair and will not cut his hair until we finish the system . I really hope we finish soon because his hair is almost touching the floor. People are starting to think he is a woman. LOL. Yanier if you are reading this, this is only a joke, like funny.  ,  3 ,  PRN874r73 ,  3 ,  11 ,  9 ,  2014-10-23 10:29:59 ,  2014-10-23 11:23:52 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1084 ,  1 , null,  MAEU74638569 ,  INV636748 , null, null,  1 ,  2014-10-10 04:00:00 ,  2014-10-30 04:00:00 ,  2014-10-26 04:00:00 , null,  33000.0000 ,  this shipment is coming from China to Long Beach ,  3 ,  PRN74738i ,  3 ,  11 ,  9 ,  2014-10-24 08:25:02 ,  2014-11-05 22:13:40 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1085 ,  1 , null,  MAEU73629847 ,  MAEU888112239 , null, null,  2 ,  2014-10-30 04:00:00 ,  2014-11-27 05:00:00 ,  2014-11-13 05:00:00 , null,  13878.0000 ,  Shipment is moving from China to Long Beach ,  4 ,  PRN87376398 ,  3 ,  11 ,  1 ,  2014-11-06 08:28:33 ,  2014-11-06 11:35:40 ,  0 ,  333.0000 , null);
INSERT INTO   transactions  VALUES ( 1090 ,  1 , null,  100-1 ,  100-1 , null, null,  1 ,  2014-11-10 05:00:00 ,  2014-11-10 05:00:00 ,  2014-11-10 05:00:00 , null,  160.0000 , null,  4 ,  1000Disney ,  11 ,  3 ,  1 ,  2014-11-09 13:29:55 ,  2014-11-10 16:52:50 ,  0 ,  5.0000 , null);
INSERT INTO   transactions  VALUES ( 1091 ,  1 , null,  200-2 ,  200-2 , null, null,  2 ,  2014-11-18 05:00:00 ,  2014-11-18 05:00:00 ,  2014-11-27 05:00:00 , null,  100.0000 , null,  3 , null,  3 ,  11 ,  1 ,  2014-11-09 13:31:24 ,  2014-11-09 13:32:21 ,  0 ,  100.0000 , null);
INSERT INTO   transactions  VALUES ( 1092 ,  1 , null,  200-2-1 ,  200-2 , null, null,  2 , null, null, null, null,  100.0000 , null,  3 , null,  3 ,  11 ,  9 ,  2014-11-09 13:32:21 ,  2014-11-09 13:34:05 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1093 ,  1 , null,  INV6473859 ,  MAEU465846 , null, null,  2 ,  2014-11-10 05:00:00 ,  2014-11-24 05:00:00 ,  2014-11-10 05:00:00 , null,  78200.0000 ,  This is a shipment tof 30 containers that is moving from China to Long Beach  ,  2 ,  PRN746395 ,  3 ,  11 ,  9 ,  2014-11-09 14:25:05 ,  2014-11-09 14:35:26 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1094 ,  1 , null,  DIS84749468 ,  MAEU748659279 , null, null,  2 ,  2014-11-02 04:00:00 ,  2014-11-23 05:00:00 ,  2014-11-09 05:00:00 , null,  0.0000 ,  shipment from NY to Brasil ,  3 , null,  3 ,  11 ,  1 ,  2014-11-09 16:35:27 ,  2014-11-09 17:25:51 ,  0 ,  28500.0000 , null);
INSERT INTO   transactions  VALUES ( 1095 ,  1 , null,  DIS84749468-1 ,  MAEU748659279 , null, null,  2 , null, null, null, null,  28500.0000 , null,  3 , null,  3 ,  11 ,  9 ,  2014-11-09 17:25:51 ,  2014-11-09 17:51:50 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1096 ,  1 , null,  INV8119900 ,  MAEU8473955 , null, null,  2 ,  2014-11-02 04:00:00 ,  2014-11-23 05:00:00 ,  2014-11-10 05:00:00 , null,  30000.0000 ,  shipment from China to Long Beach 10 containers ,  3 ,  PRN98373 ,  3 ,  11 ,  1 ,  2014-11-09 17:31:50 ,  2014-11-10 11:58:37 ,  0 ,  3000.0000 , null);
INSERT INTO   transactions  VALUES ( 1097 ,  4 , null,  INV150 ,  INV150 , null, null,  2 ,  2014-11-10 05:00:00 ,  2014-11-11 05:00:00 ,  2014-11-29 05:00:00 , null,  150.0000 , null,  4 ,  PRN3782092-2 ,  3 ,  11 ,  1 ,  2014-11-10 00:30:36 ,  2014-11-10 16:32:43 ,  0 ,  50.0000 , null);
INSERT INTO   transactions  VALUES ( 1098 ,  4 , null,  INV400-1 ,  INV400-1 , null, null,  2 ,  2014-11-09 05:00:00 ,  2014-11-11 05:00:00 ,  2014-11-12 05:00:00 , null,  400.0000 , null,  2 ,  444 ,  3 ,  11 ,  9 ,  2014-11-10 01:34:54 ,  2014-11-10 01:44:42 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1099 ,  1 , null,  INV90919293 ,  MAEU98474820 , null, null,  2 ,  2014-11-05 05:00:00 ,  2014-11-25 05:00:00 ,  2014-11-13 05:00:00 , null,  22500.0000 ,  This is 8 container going from Shanghai to Long Beach CA ,  2 ,  jkoawef ,  3 ,  11 ,  9 ,  2014-11-10 08:15:10 ,  2014-11-10 11:05:48 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1100 ,  1 , null,  INV84873294 ,  MAEU4726495783 , null, null,  2 ,  2014-11-03 05:00:00 ,  2014-11-24 05:00:00 ,  2014-11-13 05:00:00 , null,  12800.0000 ,  This is 4 container moving from Hong Kong to Port of LA ,  2 , null,  3 ,  11 ,  9 ,  2014-11-10 08:27:08 ,  2014-11-11 08:04:15 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1101 ,  1 , null,  inv9837839 ,  MAEU836485 , null, null,  2 ,  2014-11-03 05:00:00 ,  2014-11-26 05:00:00 ,  2014-11-13 05:00:00 , null,  83500.0000 ,  this is 15 containers from china to TX ,  3 ,  PRN739824 ,  3 ,  11 ,  9 ,  2014-11-10 10:05:23 ,  2014-11-18 07:40:41 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1102 ,  1 , null,  INV8119900-1 ,  MAEU8473955 , null, null,  2 , null, null, null, null,  3000.0000 , null,  4 ,  111 ,  3 ,  11 ,  9 ,  2014-11-10 11:58:38 ,  2014-11-10 19:31:34 ,  0 ,  150.0000 , null);
INSERT INTO   transactions  VALUES ( 1103 ,  4 , null,  2532 ,  25325 , null, null,  2 ,  2014-11-11 05:00:00 ,  2014-11-11 05:00:00 ,  2014-11-11 05:00:00 , null,  550.0000 ,  test new template Email ,  3 ,  213 ,  11 ,  3 ,  1 ,  2014-11-10 15:36:39 ,  2014-11-24 22:25:14 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1104 ,  1 , null,  INV837298 ,  MAEU83763984 , null, null,  2 ,  2014-11-05 05:00:00 ,  2014-11-26 05:00:00 ,  2014-11-13 05:00:00 , null,  17500.0000 ,  This shipment is 7 containers going from Shenzhen to Long Beach ,  3 , null,  3 ,  11 ,  9 ,  2014-11-11 06:44:51 ,  2014-11-11 07:20:29 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1105 ,  1 , null,  INV48736328 ,  MAEU937394553 , null, null,  2 ,  2014-11-05 05:00:00 ,  2014-11-26 05:00:00 ,  2014-11-16 05:00:00 , null,  12500.0000 ,  This shipment consist of 4 container moving from China to Long Beach ,  2 ,  4tt5 ,  3 ,  11 ,  9 ,  2014-11-11 07:41:38 ,  2014-11-11 11:11:50 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1108 ,  4 , null,  333T ,  333T , null, null,  1 ,  2014-11-12 05:00:00 ,  2014-11-15 05:00:00 ,  2014-11-26 05:00:00 , null,  333.0000 , null,  4 ,  PR333 ,  3 ,  11 ,  1 ,  2014-11-13 18:34:15 ,  2014-11-24 22:58:02 ,  0 ,  33.0000 , null);
INSERT INTO   transactions  VALUES ( 1109 ,  4 , null,  5555 ,  5555 , null, null,  1 ,  2014-11-13 05:00:00 ,  2014-11-13 05:00:00 ,  2014-11-26 05:00:00 , null,  555.0000 ,  fghdfg ,  2 ,  rrr ,  3 ,  11 ,  9 ,  2014-11-13 20:48:30 ,  2014-11-24 23:02:46 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1110 ,  1 , null,  INV87346585 ,  MAEU73647 , null, null,  2 ,  2014-11-04 05:00:00 ,  2014-11-27 05:00:00 ,  2014-11-06 05:00:00 , null,  16000.0000 ,  This is 4 container moving from Asia to Long Beach ,  3 ,  PRN8347634-4 ,  3 ,  11 ,  1 ,  2014-11-13 18:56:25 ,  2014-11-14 10:22:38 ,  0 ,  600.0000 , null);
INSERT INTO   transactions  VALUES ( 1111 ,  1 , null,  INV87346585-1 ,  MAEU73647 , null, null,  2 , null, null, null, null,  600.0000 , null,  4 ,  PRN8347634-4 ,  3 ,  11 ,  9 ,  2014-11-14 10:22:38 ,  2014-11-14 11:05:53 ,  0 ,  300.0000 , null);
INSERT INTO   transactions  VALUES ( 1112 ,  1 , null,  INV983873 ,  MAEU7e3537 , null, null,  2 ,  2014-11-06 05:00:00 ,  2014-12-03 05:00:00 ,  2014-11-21 05:00:00 , null,  100.0000 ,  Moving Cargo ,  4 ,  PRN837639 ,  3 ,  11 ,  9 ,  2014-11-14 10:28:11 ,  2014-11-24 07:47:29 ,  0 ,  500.0000 , null);
INSERT INTO   transactions  VALUES ( 1113 ,  1 , null,  INV8384993 ,  MAEU83638745 , null, null,  2 ,  2015-01-01 05:00:00 ,  2015-01-15 05:00:00 ,  2015-01-08 05:00:00 , null,  7800.0000 ,  I am testing this information out right now.\n ,  2 ,  PRN983873409 ,  3 ,  11 ,  9 ,  2015-01-08 11:37:18 ,  2015-02-17 08:27:15 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1114 ,  2 , null,  222 ,  123456 , null, null,  2 ,  2015-03-14 04:00:00 ,  2015-04-09 04:00:00 ,  2015-03-13 04:00:00 , null,  10.0000 , null,  1 , null,  11 ,  5 ,  9 ,  2015-02-17 08:14:43 ,  2015-02-18 12:57:59 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1115 ,  1 , null,  123454321 ,  1234567 , null, null,  2 ,  2015-03-05 05:00:00 ,  2015-03-16 04:00:00 ,  2015-03-05 05:00:00 , null,  10.0000 , null,  3 ,  123212321 ,  3 ,  11 ,  9 ,  2015-02-18 17:43:04 ,  2015-02-25 10:38:07 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1116 ,  5 , null,  122 ,  1345 , null, null,  2 , null, null, null, null,  10.0000 , null,  1 ,  4321 ,  7 ,  3 ,  1 ,  2015-02-19 11:16:58 ,  2015-02-19 11:16:58 ,  0 , null, null);
INSERT INTO   transactions  VALUES ( 1117 ,  1 , null,  INV12345 ,  213243 , null, null,  2 ,  2015-02-26 05:00:00 ,  2015-03-01 05:00:00 ,  2015-03-05 05:00:00 , null,  10.0000 , null,  1 , null,  11 ,  3 ,  9 ,  2015-02-26 06:23:17 ,  2015-02-26 06:23:17 ,  0 , null, null);

-- ----------------------------
-- Table structure for transactionsattachment
-- ----------------------------
DROP TABLE IF EXISTS   transactionsattachments  ;
CREATE TABLE   transactionsattachments   (
  id int(11) NOT NULL,
    transactions_id int(11) NOT NULL,
    users_id int(11) NOT NULL,
    FilePath   text,
    description   varchar(100) DEFAULT NULL,
    AttachmentType   int(11) DEFAULT NULL,
    ViewableByOtherParty   tinyint(4) DEFAULT NULL,
    createdOn   datetime DEFAULT NULL,
    modifiedOn   datetime DEFAULT NULL,
    active   tinyint(4) NOT NULL,
    Filename   text,
    FileExtension   varchar(50) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY   transactions_id(  transactions_id   ),
  KEY   users_id(  users_id   ),
  CONSTRAINT   transactionsattachment_ibfk_1   FOREIGN KEY (  transactions_id   ) REFERENCES   transactions   (id),
  CONSTRAINT   transactionsattachment_ibfk_2   FOREIGN KEY (  users_id   ) REFERENCES   users   (id)
) ;

-- ----------------------------
-- Records of transactionsattachment
-- ----------------------------
INSERT INTO   transactionsattachments   VALUES ( 84 ,  1034 ,  1 ,  Test Document.txt ,  test1 ,  2 ,  1 ,  2014-06-17 20:09:14 ,  2014-07-09 20:44:36 ,  1 ,  BodyPart_f5e10d1c-ef47-4004-ac8a-59e0d59d7982 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 85 ,  1028 ,  1 ,  Test Document.txt ,  test2 ,  2 ,  1 ,  2014-06-17 20:10:18 ,  2014-07-05 22:42:56 ,  1 ,  BodyPart_86ca7b9f-2069-4552-8974-38af9cff5afd ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 86 ,  809 ,  1 ,  IMG_5002.JPG ,  bol ,  1 ,  0 ,  2014-06-18 13:42:01 ,  2014-07-01 19:28:46 ,  1 ,  BodyPart_7f33b5df-63dd-4a13-9456-1f65128d1107 ,  .JPG );
INSERT INTO   transactionsattachments   VALUES ( 87 ,  1030 ,  1 ,  IMG_5010.JPG ,  ertfg ,  1 ,  0 ,  2014-06-18 13:44:04 ,  2014-07-15 18:34:28 ,  1 ,  BodyPart_56f8108e-18cc-44fa-aa7e-16a46431eceb ,  .JPG );
INSERT INTO   transactionsattachments   VALUES ( 88 ,  1043 ,  1 ,  LapeyreStyle_businesscard_hand.png ,  tett ,  2 ,  0 ,  2014-06-26 22:25:51 ,  2014-07-08 15:19:38 ,  1 ,  BodyPart_ef41fb7d-98a5-43eb-8e0c-acd1a2fb8bb8 ,  .png );
INSERT INTO   transactionsattachments   VALUES ( 89 ,  809 ,  1 ,  Advance Search Error.jpg ,   ,  1 ,  1 ,  2014-06-30 07:18:42 ,  2014-06-30 07:18:49 ,  1 ,  BodyPart_86ca5d97-4109-43ab-9145-3289a870f1ba ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 90 ,  809 ,  1 ,  Advance Search Error.jpg ,  BOL ,  1 ,  1 ,  2014-06-30 07:18:42 ,  2014-06-30 07:18:51 ,  1 ,  BodyPart_09db08f3-1894-4582-80a7-8d8dd5f6c739 ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 91 ,  1044 ,  1 ,  PayAnyBiz Brief Summary June 2014.docx ,  BOL45678 ,  1 ,  1 ,  2014-06-30 17:41:27 ,  2014-07-06 21:50:03 ,  1 ,  BodyPart_1d686fd8-9bca-4955-9b9c-380b3891c39f ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 92 ,  1031 ,  1 ,  PayAnyBiz Executive Summary June.pdf ,  inv ,  1 ,  1 ,  2014-06-30 17:46:19 ,  2014-07-05 22:21:41 ,  1 ,  BodyPart_938c0d44-6f39-4683-a2b0-4ac0225f3f62 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 93 ,  1029 ,  1 ,  Dispute transactions Details Edits.docx ,  BOL ,  1 , null,  2014-07-01 19:37:45 ,  2014-07-01 19:37:45 ,  1 ,  BodyPart_782da101-d3b8-44aa-bdb0-c88aea2e321a ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 94 ,  734 ,  1 ,  PayAnyBiz Brief Summary June 2014.docx ,  BOL456789 ,  1 , null,  2014-07-02 07:23:52 ,  2014-07-02 07:23:52 ,  1 ,  BodyPart_1568dc18-a9d4-46c8-acb3-3df2f475c00b ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 96 ,  1042 ,  1 ,  NACHA File Layout (Excel document).xls ,  proof of delievery ,  1 , null,  2014-07-03 07:27:31 ,  2014-07-03 07:27:31 ,  1 ,  BodyPart_7c2008ed-0f40-4e4d-b88f-d7140f40e6eb ,  .xls );
INSERT INTO   transactionsattachments   VALUES ( 97 ,  1033 ,  1 ,  PayAnyBiz Executive Summary June.pdf ,  inv5678 ,  2 , null,  2014-07-03 07:45:13 ,  2014-07-03 07:45:13 ,  1 ,  BodyPart_bbfb0439-740c-424f-a8c6-7fa6e673d83b ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 100 ,  1046 ,  1 ,  Business-Neg-Cios-Dr-S-A-548917.jpg ,   ,  2 , null,  2014-07-08 15:58:33 ,  2014-07-08 15:58:33 ,  1 ,  BodyPart_64950dac-3a08-4fe2-9081-1011a16cd0f5 ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 101 ,  1046 ,  1 ,  Business-Neg-Cios-Dr-S-A-548917.jpg ,  ddddd ,  2 , null,  2014-07-08 18:16:02 ,  2014-07-08 18:16:02 ,  1 ,  BodyPart_f858fe88-f42d-4e31-b590-48813d035b50 ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 102 ,  1046 ,  1 ,  Test Document (1).txt ,  Test123 ,  2 , null,  2014-08-07 23:40:17 ,  2014-08-07 23:40:17 ,  1 ,  BodyPart_13dfbf8e-7d47-441d-94cd-b12b7d7dbe32 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 106 ,  1056 ,  1 ,  Business-Neg-Cios-Dr-S-A-548917.jpg ,  vcbcvbcvb ,  3 ,  1 ,  2014-08-08 00:52:43 ,  2014-08-08 00:52:50 ,  1 ,  BodyPart_97aaac66-8c88-4631-acc1-59b055698e04 ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 107 ,  1057 ,  1 ,  glyphicons-halflings-regular.eot ,  test08082014 ,  1 ,  0 ,  2014-08-08 01:20:00 ,  2014-08-07 22:21:25 ,  1 ,  BodyPart_dc747ba8-40e8-4bd2-83a1-23702e3dc3a8 ,  .eot );
INSERT INTO   transactionsattachments   VALUES ( 108 ,  1057 ,  1 ,  glyphicons-halflings-regular.woff ,  2222 ,  1 ,  1 ,  2014-08-08 01:22:15 ,  2014-08-08 01:22:23 ,  1 ,  BodyPart_8b3010dc-9e3b-45b6-939c-e7d85ac94505 ,  .woff );
INSERT INTO   transactionsattachments   VALUES ( 109 ,  1058 ,  1 ,  Issue Found in PayAnyBiz.docx ,  inv789 ,  2 , null,  2014-08-09 20:24:41 ,  2014-08-09 20:24:41 ,  1 ,  BodyPart_0965dd7e-41e5-4d2b-84e5-68e548563dad ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 110 ,  1058 ,  1 ,  NACHA File Layout (Excel document).xls ,  MAEU5784358 ,  1 , null,  2014-08-09 20:36:57 ,  2014-08-09 20:36:57 ,  1 ,  BodyPart_77eb21ef-b154-4efe-b268-35deeacf10ad ,  .xls );
INSERT INTO   transactionsattachments   VALUES ( 111 ,  1026 ,  1 ,  image.jpg ,  Inv5645444 ,  2 , null,  2014-08-10 20:04:10 ,  2014-08-10 20:04:10 ,  1 ,  BodyPart_090e0f35-6525-463e-8a33-a2817f62062e ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 112 ,  297 ,  1 ,  Test Document.txt ,  ttttt08-11-2014 ,  1 , null,  2014-08-10 21:47:29 ,  2014-08-10 21:47:29 ,  1 ,  BodyPart_63f87119-c55b-4374-9767-595bfda3f701 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 113 ,  300 ,  1 ,  COLT-GMS Mutual NDA NCA generic.doc ,  BOL65833112 ,  1 , null,  2014-08-11 08:39:15 ,  2014-08-11 08:39:15 ,  1 ,  BodyPart_e124675c-6b65-4cfb-911d-ed6e94f79b7a ,  .doc );
INSERT INTO   transactionsattachments   VALUES ( 114 ,  1060 ,  1 ,  PayAnyBiz Executive Summary August.docx ,  INV737382 ,  2 , null,  2014-08-11 08:44:43 ,  2014-08-11 08:44:43 ,  1 ,  BodyPart_81c1df8c-dfe6-422c-889c-5fc33f0ce3f8 ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 115 ,  1060 ,  1 ,  NACHA File Layout (Excel document).xls ,  POD7382092 ,  2 , null,  2014-08-11 08:46:10 ,  2014-08-11 08:46:10 ,  1 ,  BodyPart_3bec7071-4414-4f0d-a7b1-16774677d3bf ,  .xls );
INSERT INTO   transactionsattachments   VALUES ( 116 ,  1047 ,  1 ,  PayAnyBiz Executive Summary August.docx ,  BOL ,  1 , null,  2014-08-11 09:19:33 ,  2014-08-11 09:19:33 ,  1 ,  BodyPart_d36de7ba-3fc0-4bb4-9616-aeb2a4435a29 ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 117 ,  726 ,  1 ,  logo info.docx ,   ,  1 , null,  2014-08-12 06:12:00 ,  2014-08-12 06:12:00 ,  1 ,  BodyPart_43e00756-2464-4b12-b48b-5ece551df8e5 ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 118 ,  726 ,  1 ,  Commercial Property Loan Application.xls ,  Proof of delievery ,  4 , null,  2014-08-12 06:13:13 ,  2014-08-12 06:13:13 ,  1 ,  BodyPart_9adfcb1c-c963-4093-8ae2-94bce164f09c ,  .xls );
INSERT INTO   transactionsattachments   VALUES ( 119 ,  726 ,  1 ,  Commercial Property Loan Application.xls ,  This is an invoice for this transactionsF4Q ,  2 , null,  2014-08-12 06:14:16 ,  2014-08-12 06:14:16 ,  1 ,  BodyPart_d21bd1a1-f042-4298-b639-00bee909b7d3 ,  .xls );
INSERT INTO   transactionsattachments   VALUES ( 120 ,  726 ,  1 ,  Copy of PayAnyBiz 4 year financial model-Final.xlsx ,  Proof for waiting time doc ,  1 , null,  2014-08-12 06:16:50 ,  2014-08-12 06:16:50 ,  1 ,  BodyPart_15b0b9b4-a885-45e4-8700-9a67a774daa3 ,  .xlsx );
INSERT INTO   transactionsattachments   VALUES ( 125 ,  648 ,  1 ,  Copy of PayAnyBiz 4 year financial model April.xlsx ,  bol ,  1 , null,  2014-08-18 11:28:09 ,  2014-08-18 11:28:09 ,  1 ,  BodyPart_a57b6d91-3e30-428e-8752-be9409441dbb ,  .xlsx );
INSERT INTO   transactionsattachments   VALUES ( 126 ,  1053 ,  1 ,  A-1 SITE PLAN.pdf ,  INV56789 ,  2 ,  0 ,  2014-08-26 05:16:02 ,  2014-08-26 05:17:34 ,  1 ,  BodyPart_3a09fa5d-7849-4763-b0f9-9d6ce8377f14 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 127 ,  1065 ,  1 ,  A-1 SITE PLAN.pdf ,  BOL4567890 ,  1 ,  1 ,  2014-08-26 09:31:54 ,  2014-08-26 09:37:10 ,  1 ,  BodyPart_3c9f25d1-c3b7-4820-a04a-2778d93c1d58 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 128 ,  1065 ,  1 ,  A-2 LANDSCAPE PLAN.pdf ,  POD ,  1 , null,  2014-08-26 09:39:30 ,  2014-08-26 09:39:30 ,  1 ,  BodyPart_0719f9f9-53f5-4ebe-97c4-840f9db2d26b ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 129 ,  1059 ,  1 ,  A-1 SITE PLAN.pdf ,   ,  2 ,  0 ,  2014-08-26 16:19:33 ,  2014-08-26 16:20:02 ,  1 ,  BodyPart_c9350fd1-541b-4f36-855d-da4f4f020242 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 130 ,  1067 ,  1 ,  A-3 FLOOR PLAN.pdf ,  bol456789 ,  1 , null,  2014-08-26 16:25:07 ,  2014-08-26 16:25:07 ,  1 ,  BodyPart_bcba022a-caa7-41f3-87f9-7c11b9e93ffb ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 131 ,  1009 ,  1 ,  A-5 ELEVATIONS.pdf ,  hgjk ,  1 , null,  2014-08-26 17:14:56 ,  2014-08-26 17:14:56 ,  1 ,  BodyPart_3518ad28-d840-44db-a78b-7c65698ce54c ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 132 ,  589 ,  1 ,  Test Document.txt ,  Test ,  1 , null,  2014-08-26 20:44:04 ,  2014-08-26 20:44:04 ,  1 ,  BodyPart_add74f06-9c33-4892-a14d-8ddbd1f65941 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 134 ,  1047 ,  1 ,  board.json ,   ,  1 , null,  2014-09-08 22:39:10 ,  2014-09-08 22:39:10 ,  1 ,  BodyPart_a5ccf896-b769-4465-bd0b-d0e398249ed8 ,  .json );
INSERT INTO   transactionsattachments   VALUES ( 135 ,  412 ,  1 ,  Picture 054.jpg ,  BOL56789 ,  1 , null,  2014-09-15 06:14:49 ,  2014-09-15 06:14:49 ,  1 ,  BodyPart_5377aa2e-07f4-4147-8cc9-2fe8399924d1 ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 136 ,  450 ,  1 ,  Picture 054.jpg ,   ,  1 , null,  2014-09-15 07:41:41 ,  2014-09-15 07:41:41 ,  1 ,  BodyPart_adc4d2a9-a6f2-4d67-a385-e5b993b2c8d0 ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 137 ,  1069 ,  1 ,  Test Document (1).txt ,  5555 ,  1 , null,  2014-09-18 22:26:52 ,  2014-09-18 22:26:52 ,  1 ,  BodyPart_83adf786-aa16-4592-9f97-d053ff7ab9f2 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 138 ,  1071 ,  1 ,  K_id  Chore Sheet.pdf ,  BOL6743 ,  1 , null,  2014-09-21 09:29:56 ,  2014-09-21 09:29:56 ,  1 ,  BodyPart_326c2e52-79da-4ff4-8ff2-ce8592f8e1ba ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 139 ,  1027 ,  1 ,  Picture 054.jpg ,  BOL57367222 ,  1 , null,  2014-10-03 05:36:41 ,  2014-10-03 05:36:41 ,  1 ,  BodyPart_56008f91-5ebc-41c9-bf9d-367ada1295ad ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 146 ,  1075 ,  1 ,  Test Document.txt ,  Test Attchment1 ,  2 , null,  2014-10-22 23:52:17 ,  2014-10-22 23:52:17 ,  1 ,  BodyPart_15235695-a585-4297-846c-7543acfc4e82 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 147 ,  1080 ,  1 ,  Picture 065.jpg ,  INVreu7e8 ,  2 ,  1 ,  2014-10-23 06:44:44 ,  2014-10-23 06:47:14 ,  1 ,  BodyPart_e36ae1fd-5265-4458-80bb-85bf44c5bb33 ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 148 ,  1080 ,  1 ,  Jim Blaeser.docx ,  POD ,  4 ,  1 ,  2014-10-23 06:45:32 ,  2014-10-23 06:47:16 ,  1 ,  BodyPart_86768ce4-7bdf-498e-a217-1dfd2b1e4cfd ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 149 ,  1080 ,  9 ,  LOGO.JPG ,  BOL ,  2 , null,  2014-10-23 07:13:17 ,  2014-10-23 07:13:17 ,  1 ,  BodyPart_735816b8-b582-4987-89c4-f18c32360d09 ,  .JPG );
INSERT INTO   transactionsattachments   VALUES ( 150 ,  1080 ,  1 ,  Picture 066.jpg ,  Pic of Shipment ,  4 , null,  2014-10-23 07:47:03 ,  2014-10-23 07:47:03 ,  1 ,  BodyPart_545be2b9-19be-4ed2-8777-ef916a3767a6 ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 151 ,  1080 ,  1 ,  PayAnyBiz-Website 091614-C.doc ,  COD ,  4 , null,  2014-10-23 08:09:06 ,  2014-10-23 08:09:06 ,  1 ,  BodyPart_93d244c0-e641-44d3-8d0a-3060a66fee26 ,  .doc );
INSERT INTO   transactionsattachments   VALUES ( 152 ,  1080 ,  1 ,  Picture 067.jpg ,  picture of shipment ,  4 , null,  2014-10-23 08:14:20 ,  2014-10-23 08:14:20 ,  1 ,  BodyPart_015084c2-e8bd-49af-98b9-02703259e74c ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 153 ,  1079 ,  1 ,  Picture 057.jpg ,  BOL7464768 ,  1 , null,  2014-10-23 08:19:18 ,  2014-10-23 08:19:18 ,  1 ,  BodyPart_c3fbadda-57e1-43b9-a35e-40cb2e46f53b ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 154 ,  1081 ,  1 ,  Summary of WV Deal.docx ,  INV775590909 ,  2 , null,  2014-10-23 08:27:40 ,  2014-10-23 08:27:40 ,  1 ,  BodyPart_1896a595-10bd-4ace-b680-40810295a32f ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 155 ,  1081 ,  9 ,  Reyes-back yard 2014 picture.jpg ,  POD84373 ,  4 , null,  2014-10-23 08:45:14 ,  2014-10-23 08:45:14 ,  1 ,  BodyPart_fb3aa6ea-ef36-4138-b3cc-894574167883 ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 156 ,  1078 ,  9 ,  Summary of WV Deal.docx ,  BOL76238343 ,  1 , null,  2014-10-23 09:18:34 ,  2014-10-23 09:18:34 ,  1 ,  BodyPart_92e49710-8a87-4af6-9c07-56cb94f389ec ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 157 ,  1082 ,  9 ,  Maersk310MIG.pdf ,  BOL ,  1 , null,  2014-10-23 09:34:15 ,  2014-10-23 09:34:15 ,  1 ,  BodyPart_d9469594-d105-4019-a12b-3dcc391df583 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 158 ,  1083 ,  9 ,  Bill_Of_Lading.pdf ,  BOL83838 ,  1 , null,  2014-10-23 10:34:45 ,  2014-10-23 10:34:45 ,  1 ,  BodyPart_d160ffe6-933b-4ac1-b7af-1d17e3fee3c4 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 159 ,  1083 ,  9 ,  Bill_Of_Lading.pdf ,  INV8383 ,  2 , null,  2014-10-23 11:12:23 ,  2014-10-23 11:12:23 ,  1 ,  BodyPart_4dca5b8c-d4e1-428d-b2ee-71ec4b2930ee ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 160 ,  1071 ,  1 ,  number 6.jpg ,  teestt ,  1 , null,  2014-10-24 00:10:56 ,  2014-10-24 00:10:56 ,  1 ,  BodyPart_b4d8e37f-64c5-47ff-88d6-6d31e85da8ac ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 161 ,  1071 ,  1 ,  number456.jpg ,  testt2 ,  1 , null,  2014-10-24 00:12:38 ,  2014-10-24 00:12:38 ,  1 ,  BodyPart_35d6d456-ec6a-42a9-9580-dfa9f04af963 ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 162 ,  1084 ,  9 ,  LOGO.JPG ,   ,  1 , null,  2014-10-24 08:25:49 ,  2014-10-24 08:25:49 ,  1 ,  BodyPart_bcb48217-e4c7-452c-a418-ed5b2538ee0a ,  .JPG );
INSERT INTO   transactionsattachments   VALUES ( 163 ,  1085 ,  9 ,  Bill_Of_Lading.pdf ,   ,  2 ,  1 ,  2014-11-06 08:29:00 ,  2014-11-06 08:30:34 ,  1 ,  BodyPart_818ddb04-a257-40c3-b4df-ccaeefd5a2dc ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 164 ,  1085 ,  9 ,  Copy of PayAnyBiz 4 year financial model-1st Yr per month-5M- 102014A.xlsx ,   ,  2 , null,  2014-11-06 08:42:32 ,  2014-11-06 08:42:32 ,  1 ,  BodyPart_b8faf9f1-7091-4e72-8420-c58d2203a84f ,  .xlsx );
INSERT INTO   transactionsattachments   VALUES ( 166 ,  1093 ,  9 ,  CODE OF ACADEMIC INTEGRITY.docx ,   ,  1 , null,  2014-11-09 14:28:12 ,  2014-11-09 14:28:12 ,  1 ,  BodyPart_11750045-fbc4-4e30-8be3-b1fa9478eaf5 ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 167 ,  1094 ,  1 ,  Bill_Of_Lading.pdf ,   ,  2 , null,  2014-11-09 16:37:24 ,  2014-11-09 16:37:24 ,  1 ,  BodyPart_27237867-01bb-4677-bd96-b8d53061e9cb ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 168 ,  1094 ,  1 ,  Carrier Questionaire.doc ,   ,  1 , null,  2014-11-09 16:37:49 ,  2014-11-09 16:37:49 ,  1 ,  BodyPart_534b5e97-e897-4666-a910-c08db5e41116 ,  .doc );
INSERT INTO   transactionsattachments   VALUES ( 169 ,  1096 ,  1 ,  Bill_Of_Lading.pdf ,  BOL MAEU8473955 ,  1 , null,  2014-11-09 17:32:27 ,  2014-11-09 17:32:27 ,  1 ,  BodyPart_320100c6-9749-4233-922c-bd04f8297d8e ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 170 ,  617 ,  9 ,  Bill_Of_Lading.pdf ,  BOL 4643256 ,  1 , null,  2014-11-09 21:03:55 ,  2014-11-09 21:03:55 ,  1 ,  BodyPart_dbcb640c-ca65-432e-a627-9f2838fb2c17 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 171 ,  617 ,  9 ,  Error or Enhancement Found10232014.docx ,   ,  1 , null,  2014-11-09 21:10:41 ,  2014-11-09 21:10:41 ,  1 ,  BodyPart_055576b2-ec01-4f17-a621-2b984d027869 ,  .docx );
INSERT INTO   transactionsattachments   VALUES ( 172 ,  1096 ,  9 ,  Copy of ACH Report.xlsx ,   ,  2 , null,  2014-11-09 21:13:14 ,  2014-11-09 21:13:14 ,  1 ,  BodyPart_3416dddb-82c5-421f-8a9e-34adffde486f ,  .xlsx );
INSERT INTO   transactionsattachments   VALUES ( 173 ,  1090 ,  1 ,  Test Document.txt ,  test YCR 1 ,  1 , null,  2014-11-09 23:23:08 ,  2014-11-09 23:23:08 ,  1 ,  BodyPart_dd8de9a4-1bdb-47ae-97bb-39b8ec4b0ef7 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 174 ,  1090 ,  1 ,  Test Document.txt ,  test YCR 2 ,  1 , null,  2014-11-09 23:27:54 ,  2014-11-09 23:27:54 ,  1 ,  BodyPart_d427484e-bb80-4fb3-b189-8f490b842eb1 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 175 ,  1090 ,  1 ,  Test Document.txt ,  test YCR 3 ,  1 , null,  2014-11-09 23:28:38 ,  2014-11-09 23:28:38 ,  1 ,  BodyPart_4df9af00-a23c-4888-ab11-779504576cd7 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 176 ,  1090 ,  1 ,  Test Document (1).txt ,  test YCR 4 ,  1 , null,  2014-11-09 23:33:09 ,  2014-11-09 23:33:09 ,  1 ,  BodyPart_a3c2d243-0ed5-45f9-89a7-a7de282dcc95 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 177 ,  1099 ,  1 ,  Bill_Of_Lading.pdf ,  INV90910293 ,  2 , null,  2014-11-10 08:20:36 ,  2014-11-10 08:20:36 ,  1 ,  BodyPart_b64f80f8-c0ea-44d2-a9cb-a40bf89a8c79 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 178 ,  1100 ,  1 ,  Sample Invoice.pdf ,   ,  2 , null,  2014-11-10 08:45:40 ,  2014-11-10 08:45:40 ,  1 ,  BodyPart_7e314ec2-8514-4693-a591-b3f8c4318d1b ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 179 ,  1097 ,  9 ,  Sample Invoice.pdf ,  inv87362934 ,  2 , null,  2014-11-10 09:18:34 ,  2014-11-10 09:18:34 ,  1 ,  BodyPart_9ddb7629-faa5-4b0b-95fe-1553c9a07235 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 180 ,  1101 ,  1 ,  Sample Invoice.pdf ,  INV ,  2 , null,  2014-11-10 10:05:38 ,  2014-11-10 10:05:38 ,  1 ,  BodyPart_1883e614-a856-404f-af23-ede04ffd48d0 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 181 ,  1101 ,  1 ,  Bill_Of_Lading.pdf ,  BOL982374 ,  1 , null,  2014-11-10 10:05:53 ,  2014-11-10 10:05:53 ,  1 ,  BodyPart_e2733df1-cb56-4996-a61b-e1042d691944 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 182 ,  1096 ,  9 ,  Sample Invoice.pdf ,   ,  3 , null,  2014-11-10 11:33:02 ,  2014-11-10 11:33:02 ,  1 ,  BodyPart_69584024-a3da-4f35-b4c6-815dfe8ed67f ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 183 ,  1103 ,  1 ,  Test Document.txt ,  Test ,  2 , null,  2014-11-10 16:30:37 ,  2014-11-10 16:30:37 ,  1 ,  BodyPart_15ea4c36-d361-4a69-8333-5919cce7a709 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 184 ,  1103 ,  1 ,  Test Document.txt ,  Test 2 ,  2 , null,  2014-11-10 16:33:05 ,  2014-11-10 16:33:05 ,  1 ,  BodyPart_fcb22d6c-309b-4978-b1f8-b1851eff67bb ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 185 ,  1104 ,  1 ,  Sample Invoice.pdf ,  INV837298 ,  2 ,  0 ,  2014-11-11 06:45:20 ,  2014-11-11 06:45:31 ,  1 ,  BodyPart_b2f48661-5ba8-4b85-a3d8-4a006e9d8330 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 186 ,  1104 ,  9 ,  Bill_Of_Lading.pdf ,  BOL837398 ,  1 , null,  2014-11-11 07:18:52 ,  2014-11-11 07:18:52 ,  1 ,  BodyPart_d70ae1e0-7e38-43f8-8b58-ed0ba4659bc9 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 187 ,  1105 ,  1 ,  Sample Invoice.pdf ,  INV48736328 ,  2 , null,  2014-11-11 07:43:32 ,  2014-11-11 07:43:32 ,  1 ,  BodyPart_5ddf2d10-bf95-44fa-a34e-4ea0b94dc8c1 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 188 ,  521 ,  9 ,  Bill_Of_Lading.pdf ,  BOL ,  1 , null,  2014-11-11 20:33:39 ,  2014-11-11 20:33:39 ,  1 ,  BodyPart_39e19e7a-6438-4848-9d78-ce801cb11912 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 189 ,  252 ,  9 ,  Bill_Of_Lading.pdf ,  BOL GCKQCJQMPXCUATU ,  1 , null,  2014-11-11 20:39:40 ,  2014-11-11 20:39:40 ,  1 ,  BodyPart_4b8c05e9-467f-454b-b344-09475b214065 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 190 ,  264 ,  9 ,  Bill_Of_Lading.pdf ,  BOL QEX ,  1 , null,  2014-11-11 21:12:38 ,  2014-11-11 21:12:38 ,  1 ,  BodyPart_e1f9891f-5611-4a35-bd6d-8e7c4f036303 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 191 ,  339 ,  9 ,  Bill_Of_Lading.pdf ,  BOL 9374986y353 ,  1 , null,  2014-11-13 13:45:43 ,  2014-11-13 13:45:43 ,  1 ,  BodyPart_f86d523b-9fe6-4d92-b430-7fb32931f34c ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 192 ,  1108 ,  9 ,  Test Document.txt ,  Test333 ,  1 , null,  2014-11-13 18:35:17 ,  2014-11-13 18:35:17 ,  1 ,  BodyPart_25d22e59-fd21-451b-86c2-f53131233f84 ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 193 ,  1103 ,  9 ,  Test Document.txt ,  test7 ,  2 , null,  2014-11-13 18:35:48 ,  2014-11-13 18:35:48 ,  1 ,  BodyPart_cf4d87f0-90e3-40af-b0e3-3ec4bc4429aa ,  .txt );
INSERT INTO   transactionsattachments   VALUES ( 194 ,  1110 ,  9 ,  21 Day Complaint Free Challenge.docx ,  INV47348743 ,  2 , null,  2014-11-13 18:56:58 ,  2014-11-13 18:56:58 ,  1 ,  BodyPart_20ee3bbb-9196-422f-b8fd-ebbb67be1c42 ,  .docx );
INSERT INTO   transactionsattachments  VALUES ( 195 ,  1110 ,  1 ,  Sample Invoice.pdf ,  Storage fee documents ,  3 ,  0 ,  2014-11-14 07:52:41 ,  2014-11-14 07:55:16 ,  1 ,  BodyPart_433b816b-4019-4335-993e-8e13f8b7b600 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 196 ,  1110 ,  1 ,  Payment Method Screen.jpg ,  testing attachments ,  3 , null,  2014-11-14 07:56:00 ,  2014-11-14 07:56:00 ,  1 ,  BodyPart_8618e457-c9d7-4a1e-8a28-300763848aed ,  .jpg );
INSERT INTO   transactionsattachments   VALUES ( 197 ,  1111 ,  9 ,  Sample Invoice.pdf ,  INV47434 ,  2 , null,  2014-11-14 11:04:19 ,  2014-11-14 11:04:19 ,  1 ,  BodyPart_c6d9bc35-8cb6-444b-8221-62178eb40397 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 198 ,  1112 ,  9 ,  Sample Invoice.pdf ,  INV983873 ,  2 , null,  2014-11-24 07:36:39 ,  2014-11-24 07:36:39 ,  1 ,  BodyPart_d72c8c5c-349c-497c-b78c-6568545cfb03 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 199 ,  449 ,  9 ,  Bill_Of_Lading.pdf ,  BOL 03983043 ,  1 , null,  2014-12-03 10:05:39 ,  2014-12-03 10:05:39 ,  1 ,  BodyPart_7ecba961-0fd4-4027-8e64-49c9fffdd976 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 200 ,  232 ,  9 ,  Bill_Of_Lading.pdf ,  BOL83839 ,  1 , null,  2014-12-03 10:10:25 ,  2014-12-03 10:10:25 ,  1 ,  BodyPart_759d1514-a1f8-4ea4-a606-185507f805fc ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 201 ,  1112 ,  9 ,  Dr. Seuss Week 029.JPG ,   ,  2 , null,  2014-12-06 09:13:39 ,  2014-12-06 09:13:39 ,  1 ,  BodyPart_57f708cb-c286-4f3f-a00c-3509c7dc51c1 ,  .JPG );
INSERT INTO   transactionsattachments   VALUES ( 202 ,  1113 ,  9 ,  Sample Invoice.pdf ,  INV8384993 ,  2 ,  1 ,  2015-01-08 11:37:52 ,  2015-01-08 11:39:02 ,  1 ,  BodyPart_b3042071-f6e2-4498-baac-ff48840f3ae6 ,  .pdf );
INSERT INTO   transactionsattachments   VALUES ( 203 ,  1113 ,  1 ,  Bill_Of_Lading.pdf ,   ,  1 , null,  2015-01-08 11:41:33 ,  2015-01-08 11:41:33 ,  1 ,  BodyPart_3e15e1f5-d353-465e-80c9-a3e4f095acd8 ,  .pdf );

-- ----------------------------
-- Table structure for transactionsaudits
-- ----------------------------
DROP TABLE IF EXISTS   transactionsaudits  ;
CREATE TABLE   transactionsaudits   (
  id int(11) NOT NULL,
    eec_id int(11) NOT NULL,
    action_id int(11) DEFAULT NULL,
    chg_date   datetime DEFAULT NULL,
    performed_by_sysusers   varchar(128) DEFAULT NULL,
    performed_by_appusers   int(11) DEFAULT NULL,
    upd_col   int(11) DEFAULT NULL,
    oldValue   text,
    newValue   text,
    disputing   tinyint(4) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY   performed_by_appusers   (  performed_by_appusers  ),
  KEY   transactionsaudits_Rec_id(  Rec_id   ),
  CONSTRAINT   transactionsaudits_ibfk_1   FOREIGN KEY (  performed_by_appusers  ) REFERENCES   userss   (id)
) ;

-- ----------------------------
-- Records of transactionsaudits
-- ----------------------------
INSERT INTO   transactionsaudits   VALUES ( 1 ,  607 ,  2 ,  2014-04-02 16:42:55 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 2 ,  811 ,  2 ,  2014-04-02 16:45:45 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 3 ,  835 ,  2 ,  2014-04-03 08:48:17 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 4 ,  835 ,  2 ,  2014-04-03 08:48:17 ,  PayAnyBizDB ,  1 ,  18 , null,  100.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 5 ,  259 ,  2 ,  2014-04-07 06:18:36 ,  PayAnyBizDB ,  1 ,  15 ,  REF-2001-1 ,  REF-2001-12 , null);
INSERT INTO   transactionsaudits   VALUES ( 6 ,  259 ,  2 ,  2014-04-07 06:18:45 ,  PayAnyBizDB ,  1 ,  3 ,  UOBJ87RAYDGFQV ,  UOBJ87RAYDGFQV111 , null);
INSERT INTO   transactionsaudits   VALUES ( 7 ,  259 ,  2 ,  2014-04-07 06:54:46 ,  PayAnyBizDB ,  1 ,  12 ,  733.00 ,  1,854.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 8 ,  259 ,  2 ,  2014-04-07 06:54:57 ,  PayAnyBizDB ,  1 ,  1 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 9 ,  259 ,  2 ,  2014-04-07 06:55:08 ,  PayAnyBizDB ,  1 ,  8 ,  2013-11-22 00:00:00 ,  2013-11-08 00:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 10 ,  259 ,  2 ,  2014-04-07 06:55:55 ,  PayAnyBizDB ,  1 ,  10 ,  2013-11-24 00:00:00 ,  2014-04-08 23:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 11 ,  1032 ,  1 ,  2014-04-07 07:55:13 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 12 ,  1032 ,  2 ,  2014-04-07 08:22:34 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 13 ,  871 ,  2 ,  2014-04-07 08:25:21 ,  PayAnyBizDB ,  1 ,  12 ,  960.00 ,  1,058.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 14 ,  263 ,  2 ,  2014-04-07 10:03:44 ,  PayAnyBizDB ,  1 ,  10 ,  2013-11-24 00:00:00 ,  2014-04-08 23:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 15 ,  263 ,  2 ,  2014-04-07 10:03:44 ,  PayAnyBizDB ,  1 ,  12 ,  529.00 ,  2,453.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 16 ,  263 ,  2 ,  2014-04-07 10:04:04 ,  PayAnyBizDB ,  1 ,  8 ,  2013-11-22 00:00:00 ,  2013-11-17 00:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 17 ,  263 ,  2 ,  2014-04-07 10:04:04 ,  PayAnyBizDB ,  1 ,  9 ,  2013-11-24 00:00:00 ,  2013-11-30 00:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 18 ,  263 ,  2 ,  2014-04-07 10:04:13 ,  PayAnyBizDB ,  1 ,  1 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 19 ,  263 ,  2 ,  2014-04-07 10:04:13 ,  PayAnyBizDB ,  1 ,  7 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 20 ,  559 ,  2 ,  2014-04-09 18:56:08 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 21 ,  871 ,  2 ,  2014-04-09 20:05:29 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 22 ,  267 ,  2 ,  2014-04-14 21:33:36 ,  PayAnyBizDB ,  1 ,  12 ,  919.00 ,  3,333.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 23 ,  871 ,  2 ,  2014-04-15 18:50:56 ,  PayAnyBizDB ,  1 ,  7 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 24 ,  871 ,  2 ,  2014-04-15 18:51:04 ,  PayAnyBizDB ,  1 ,  7 ,  2 ,  1 , null);
INSERT INTO   transactionsaudits   VALUES ( 25 ,  871 ,  2 ,  2014-04-15 18:51:12 ,  PayAnyBizDB ,  1 ,  16 ,  9 ,  12 , null);
INSERT INTO   transactionsaudits   VALUES ( 26 ,  871 ,  2 ,  2014-04-15 18:51:19 ,  PayAnyBizDB ,  1 ,  12 ,  1,058.00 ,  3,000.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 27 ,  871 ,  2 ,  2014-04-15 18:51:30 ,  PayAnyBizDB ,  1 ,  12 ,  3,000.00 ,  3,900.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 28 ,  871 ,  2 ,  2014-04-15 18:52:05 ,  PayAnyBizDB ,  1 ,  13 ,  TXN-001 ,  TXN-00176879 , null);
INSERT INTO   transactionsaudits   VALUES ( 29 ,  871 ,  2 ,  2014-04-15 18:52:14 ,  PayAnyBizDB ,  1 ,  13 ,  TXN-00176879 ,  TXN-gffhgfhgfhgfhgfhgfhgfhfghfg , null);
INSERT INTO   transactionsaudits   VALUES ( 30 ,  871 ,  2 ,  2014-04-15 18:52:29 ,  PayAnyBizDB ,  1 ,  8 ,  2013-11-22 00:00:00 ,  2013-11-26 00:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 31 ,  871 ,  2 ,  2014-04-15 18:53:48 ,  PayAnyBizDB ,  1 ,  13 ,  TXN-gffhgfhgfhgfhgfhgfhgfhfghfg ,  TXN , null);
INSERT INTO   transactionsaudits   VALUES ( 32 ,  7 ,  2 ,  2014-04-15 23:11:11 ,  PayAnyBizDB ,  1 ,  9 ,  2013-11-24 00:00:00 ,  2013-11-12 00:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 33 ,  11 ,  2 ,  2014-04-15 23:14:42 ,  PayAnyBizDB ,  1 ,  15 ,  REF-2001-1 ,  REF-2001-12 , null);
INSERT INTO   transactionsaudits   VALUES ( 34 ,  295 ,  2 ,  2014-04-15 23:15:16 ,  PayAnyBizDB ,  1 ,  15 ,  REF-2001-1 ,  REF-2001-12 , null);
INSERT INTO   transactionsaudits   VALUES ( 35 ,  295 ,  2 ,  2014-04-15 23:15:31 ,  PayAnyBizDB ,  1 ,  15 ,  REF-2001-12 ,  REF-2001-4 , null);
INSERT INTO   transactionsaudits   VALUES ( 38 ,  807 ,  2 ,  2014-04-16 10:43:24 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 39 ,  287 ,  2 ,  2014-04-16 13:04:39 ,  PayAnyBizDB ,  1 ,  3 ,  ERSFQDIN9KJJCJS ,  ERSFQDIN9KJJCJS-1 , null);
INSERT INTO   transactionsaudits   VALUES ( 40 ,  1033 ,  1 ,  2014-04-16 19:42:32 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 41 ,  1031 ,  2 ,  2014-04-16 20:46:31 ,  PayAnyBizDB ,  1 ,  3 ,  FD76367483 ,  FD76367483-3333 , null);
INSERT INTO   transactionsaudits   VALUES ( 42 ,  267 ,  2 ,  2014-04-17 09:49:10 ,  PayAnyBizDB ,  1 ,  13 ,  TXN-001 ,  TXN-001\nAdding more information on the subject line, just because! , null);
INSERT INTO   transactionsaudits   VALUES ( 43 ,  267 ,  2 ,  2014-04-17 09:49:55 ,  PayAnyBizDB ,  1 ,  13 ,  TXN-001\nAdding more information on the subject line, just because! ,  TXN-001\nAdding more information on the subject line, just because!\nAdding another line , null);
INSERT INTO   transactionsaudits   VALUES ( 44 ,  271 ,  2 ,  2014-04-17 09:53:04 ,  PayAnyBizDB ,  1 ,  8 ,  2013-11-22 00:00:00 ,  2013-11-23 00:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 45 ,  271 ,  2 ,  2014-04-17 09:53:40 ,  PayAnyBizDB ,  1 ,  12 ,  199.00 ,  2,899.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 46 ,  271 ,  2 ,  2014-04-17 09:54:17 ,  PayAnyBizDB ,  1 ,  7 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 47 ,  271 ,  2 ,  2014-04-17 09:54:22 ,  PayAnyBizDB ,  1 ,  17 ,  8 ,  6 , null);
INSERT INTO   transactionsaudits   VALUES ( 48 ,  271 ,  2 ,  2014-04-17 09:54:31 ,  PayAnyBizDB ,  1 ,  3 ,  UZQTBQ5KZSKGONE ,  UZQTBQ5KZSKGONE-1 , null);
INSERT INTO   transactionsaudits   VALUES ( 49 ,  271 ,  2 ,  2014-04-17 09:54:41 ,  PayAnyBizDB ,  1 ,  4 ,  DSWM8JR8FRKFGH2 ,  DSWM8JR8FRKFGH2-1 , null);
INSERT INTO   transactionsaudits   VALUES ( 50 ,  271 ,  2 ,  2014-04-17 09:54:52 ,  PayAnyBizDB ,  1 ,  10 ,  2013-11-24 00:00:00 ,  2013-11-15 00:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 51 ,  287 ,  2 ,  2014-04-17 11:00:10 ,  PayAnyBizDB ,  1 ,  3 ,  ERSFQDIN9KJJCJS-1 ,  ERSFQDIN9KJJCJS-1-1 , null);
INSERT INTO   transactionsaudits   VALUES ( 52 ,  287 ,  2 ,  2014-04-17 11:00:18 ,  PayAnyBizDB ,  1 ,  1 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 53 ,  875 ,  2 ,  2014-04-17 11:01:37 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 54 ,  712 ,  2 ,  2014-04-17 11:14:23 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 55 ,  713 ,  2 ,  2014-04-17 11:14:23 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 56 ,  794 ,  2 ,  2014-04-17 11:14:23 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 57 ,  271 ,  2 ,  2014-04-17 11:39:14 ,  PayAnyBizDB ,  1 ,  7 ,  2 ,  1 , null);
INSERT INTO   transactionsaudits   VALUES ( 58 ,  271 ,  2 ,  2014-04-17 11:39:37 ,  PayAnyBizDB ,  1 ,  13 ,  TXN-001 ,  TXN-001\nadding more in the description , null);
INSERT INTO   transactionsaudits   VALUES ( 59 ,  1028 ,  2 ,  2014-04-17 11:52:48 ,  PayAnyBizDB ,  1 ,  10 , null,  2014-04-30 23:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 60 ,  1028 ,  2 ,  2014-04-17 11:52:48 ,  PayAnyBizDB ,  1 ,  12 , null,  4,560.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 61 ,  1028 ,  2 ,  2014-04-17 11:52:48 ,  PayAnyBizDB ,  1 ,  15 , null,  REF biller 12 , null);
INSERT INTO   transactionsaudits   VALUES ( 62 ,  1028 ,  2 ,  2014-04-17 16:41:46 ,  PayAnyBizDB ,  1 ,  4 ,  maeu48375956 ,  maeu483759569 , null);
INSERT INTO   transactionsaudits   VALUES ( 63 ,  1028 ,  2 ,  2014-04-17 17:49:18 ,  PayAnyBizDB ,  1 ,  8 , null,  2014-04-09 23:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 64 ,  1028 ,  2 ,  2014-04-17 17:49:29 ,  PayAnyBizDB ,  1 ,  9 , null,  2014-04-16 23:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 65 ,  1028 ,  2 ,  2014-04-17 17:49:40 ,  PayAnyBizDB ,  1 ,  3 ,  121212345 ,  121212345-654 , null);
INSERT INTO   transactionsaudits   VALUES ( 66 ,  1028 ,  2 ,  2014-04-17 17:49:53 ,  PayAnyBizDB ,  1 ,  12 ,  4,560.00 ,  5,800.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 67 ,  1028 ,  2 ,  2014-04-17 17:50:04 ,  PayAnyBizDB ,  1 ,  15 ,  REF biller 12 ,  REF biller 12-1 , null);
INSERT INTO   transactionsaudits   VALUES ( 68 ,  1028 ,  2 ,  2014-04-17 17:50:27 ,  PayAnyBizDB ,  1 ,  13 , null,  asdfasfdvg\nsfgsfrg\n\naergsefgsdg\nsfgsefgdsfg\nsafgsegdsfg\nsdfgsefgsfg\nesfgsfdgsdfg , null);
INSERT INTO   transactionsaudits   VALUES ( 69 ,  1028 ,  2 ,  2014-04-17 17:50:49 ,  PayAnyBizDB ,  1 ,  13 ,  asdfasfdvg\nsfgsfrg\n\naergsefgsdg\nsfgsefgdsfg\nsafgsegdsfg\nsdfgsefgsfg\nesfgsfdgsdfg ,  asdfasfdvg\nsfgsfrg\n\naergsefgsdg\nsfgsefgdsfg\nsafgsegdsfg\nsdfgsefgsfg\nesfgsfdgsdfg\nafsfdaf\nwafsfafs\nwfsafsafsa\nfwrrfsfsfgg\nsfgsffdsgfdf , null);
INSERT INTO   transactionsaudits   VALUES ( 70 ,  354 ,  2 ,  2014-04-17 17:58:10 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 71 ,  299 ,  2 ,  2014-04-18 11:46:49 ,  PayAnyBizDB ,  1 ,  15 ,  REF-2001-1 ,  REF-2001-1-0 , null);
INSERT INTO   transactionsaudits   VALUES ( 72 ,  1034 ,  1 ,  2014-04-18 11:50:25 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 73 ,  1034 ,  2 ,  2014-04-18 11:50:56 ,  PayAnyBizDB ,  1 ,  15 ,  r46tyu77865 ,  r46tyu77865-1 , null);
INSERT INTO   transactionsaudits   VALUES ( 74 ,  1034 ,  2 ,  2014-04-18 11:51:05 ,  PayAnyBizDB ,  1 ,  4 ,  MAEU738747888 ,  MAEU73874788899 , null);
INSERT INTO   transactionsaudits   VALUES ( 75 ,  1034 ,  2 ,  2014-04-18 11:53:29 ,  PayAnyBizDB ,  1 ,  13 , null,  aqui estoy con Agustin , null);
INSERT INTO   transactionsaudits   VALUES ( 76 ,  1034 ,  2 ,  2014-04-19 15:47:02 ,  PayAnyBizDB ,  1 ,  13 ,  aqui estoy con Agustin ,  aqui estoy con Agustin.\n-Saludos de mi parte... El Pupilo , null);
INSERT INTO   transactionsaudits   VALUES ( 77 ,  1034 ,  2 ,  2014-04-19 22:21:58 ,  PayAnyBizDB ,  1 ,  17 ,  11 ,  12 , null);
INSERT INTO   transactionsaudits   VALUES ( 78 ,  1034 ,  2 ,  2014-04-19 22:24:27 ,  PayAnyBizDB ,  1 ,  17 ,  12 ,  9 , null);
INSERT INTO   transactionsaudits   VALUES ( 79 ,  1034 ,  2 ,  2014-04-19 22:33:17 ,  PayAnyBizDB ,  1 ,  17 ,  9 ,  11 , null);
INSERT INTO   transactionsaudits   VALUES ( 80 ,  1034 ,  2 ,  2014-04-19 22:37:51 ,  PayAnyBizDB ,  1 ,  1 ,  4 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 81 ,  1034 ,  2 ,  2014-04-19 22:37:51 ,  PayAnyBizDB ,  1 ,  7 ,  2 ,  1 , null);
INSERT INTO   transactionsaudits   VALUES ( 82 ,  1034 ,  2 ,  2014-04-19 22:37:51 ,  PayAnyBizDB ,  1 ,  17 ,  11 ,  6 , null);
INSERT INTO   transactionsaudits   VALUES ( 83 ,  1029 ,  2 ,  2014-04-19 22:51:39 ,  PayAnyBizDB ,  1 ,  17 ,  6 ,  12 , null);
INSERT INTO   transactionsaudits   VALUES ( 84 ,  1034 ,  2 ,  2014-04-20 21:16:05 ,  PayAnyBizDB ,  1 ,  7 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 85 ,  1034 ,  2 ,  2014-04-20 21:16:14 ,  PayAnyBizDB ,  1 ,  3 ,  4567898765 ,  4567898765dd , null);
INSERT INTO   transactionsaudits   VALUES ( 86 ,  882 ,  2 ,  2014-04-20 21:29:35 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 87 ,  882 ,  2 ,  2014-04-20 21:29:46 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 88 ,  882 ,  2 ,  2014-04-20 21:30:18 ,  PayAnyBizDB ,  1 ,  3 ,  SGDCZZ5YGNYTCJO ,  SGDCZZ5YGNYTCJO\\\\\\\\ , null);
INSERT INTO   transactionsaudits   VALUES ( 89 ,  867 ,  2 ,  2014-04-20 21:32:21 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 90 ,  867 ,  2 ,  2014-04-20 21:32:21 ,  PayAnyBizDB ,  1 ,  18 , null,  100.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 91 ,  1031 ,  2 ,  2014-04-24 20:03:58 ,  PayAnyBizDB ,  1 ,  12 ,  18,000.00 ,  30,000.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 92 ,  1033 ,  2 ,  2014-04-26 09:09:26 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 93 ,  1033 ,  2 ,  2014-04-26 09:12:08 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 94 ,  846 ,  2 ,  2014-04-26 09:21:06 ,  PayAnyBizDB ,  1 ,  15 ,  REF-0343535 ,  REF-0343535-1 , null);
INSERT INTO   transactionsaudits   VALUES ( 95 ,  881 ,  2 ,  2014-04-26 14:37:44 ,  PayAnyBizDB ,  1 ,  15 ,  REF-00234 ,  REF-00234-1 , null);
INSERT INTO   transactionsaudits   VALUES ( 96 ,  881 ,  2 ,  2014-04-26 14:38:05 ,  PayAnyBizDB ,  1 ,  3 ,  WIYYNWWE6CDNLVQ ,  WIYYNWWE6CDNLVQS , null);
INSERT INTO   transactionsaudits   VALUES ( 97 ,  881 ,  2 ,  2014-04-26 14:38:17 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 98 ,  852 ,  2 ,  2014-04-27 14:25:48 ,  PayAnyBizDB ,  1 ,  13 ,  TXN-02 ,  TXN-02 hello and thank you for calling , null);
INSERT INTO   transactionsaudits   VALUES ( 99 ,  852 ,  2 ,  2014-04-27 14:26:35 ,  PayAnyBizDB ,  1 ,  12 ,  687.00 ,  750.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 100 ,  852 ,  2 ,  2014-04-27 14:26:55 ,  PayAnyBizDB ,  1 ,  3 ,  JTNWBRHGLIS9BQ0 ,  JTNWBRHGLIS9BQ099 , null);
INSERT INTO   transactionsaudits   VALUES ( 101 ,  852 ,  2 ,  2014-04-27 14:30:07 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 102 ,  852 ,  2 ,  2014-04-27 14:30:28 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 103 ,  841 ,  2 ,  2014-04-27 14:36:29 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 104 ,  841 ,  2 ,  2014-04-27 14:36:29 ,  PayAnyBizDB ,  1 ,  18 , null,  91.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 105 ,  1031 ,  2 ,  2014-04-29 10:47:04 ,  PayAnyBizDB ,  1 ,  9 ,  2014-03-21 23:00:00 ,  2014-03-22 23:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 106 ,  777 ,  2 ,  2014-04-29 10:55:56 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 107 ,  777 ,  2 ,  2014-04-29 10:55:56 ,  PayAnyBizDB ,  1 ,  18 , null,  100.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 108 ,  1002 ,  2 ,  2014-05-01 08:14:28 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 109 ,  1026 ,  2 ,  2014-05-03 09:42:44 ,  PayAnyBizDB ,  1 ,  7 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 110 ,  1026 ,  2 ,  2014-05-03 09:47:59 ,  PayAnyBizDB ,  1 ,  13 ,  TXN-04 ,  TXN-04dertfyguhijokpluihygftdfyguhijokpj\nxfchgvjbklhkgfxdcghvjbknml\ngc hvbjknlm;jhgvcvhbjn , null);
INSERT INTO   transactionsaudits   VALUES ( 111 ,  1034 ,  1 ,  2014-05-05 20:48:22 ,  PayAnyBizDB ,  1 ,  96 ,   ,  yyyyyyC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Invoice\\private\\3\\20140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 112 ,  1031 ,  1 ,  2014-05-05 20:56:21 ,  PayAnyBizDB ,  1 ,  96 ,   ,  yyyyC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1031\\Other\\private\\3\\20140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 113 ,  1031 ,  1 ,  2014-05-05 20:56:55 ,  PayAnyBizDB ,  1 ,  96 ,   ,  kkkkkC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1031\\BOL\\private\\3\\20140419_103116.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 114 ,  1034 ,  1 ,  2014-05-05 21:04:00 ,  PayAnyBizDB ,  1 ,  96 ,   ,  C:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Invoice\\private\\3\\20140419_103116.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 115 ,  1034 ,  1 ,  2014-05-05 21:07:17 ,  PayAnyBizDB ,  1 ,  96 ,   ,  C:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Invoice\\private\\3\\20140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 116 ,  1034 ,  1 ,  2014-05-05 21:07:50 ,  PayAnyBizDB ,  1 ,  96 ,   ,  C:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Invoice\\private\\3\\20140419_103116.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 117 ,  1034 ,  1 ,  2014-05-05 21:09:03 ,  PayAnyBizDB ,  1 ,  96 ,   ,  000000C:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Invoice\\private\\3\\20140419_103116.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 118 ,  1034 ,  1 ,  2014-05-05 21:14:46 ,  PayAnyBizDB ,  1 ,  96 ,   ,  ggggggggC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Dispute\\private\\3\\20140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 119 ,  1034 ,  1 ,  2014-05-05 21:27:24 ,  PayAnyBizDB ,  1 ,  96 ,   ,  uuuuuuC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Dispute\\private\\3\\20140419_103116.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 120 ,  1034 ,  1 ,  2014-05-05 21:29:27 ,  PayAnyBizDB ,  1 ,  96 ,   ,  iiiiiiC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Dispute\\private\\3\\20140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 121 ,  1034 ,  1 ,  2014-05-05 21:29:53 ,  PayAnyBizDB ,  1 ,  96 ,   ,  ttttttC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Other\\private\\3\\20140419_103116.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 122 ,  1034 ,  3 ,  2014-05-06 18:54:31 ,  PayAnyBizDB ,  1 ,  97 ,  yyyyyyC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Invoice\\private\\3\\20140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 123 ,  1034 ,  3 ,  2014-05-06 18:55:08 ,  PayAnyBizDB ,  1 ,  97 ,  ttttttC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Other\\private\\3\\20140419_103116.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 124 ,  1034 ,  3 ,  2014-05-06 18:55:08 ,  PayAnyBizDB ,  1 ,  97 ,  iiiiiiC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Dispute\\private\\3\\20140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 125 ,  1034 ,  3 ,  2014-05-06 18:55:08 ,  PayAnyBizDB ,  1 ,  97 ,  uuuuuuC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Dispute\\private\\3\\20140419_103116.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 126 ,  1034 ,  3 ,  2014-05-06 18:55:08 ,  PayAnyBizDB ,  1 ,  97 ,  ggggggggC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Dispute\\private\\3\\20140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 127 ,  1034 ,  3 ,  2014-05-06 18:55:08 ,  PayAnyBizDB ,  1 ,  97 ,  000000C:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Invoice\\private\\3\\20140419_103116.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 128 ,  1034 ,  3 ,  2014-05-06 18:55:08 ,  PayAnyBizDB ,  1 ,  97 ,  C:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Invoice\\private\\3\\20140419_103116.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 129 ,  1034 ,  3 ,  2014-05-06 18:55:08 ,  PayAnyBizDB ,  1 ,  97 ,  C:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Invoice\\private\\3\\20140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 130 ,  1034 ,  3 ,  2014-05-06 18:55:08 ,  PayAnyBizDB ,  1 ,  97 ,  C:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1034\\Invoice\\private\\3\\20140419_103116.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 131 ,  1031 ,  3 ,  2014-05-06 18:55:08 ,  PayAnyBizDB ,  1 ,  97 ,  kkkkkC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1031\\BOL\\private\\3\\20140419_103116.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 132 ,  1031 ,  3 ,  2014-05-06 18:55:08 ,  PayAnyBizDB ,  1 ,  97 ,  yyyyC:\\Web\\PAB.Web\\PABMvc.Web\\documents\\1031\\Other\\private\\3\\20140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 133 ,  1034 ,  1 ,  2014-05-06 19:24:53 ,  PayAnyBizDB ,  1 ,  96 ,   ,  test420140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 134 ,  1034 ,  1 ,  2014-05-06 19:26:38 ,  PayAnyBizDB ,  1 ,  96 ,   ,  55520140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 135 ,  1034 ,  3 ,  2014-05-06 19:50:25 ,  PayAnyBizDB ,  1 ,  97 ,  55520140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 136 ,  1034 ,  3 ,  2014-05-06 19:50:25 ,  PayAnyBizDB ,  1 ,  97 ,  test420140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 137 ,  1034 ,  1 ,  2014-05-06 19:59:11 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test820140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 138 ,  1034 ,  1 ,  2014-05-06 19:59:33 ,  PayAnyBizDB ,  1 ,  96 ,   ,  test820140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 139 ,  1034 ,  3 ,  2014-05-06 20:01:19 ,  PayAnyBizDB ,  1 ,  93 ,  test820140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 140 ,  1034 ,  3 ,  2014-05-06 20:11:11 ,  PayAnyBizDB ,  1 ,  97 ,  test820140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 141 ,  1034 ,  1 ,  2014-05-06 20:11:52 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test720140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 142 ,  1034 ,  1 ,  2014-05-06 20:11:55 ,  PayAnyBizDB ,  1 ,  96 ,   ,  test720140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 143 ,  1034 ,  3 ,  2014-05-06 20:23:16 ,  PayAnyBizDB ,  1 ,  97 ,  test720140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 144 ,  1034 ,  3 ,  2014-05-06 20:23:16 ,  PayAnyBizDB ,  1 ,  93 ,  test720140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 145 ,  1034 ,  1 ,  2014-05-06 20:23:44 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test820140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 146 ,  1034 ,  1 ,  2014-05-06 20:23:48 ,  PayAnyBizDB ,  1 ,  96 ,   ,  test820140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 147 ,  1034 ,  3 ,  2014-05-06 20:27:28 ,  PayAnyBizDB ,  1 ,  97 ,  test820140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 148 ,  1034 ,  3 ,  2014-05-06 20:27:28 ,  PayAnyBizDB ,  1 ,  93 ,  test820140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 149 ,  1034 ,  1 ,  2014-05-06 20:29:31 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test920140419_103102 (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 150 ,  1034 ,  1 ,  2014-05-06 20:33:06 ,  PayAnyBizDB ,  1 ,  90 ,   ,  hhhhh20140419_103116 (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 151 ,  1034 ,  1 ,  2014-05-06 21:05:37 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test920140419_103102 (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 152 ,  1034 ,  1 ,  2014-05-06 21:09:50 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test920140419_103102 (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 153 ,  1034 ,  1 ,  2014-05-06 21:10:02 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test920140419_103102 (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 154 ,  1034 ,  1 ,  2014-05-06 21:10:08 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test920140419_103102 (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 155 ,  1034 ,  1 ,  2014-05-06 21:10:11 ,  PayAnyBizDB ,  1 ,  90 ,   ,  hhhhh20140419_103116 (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 156 ,  1034 ,  1 ,  2014-05-06 21:13:18 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test920140419_103102 (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 157 ,  1034 ,  1 ,  2014-05-06 21:13:23 ,  PayAnyBizDB ,  1 ,  90 ,   ,  hhhhh20140419_103116 (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 158 ,  1034 ,  3 ,  2014-05-07 19:56:50 ,  PayAnyBizDB ,  1 ,  91 ,  hhhhh20140419_103116 (1).jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 159 ,  1034 ,  3 ,  2014-05-07 19:56:50 ,  PayAnyBizDB ,  1 ,  93 ,  test920140419_103102 (1).jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 160 ,  1034 ,  1 ,  2014-05-07 19:57:44 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test120140419_103102 (1) (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 161 ,  1034 ,  1 ,  2014-05-07 19:59:28 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test120140419_103102 (1) (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 162 ,  1034 ,  1 ,  2014-05-07 19:59:31 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test120140419_103102 (1) (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 163 ,  1031 ,  2 ,  2014-05-07 20:06:25 ,  PayAnyBizDB ,  1 ,  17 ,  12 ,  6 , null);
INSERT INTO   transactionsaudits   VALUES ( 164 ,  1034 ,  1 ,  2014-05-07 20:07:51 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test120140419_103102 (1) (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 165 ,  1034 ,  1 ,  2014-05-07 20:07:54 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test120140419_103102 (1) (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 166 ,  1028 ,  1 ,  2014-05-07 20:17:39 ,  PayAnyBizDB ,  1 ,  96 ,   ,  tttt20140419_103102.jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 167 ,  1028 ,  3 ,  2014-05-07 20:17:57 ,  PayAnyBizDB ,  1 ,  97 ,  tttt20140419_103102.jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 168 ,  861 ,  2 ,  2014-05-08 07:56:23 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 169 ,  828 ,  2 ,  2014-05-09 07:49:57 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 170 ,  840 ,  2 ,  2014-05-09 07:49:57 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 171 ,  850 ,  2 ,  2014-05-09 07:49:57 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 172 ,  999 ,  2 ,  2014-05-11 19:07:56 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 173 ,  1028 ,  1 ,  2014-05-12 10:15:08 ,  PayAnyBizDB ,  1 ,  96 ,   ,  InvoiceD:\\Hosting\\10091521\\html\\testpayanybiz\\documents\\1028\\Invoice\\private\\3\\IMG_5003.PNG , null);
INSERT INTO   transactionsaudits   VALUES ( 174 ,  915 ,  2 ,  2014-05-13 08:30:35 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 175 ,  915 ,  1 ,  2014-05-13 08:31:20 ,  PayAnyBizDB ,  1 ,  96 ,   ,  invoiceD:\\Hosting\\10091521\\html\\testpayanybiz\\documents\\915\\BOL\\private\\3\\IMG_5001.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 176 ,  1033 ,  2 ,  2014-05-13 08:46:55 ,  PayAnyBizDB ,  1 ,  3 ,  INV89898989898 ,  INV89898989898-1 , null);
INSERT INTO   transactionsaudits   VALUES ( 179 ,  867 ,  2 ,  2014-05-16 10:07:43 ,  PayAnyBizDB ,  1 ,  7 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 180 ,  867 ,  1 ,  2014-05-16 10:08:10 ,  PayAnyBizDB ,  1 ,  96 ,   ,  D:\\Hosting\\10091521\\html\\testpayanybiz\\documents\\867\\Invoice\\private\\3\\PayAnyBiz Brief Summary March 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 181 ,  889 ,  2 ,  2014-05-16 10:20:34 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 182 ,  889 ,  2 ,  2014-05-16 10:20:34 ,  PayAnyBizDB ,  1 ,  18 , null,  120.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 183 ,  873 ,  2 ,  2014-05-20 05:21:49 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 184 ,  873 ,  2 ,  2014-05-20 05:21:54 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 185 ,  1031 ,  1 ,  2014-05-20 19:57:08 ,  PayAnyBizDB ,  1 ,  90 ,   ,  1-html5-line-of-business-applications-m1-sl_id es.pdf , null);
INSERT INTO   transactionsaudits   VALUES ( 186 ,  1031 ,  1 ,  2014-05-20 19:57:08 ,  PayAnyBizDB ,  1 ,  90 ,   ,  tst1-html5-line-of-business-applications-m1-sl_id es.pdf , null);
INSERT INTO   transactionsaudits   VALUES ( 187 ,  1031 ,  3 ,  2014-05-20 19:57:23 ,  PayAnyBizDB ,  1 ,  91 ,  1-html5-line-of-business-applications-m1-sl_id es.pdf ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 188 ,  1031 ,  3 ,  2014-05-20 19:57:28 ,  PayAnyBizDB ,  1 ,  91 ,  tst1-html5-line-of-business-applications-m1-sl_id es.pdf ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 189 ,  1031 ,  1 ,  2014-05-20 19:57:34 ,  PayAnyBizDB ,  1 ,  90 ,   ,  test1-html5-line-of-business-applications-m1-sl_id es (1).pdf , null);
INSERT INTO   transactionsaudits   VALUES ( 190 ,  1031 ,  1 ,  2014-05-20 19:57:35 ,  PayAnyBizDB ,  1 ,  90 ,   ,  1-html5-line-of-business-applications-m1-sl_id es (1).pdf , null);
INSERT INTO   transactionsaudits   VALUES ( 191 ,  1031 ,  3 ,  2014-05-20 20:00:34 ,  PayAnyBizDB ,  1 ,  91 ,  1-html5-line-of-business-applications-m1-sl_id es (1).pdf ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 192 ,  1031 ,  3 ,  2014-05-20 20:00:34 ,  PayAnyBizDB ,  1 ,  91 ,  test1-html5-line-of-business-applications-m1-sl_id es (1).pdf ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 193 ,  867 ,  3 ,  2014-05-20 20:00:34 ,  PayAnyBizDB ,  1 ,  97 ,  D:\\Hosting\\10091521\\html\\testpayanybiz\\documents\\867\\Invoice\\private\\3\\PayAnyBiz Brief Summary March 2014.docx ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 194 ,  915 ,  3 ,  2014-05-20 20:00:34 ,  PayAnyBizDB ,  1 ,  97 ,  invoiceD:\\Hosting\\10091521\\html\\testpayanybiz\\documents\\915\\BOL\\private\\3\\IMG_5001.JPG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 195 ,  1028 ,  3 ,  2014-05-20 20:00:34 ,  PayAnyBizDB ,  1 ,  97 ,  InvoiceD:\\Hosting\\10091521\\html\\testpayanybiz\\documents\\1028\\Invoice\\private\\3\\IMG_5003.PNG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 196 ,  1034 ,  3 ,  2014-05-20 20:00:34 ,  PayAnyBizDB ,  1 ,  93 ,  test120140419_103102 (1) (1).jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 197 ,  1034 ,  1 ,  2014-05-20 20:02:37 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test img20140419_103102 (1) (1) (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 198 ,  1034 ,  1 ,  2014-05-20 20:02:48 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test img20140419_103102 (1) (1) (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 199 ,  1034 ,  1 ,  2014-05-20 20:02:50 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test img20140419_103102 (1) (1) (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 200 ,  1034 ,  1 ,  2014-05-20 20:04:01 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test pdf1-html5-line-of-business-applications-m1-sl_id es (1).pdf , null);
INSERT INTO   transactionsaudits   VALUES ( 201 ,  1031 ,  1 ,  2014-05-20 20:04:23 ,  PayAnyBizDB ,  1 ,  90 ,   ,  test img20140419_103102 (1) (1) (1) (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 202 ,  1034 ,  1 ,  2014-05-21 06:01:31 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test img20140419_103102 (1) (1) (1).jpeg , null);
INSERT INTO   transactionsaudits   VALUES ( 203 ,  833 ,  2 ,  2014-05-21 06:04:59 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 204 ,  833 ,  2 ,  2014-05-21 06:04:59 ,  PayAnyBizDB ,  1 ,  18 , null,  100.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 205 ,  1033 ,  1 ,  2014-05-21 10:46:13 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOLPicture 058.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 212 ,  1032 ,  2 ,  2014-05-22 22:18:21 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 213 ,  818 ,  2 ,  2014-05-22 22:43:59 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 214 ,  881 ,  2 ,  2014-05-23 16:24:34 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 215 ,  712 ,  2 ,  2014-05-23 16:26:02 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 216 ,  875 ,  2 ,  2014-05-23 16:29:13 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 217 ,  803 ,  2 ,  2014-05-23 16:43:08 ,  PayAnyBizDB ,  1 ,  1 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 218 ,  871 ,  2 ,  2014-05-23 16:57:12 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 219 ,  794 ,  2 ,  2014-05-23 16:57:47 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 220 ,  803 ,  2 ,  2014-05-23 16:57:47 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 221 ,  807 ,  2 ,  2014-05-23 16:57:47 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 222 ,  771 ,  2 ,  2014-05-23 16:58:55 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 223 ,  741 ,  1 ,  2014-05-24 11:30:21 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV47384photo_3-6.JPG.html , null);
INSERT INTO   transactionsaudits   VALUES ( 224 ,  741 ,  2 ,  2014-05-24 11:31:25 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 225 ,  741 ,  2 ,  2014-05-24 11:34:20 ,  PayAnyBizDB ,  1 ,  13 ,  TXN-03 ,  TXN-03\ni added payment conf number and it does not reflect in Payment Confirmation No\ s , null);
INSERT INTO   transactionsaudits   VALUES ( 226 ,  762 ,  1 ,  2014-05-24 15:17:17 ,  PayAnyBizDB ,  1 ,  90 ,   ,  bolPicture 054.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 227 ,  1029 ,  1 ,  2014-05-25 11:51:07 ,  PayAnyBizDB ,  1 ,  90 ,   ,  InvoicePicture 055.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 228 ,  1029 ,  2 ,  2014-05-25 11:59:28 ,  PayAnyBizDB ,  1 ,  13 , null,  There should be away to have people know that there is something in this field. , null);
INSERT INTO   transactionsaudits   VALUES ( 229 ,  806 ,  2 ,  2014-05-25 18:39:23 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 230 ,  806 ,  2 ,  2014-05-25 18:41:01 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 231 ,  752 ,  2 ,  2014-05-25 18:43:49 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 232 ,  752 ,  2 ,  2014-05-25 18:43:49 ,  PayAnyBizDB ,  1 ,  18 , null,  100.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 233 ,  850 ,  2 ,  2014-05-26 18:23:52 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 234 ,  846 ,  2 ,  2014-05-27 20:41:07 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 235 ,  873 ,  2 ,  2014-05-27 20:41:56 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 236 ,  873 ,  2 ,  2014-05-27 20:41:56 ,  PayAnyBizDB ,  1 ,  18 ,   ,  410.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 237 ,  1032 ,  2 ,  2014-05-27 21:09:43 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 238 ,  1032 ,  2 ,  2014-05-27 21:09:43 ,  PayAnyBizDB ,  1 ,  18 ,   ,  0.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 239 ,  1033 ,  2 ,  2014-05-27 21:09:43 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 240 ,  1033 ,  2 ,  2014-05-27 21:09:43 ,  PayAnyBizDB ,  1 ,  18 ,   ,  0.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 241 ,  762 ,  2 ,  2014-05-27 21:12:51 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 242 ,  733 ,  2 ,  2014-05-28 09:14:15 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 243 ,  713 ,  2 ,  2014-05-28 09:22:28 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 244 ,  593 ,  2 ,  2014-05-28 09:27:51 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 245 ,  593 ,  2 ,  2014-05-28 09:27:51 ,  PayAnyBizDB ,  1 ,  18 ,   ,  0.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 246 ,  614 ,  2 ,  2014-05-28 09:27:51 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 247 ,  614 ,  2 ,  2014-05-28 09:27:51 ,  PayAnyBizDB ,  1 ,  18 ,   ,  0.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 248 ,  758 ,  2 ,  2014-05-28 09:37:06 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 249 ,  758 ,  2 ,  2014-05-28 09:37:50 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 250 ,  592 ,  2 ,  2014-05-28 09:41:31 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 251 ,  593 ,  2 ,  2014-05-28 09:41:31 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 252 ,  614 ,  2 ,  2014-05-28 09:41:31 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 253 ,  569 ,  2 ,  2014-05-28 09:43:08 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 254 ,  548 ,  2 ,  2014-05-28 16:31:42 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 255 ,  548 ,  2 ,  2014-05-28 16:31:42 ,  PayAnyBizDB ,  1 ,  18 ,   ,  357.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 256 ,  550 ,  2 ,  2014-05-28 16:31:42 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 257 ,  550 ,  2 ,  2014-05-28 16:31:42 ,  PayAnyBizDB ,  1 ,  18 ,   ,  139.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 258 ,  553 ,  2 ,  2014-05-28 16:31:42 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 259 ,  553 ,  2 ,  2014-05-28 16:31:42 ,  PayAnyBizDB ,  1 ,  18 ,   ,  76.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 260 ,  754 ,  1 ,  2014-05-29 09:09:45 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Inv387364IMG_5003.PNG , null);
INSERT INTO   transactionsaudits   VALUES ( 261 ,  754 ,  1 ,  2014-05-29 11:31:27 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Inv387364IMG_5003.PNG , null);
INSERT INTO   transactionsaudits   VALUES ( 262 ,  754 ,  1 ,  2014-05-29 11:46:55 ,  PayAnyBizDB ,  1 ,  92 ,   ,  dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddIMG_5002.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 263 ,  754 ,  1 ,  2014-05-29 11:47:33 ,  PayAnyBizDB ,  1 ,  92 ,   ,  IMG_5010.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 264 ,  754 ,  1 ,  2014-05-29 11:48:11 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL InfoIMG_5014.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 265 ,  1042 ,  1 ,  2014-05-29 12:26:50 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 266 ,  1042 ,  1 ,  2014-05-29 12:28:44 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOLIMG_5001.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 267 ,  1042 ,  1 ,  2014-05-29 12:29:34 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL MAEU4367384IMG_5001.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 268 ,  726 ,  1 ,  2014-05-30 16:07:48 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Shipping Label6.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 269 ,  754 ,  1 ,  2014-05-31 14:43:53 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV6969696.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 270 ,  754 ,  2 ,  2014-05-31 14:44:59 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 271 ,  754 ,  2 ,  2014-05-31 14:45:30 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 272 ,  748 ,  2 ,  2014-05-31 14:51:56 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 273 ,  748 ,  2 ,  2014-05-31 14:51:56 ,  PayAnyBizDB ,  1 ,  18 ,   ,  217.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 274 ,  538 ,  2 ,  2014-05-31 14:53:43 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 275 ,  538 ,  2 ,  2014-05-31 14:53:43 ,  PayAnyBizDB ,  1 ,  18 ,   ,  0.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 276 ,  561 ,  2 ,  2014-05-31 14:53:43 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 277 ,  561 ,  2 ,  2014-05-31 14:53:43 ,  PayAnyBizDB ,  1 ,  18 ,   ,  0.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 278 ,  581 ,  2 ,  2014-05-31 14:53:43 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 279 ,  581 ,  2 ,  2014-05-31 14:53:43 ,  PayAnyBizDB ,  1 ,  18 ,   ,  0.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 280 ,  520 ,  2 ,  2014-06-03 18:48:16 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 281 ,  1042 ,  2 ,  2014-06-03 19:12:54 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 282 ,  722 ,  1 ,  2014-06-04 13:17:48 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL 48848394Copy of Pay Cargo EDI Agreements.xlsx , null);
INSERT INTO   transactionsaudits   VALUES ( 283 ,  722 ,  2 ,  2014-06-04 13:18:45 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 284 ,  1043 ,  1 ,  2014-06-04 13:31:30 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 285 ,  1043 ,  2 ,  2014-06-04 13:31:59 ,  PayAnyBizDB ,  1 ,  4 ,  54354 ,  543547 , null);
INSERT INTO   transactionsaudits   VALUES ( 286 ,  1043 ,  1 ,  2014-06-04 13:40:21 ,  PayAnyBizDB ,  1 ,  92 ,   ,  in6543Copy of Pay Cargo EDI Agreements.xlsx , null);
INSERT INTO   transactionsaudits   VALUES ( 287 ,  1043 ,  2 ,  2014-06-04 13:42:23 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 288 ,  1043 ,  2 ,  2014-06-04 13:42:45 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 289 ,  488 ,  2 ,  2014-06-04 13:45:47 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 290 ,  502 ,  2 ,  2014-06-04 13:45:47 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 291 ,  524 ,  2 ,  2014-06-04 13:45:47 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 292 ,  632 ,  2 ,  2014-06-05 11:15:06 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 293 ,  454 ,  2 ,  2014-06-05 11:37:50 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 294 ,  454 ,  2 ,  2014-06-05 11:37:50 ,  PayAnyBizDB ,  1 ,  18 ,   ,  100.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 295 ,  486 ,  2 ,  2014-06-05 11:37:50 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 296 ,  486 ,  2 ,  2014-06-05 11:37:50 ,  PayAnyBizDB ,  1 ,  18 ,   ,  836.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 297 ,  700 ,  2 ,  2014-06-06 09:46:38 ,  PayAnyBizDB ,  1 ,  1 ,  2 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 298 ,  700 ,  2 ,  2014-06-06 09:46:38 ,  PayAnyBizDB ,  1 ,  4 ,  Y3EEINMYE3RZGEB ,  Y3EEINMYE3RZGEB-1 , null);
INSERT INTO   transactionsaudits   VALUES ( 299 ,  700 ,  2 ,  2014-06-06 09:48:14 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 300 ,  700 ,  2 ,  2014-06-06 09:48:34 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 301 ,  716 ,  2 ,  2014-06-06 09:49:51 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 302 ,  716 ,  2 ,  2014-06-06 09:49:51 ,  PayAnyBizDB ,  1 ,  18 ,   ,  -100.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 306 ,  673 ,  1 ,  2014-06-07 08:42:03 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Inv456789angular-mocks.js.html , null);
INSERT INTO   transactionsaudits   VALUES ( 307 ,  673 ,  1 ,  2014-06-07 08:42:27 ,  PayAnyBizDB ,  1 ,  92 ,   ,  67890photo_3-6.JPG.html , null);
INSERT INTO   transactionsaudits   VALUES ( 308 ,  734 ,  1 ,  2014-06-09 18:45:38 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL567898058.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 309 ,  734 ,  1 ,  2014-06-09 18:46:03 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV5467890Gabby Science Fair Project 2011.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 310 ,  734 ,  1 ,  2014-06-09 18:46:36 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL567898058.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 311 ,  734 ,  1 ,  2014-06-09 18:46:40 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL567898058.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 312 ,  734 ,  3 ,  2014-06-09 18:46:59 ,  PayAnyBizDB ,  1 ,  91 ,  BOL567898058.JPG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 313 ,  734 ,  2 ,  2014-06-09 18:48:10 ,  PayAnyBizDB ,  1 ,  4 ,  HXA2FQEU3YAPFAZ ,  HXA2FQEU3YAPFAZZ , null);
INSERT INTO   transactionsaudits   VALUES ( 314 ,  634 ,  2 ,  2014-06-09 18:51:36 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 315 ,  634 ,  2 ,  2014-06-09 18:51:48 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 316 ,  1029 ,  1 ,  2014-06-10 04:25:15 ,  PayAnyBizDB ,  1 ,  90 ,   ,  InvoicePicture 055.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 317 ,  1029 ,  1 ,  2014-06-10 04:25:17 ,  PayAnyBizDB ,  1 ,  90 ,   ,  InvoicePicture 055.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 318 ,  300 ,  1 ,  2014-06-10 06:38:58 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678IMG_5002.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 319 ,  726 ,  1 ,  2014-06-10 07:03:22 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Shipping Label6.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 320 ,  726 ,  1 ,  2014-06-10 07:03:24 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Shipping Label6.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 321 ,  726 ,  1 ,  2014-06-10 07:05:20 ,  PayAnyBizDB ,  1 ,  90 ,   ,  attachmentIMG_5001.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 322 ,  648 ,  1 ,  2014-06-10 08:14:05 ,  PayAnyBizDB ,  1 ,  90 ,   ,  IMG_5001.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 323 ,  648 ,  1 ,  2014-06-10 08:14:06 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL56789IMG_5001.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 324 ,  1029 ,  1 ,  2014-06-16 18:33:09 ,  PayAnyBizDB ,  1 ,  90 ,   ,  InvoicePicture 055.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 325 ,  1029 ,  1 ,  2014-06-16 18:33:10 ,  PayAnyBizDB ,  1 ,  90 ,   ,  InvoicePicture 055.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 326 ,  1034 ,  1 ,  2014-06-16 18:36:27 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Gruntfile.js , null);
INSERT INTO   transactionsaudits   VALUES ( 327 ,  1034 ,  1 ,  2014-06-16 18:36:27 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Gruntfile.js , null);
INSERT INTO   transactionsaudits   VALUES ( 328 ,  1034 ,  3 ,  2014-06-16 18:36:52 ,  PayAnyBizDB ,  1 ,  93 ,  Gruntfile.js ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 329 ,  1034 ,  3 ,  2014-06-16 18:36:56 ,  PayAnyBizDB ,  1 ,  93 ,  Gruntfile.js ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 330 ,  1034 ,  1 ,  2014-06-16 18:37:00 ,  PayAnyBizDB ,  1 ,  92 ,   ,  trtGruntfile.js , null);
INSERT INTO   transactionsaudits   VALUES ( 331 ,  1034 ,  1 ,  2014-06-16 18:37:00 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Gruntfile.js , null);
INSERT INTO   transactionsaudits   VALUES ( 332 ,  1034 ,  3 ,  2014-06-16 18:37:08 ,  PayAnyBizDB ,  1 ,  93 ,  trtGruntfile.js ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 333 ,  1034 ,  3 ,  2014-06-16 18:37:11 ,  PayAnyBizDB ,  1 ,  93 ,  Gruntfile.js ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 334 ,  1034 ,  1 ,  2014-06-16 18:37:19 ,  PayAnyBizDB ,  1 ,  92 ,   ,  jquery-1.9.1.js , null);
INSERT INTO   transactionsaudits   VALUES ( 335 ,  1034 ,  1 ,  2014-06-16 18:37:20 ,  PayAnyBizDB ,  1 ,  92 ,   ,  jquery-1.9.1.js , null);
INSERT INTO   transactionsaudits   VALUES ( 336 ,  1034 ,  3 ,  2014-06-16 18:37:29 ,  PayAnyBizDB ,  1 ,  93 ,  jquery-1.9.1.js ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 337 ,  1034 ,  3 ,  2014-06-16 18:37:32 ,  PayAnyBizDB ,  1 ,  93 ,  jquery-1.9.1.js ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 338 ,  1034 ,  1 ,  2014-06-16 18:38:41 ,  PayAnyBizDB ,  1 ,  92 ,   ,  AUTHORS.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 339 ,  1034 ,  1 ,  2014-06-16 18:38:41 ,  PayAnyBizDB ,  1 ,  92 ,   ,  AUTHORS.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 340 ,  1034 ,  1 ,  2014-06-16 18:38:41 ,  PayAnyBizDB ,  1 ,  92 ,   ,  AUTHORS.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 341 ,  1034 ,  3 ,  2014-06-16 18:38:47 ,  PayAnyBizDB ,  1 ,  93 ,  AUTHORS.txt ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 342 ,  1034 ,  3 ,  2014-06-16 18:38:50 ,  PayAnyBizDB ,  1 ,  93 ,  AUTHORS.txt ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 343 ,  1034 ,  3 ,  2014-06-16 18:38:53 ,  PayAnyBizDB ,  1 ,  93 ,  AUTHORS.txt ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 344 ,  1034 ,  1 ,  2014-06-16 18:39:20 ,  PayAnyBizDB ,  1 ,  92 ,   ,  AUTHORS.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 345 ,  1034 ,  1 ,  2014-06-16 18:39:20 ,  PayAnyBizDB ,  1 ,  92 ,   ,  AUTHORS.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 346 ,  1034 ,  1 ,  2014-06-16 18:39:20 ,  PayAnyBizDB ,  1 ,  92 ,   ,  AUTHORS.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 347 ,  1034 ,  1 ,  2014-06-16 18:39:20 ,  PayAnyBizDB ,  1 ,  92 ,   ,  AUTHORS.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 348 ,  1034 ,  1 ,  2014-06-16 18:39:21 ,  PayAnyBizDB ,  1 ,  92 ,   ,  AUTHORS.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 349 ,  1034 ,  1 ,  2014-06-16 18:39:52 ,  PayAnyBizDB ,  1 ,  92 ,   ,  ui.droppable.jquery.json , null);
INSERT INTO   transactionsaudits   VALUES ( 350 ,  1034 ,  1 ,  2014-06-16 18:39:52 ,  PayAnyBizDB ,  1 ,  92 ,   ,  ui.droppable.jquery.json , null);
INSERT INTO   transactionsaudits   VALUES ( 351 ,  1034 ,  1 ,  2014-06-16 18:39:52 ,  PayAnyBizDB ,  1 ,  92 ,   ,  ui.droppable.jquery.json , null);
INSERT INTO   transactionsaudits   VALUES ( 352 ,  1034 ,  1 ,  2014-06-16 18:39:52 ,  PayAnyBizDB ,  1 ,  92 ,   ,  ui.droppable.jquery.json , null);
INSERT INTO   transactionsaudits   VALUES ( 353 ,  1034 ,  1 ,  2014-06-16 18:39:52 ,  PayAnyBizDB ,  1 ,  92 ,   ,  ui.droppable.jquery.json , null);
INSERT INTO   transactionsaudits   VALUES ( 354 ,  1034 ,  1 ,  2014-06-16 18:39:52 ,  PayAnyBizDB ,  1 ,  92 ,   ,  ui.droppable.jquery.json , null);
INSERT INTO   transactionsaudits   VALUES ( 355 ,  1034 ,  1 ,  2014-06-16 18:39:52 ,  PayAnyBizDB ,  1 ,  92 ,   ,  ui.droppable.jquery.json , null);
INSERT INTO   transactionsaudits   VALUES ( 356 ,  1034 ,  3 ,  2014-06-16 18:40:17 ,  PayAnyBizDB ,  1 ,  93 ,  ui.droppable.jquery.json ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 357 ,  1034 ,  3 ,  2014-06-16 18:40:20 ,  PayAnyBizDB ,  1 ,  93 ,  ui.droppable.jquery.json ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 358 ,  1034 ,  3 ,  2014-06-16 18:40:23 ,  PayAnyBizDB ,  1 ,  93 ,  ui.droppable.jquery.json ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 359 ,  1034 ,  3 ,  2014-06-16 18:40:25 ,  PayAnyBizDB ,  1 ,  93 ,  ui.droppable.jquery.json ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 360 ,  1034 ,  3 ,  2014-06-16 18:40:28 ,  PayAnyBizDB ,  1 ,  93 ,  ui.droppable.jquery.json ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 361 ,  1034 ,  3 ,  2014-06-16 18:40:31 ,  PayAnyBizDB ,  1 ,  93 ,  ui.droppable.jquery.json ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 362 ,  1034 ,  3 ,  2014-06-16 18:40:34 ,  PayAnyBizDB ,  1 ,  93 ,  ui.droppable.jquery.json ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 363 ,  1034 ,  3 ,  2014-06-16 18:40:37 ,  PayAnyBizDB ,  1 ,  93 ,  AUTHORS.txt ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 364 ,  1034 ,  3 ,  2014-06-16 18:40:40 ,  PayAnyBizDB ,  1 ,  93 ,  AUTHORS.txt ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 365 ,  1034 ,  3 ,  2014-06-16 18:40:42 ,  PayAnyBizDB ,  1 ,  93 ,  AUTHORS.txt ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 366 ,  1034 ,  3 ,  2014-06-16 18:40:45 ,  PayAnyBizDB ,  1 ,  93 ,  AUTHORS.txt ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 367 ,  1034 ,  3 ,  2014-06-16 18:40:48 ,  PayAnyBizDB ,  1 ,  93 ,  AUTHORS.txt ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 368 ,  1034 ,  1 ,  2014-06-16 18:42:14 ,  PayAnyBizDB ,  1 ,  92 ,   ,  README.md , null);
INSERT INTO   transactionsaudits   VALUES ( 369 ,  1034 ,  1 ,  2014-06-16 18:42:14 ,  PayAnyBizDB ,  1 ,  92 ,   ,  README.md , null);
INSERT INTO   transactionsaudits   VALUES ( 370 ,  1034 ,  3 ,  2014-06-16 18:42:39 ,  PayAnyBizDB ,  1 ,  93 ,  README.md ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 371 ,  1034 ,  3 ,  2014-06-16 18:42:42 ,  PayAnyBizDB ,  1 ,  93 ,  README.md ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 372 ,  840 ,  2 ,  2014-06-17 13:16:02 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 373 ,  1030 ,  1 ,  2014-06-17 16:56:44 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOLOwl-Cupcake-Toppers-from-Too-Much-Time-On-My-Hands.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 374 ,  1028 ,  1 ,  2014-06-17 16:57:35 ,  PayAnyBizDB ,  1 ,  92 ,   ,  inv5678Teacher_Appreciation_Week_2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 375 ,  1028 ,  1 ,  2014-06-17 16:57:39 ,  PayAnyBizDB ,  1 ,  92 ,   ,  inv5678Teacher_Appreciation_Week_2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 376 ,  432 ,  2 ,  2014-06-17 17:01:39 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 377 ,  432 ,  2 ,  2014-06-17 17:01:39 ,  PayAnyBizDB ,  1 ,  18 ,   ,  0.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 378 ,  436 ,  2 ,  2014-06-17 17:01:39 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 379 ,  436 ,  2 ,  2014-06-17 17:01:39 ,  PayAnyBizDB ,  1 ,  18 ,   ,  0.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 380 ,  1028 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  inv5678Teacher_Appreciation_Week_2014.docx ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 381 ,  1030 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  BOLOwl-Cupcake-Toppers-from-Too-Much-Time-On-My-Hands.jpg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 382 ,  648 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  BOL56789IMG_5001.JPG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 383 ,  648 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  IMG_5001.JPG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 384 ,  726 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  attachmentIMG_5001.JPG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 385 ,  300 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  BOL45678IMG_5002.JPG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 386 ,  734 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  INV5467890Gabby Science Fair Project 2011.docx ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 387 ,  673 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  67890photo_3-6.JPG.html ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 388 ,  673 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  Inv456789angular-mocks.js.html ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 389 ,  1043 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  in6543Copy of Pay Cargo EDI Agreements.xlsx ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 390 ,  722 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  BOL 48848394Copy of Pay Cargo EDI Agreements.xlsx ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 391 ,  754 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  INV6969696.jpg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 392 ,  726 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  Shipping Label6.jpg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 393 ,  1042 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  BOL MAEU4367384IMG_5001.JPG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 394 ,  1042 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  BOLIMG_5001.JPG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 395 ,  754 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  BOL InfoIMG_5014.JPG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 396 ,  754 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  IMG_5010.JPG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 397 ,  754 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddIMG_5002.JPG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 398 ,  754 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  Inv387364IMG_5003.PNG ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 399 ,  1029 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  InvoicePicture 055.jpg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 400 ,  762 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  bolPicture 054.jpg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 401 ,  741 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  INV47384photo_3-6.JPG.html ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 402 ,  1033 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  BOLPicture 058.jpg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 403 ,  1031 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  91 ,  test img20140419_103102 (1) (1) (1) (1).jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 404 ,  1034 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  test pdf1-html5-line-of-business-applications-m1-sl_id es (1).pdf ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 405 ,  1034 ,  3 ,  2014-06-17 19:59:26 ,  PayAnyBizDB ,  1 ,  93 ,  test img20140419_103102 (1) (1) (1).jpeg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 406 ,  1034 ,  1 ,  2014-06-17 20:09:13 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test1Test Document.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 407 ,  1028 ,  1 ,  2014-06-17 20:10:18 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test2Test Document.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 408 ,  1034 ,  1 ,  2014-06-17 20:10:33 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test1Test Document.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 409 ,  1034 ,  1 ,  2014-06-17 20:10:34 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test1Test Document.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 410 ,  1034 ,  1 ,  2014-06-18 13:40:47 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test1Test Document.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 411 ,  809 ,  1 ,  2014-06-18 13:42:00 ,  PayAnyBizDB ,  1 ,  90 ,   ,  bolIMG_5002.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 412 ,  1030 ,  1 ,  2014-06-18 13:44:04 ,  PayAnyBizDB ,  1 ,  90 ,   ,  ertfgIMG_5010.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 413 ,  645 ,  2 ,  2014-06-20 05:34:52 ,  PayAnyBizDB ,  1 ,  3 ,  ULNF0FYRRODELJR ,  ULNF0FYRRODELJR1 , null);
INSERT INTO   transactionsaudits   VALUES ( 414 ,  809 ,  1 ,  2014-06-20 05:40:14 ,  PayAnyBizDB ,  1 ,  90 ,   ,  bolIMG_5002.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 415 ,  1043 ,  1 ,  2014-06-26 19:25:51 ,  PayAnyBizDB ,  1 ,  92 ,   ,  tettLapeyreStyle_businesscard_hand.png , null);
INSERT INTO   transactionsaudits   VALUES ( 416 ,  809 ,  1 ,  2014-06-30 07:18:41 ,  PayAnyBizDB ,  1 ,  90 ,   ,  Advance Search Error.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 417 ,  809 ,  1 ,  2014-06-30 07:18:41 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOLAdvance Search Error.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 418 ,  809 ,  1 ,  2014-06-30 07:18:48 ,  PayAnyBizDB ,  1 ,  90 ,   ,  Advance Search Error.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 419 ,  809 ,  1 ,  2014-06-30 07:18:50 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOLAdvance Search Error.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 420 ,  1044 ,  1 ,  2014-06-30 07:30:01 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 421 ,  1044 ,  1 ,  2014-06-30 17:41:27 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 422 ,  1031 ,  1 ,  2014-06-30 17:46:18 ,  PayAnyBizDB ,  1 ,  90 ,   ,  invPayAnyBiz Executive Summary June.pdf , null);
INSERT INTO   transactionsaudits   VALUES ( 423 ,  809 ,  1 ,  2014-07-01 19:28:46 ,  PayAnyBizDB ,  1 ,  90 ,   ,  bolIMG_5002.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 424 ,  1029 ,  1 ,  2014-07-01 19:37:44 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOLDispute transactions Details Edits.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 425 ,  734 ,  1 ,  2014-07-02 07:23:52 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL456789PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 426 ,  1028 ,  1 ,  2014-07-02 07:28:59 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV456789NACHA File Layout (Word document).doc , null);
INSERT INTO   transactionsaudits   VALUES ( 427 ,  1042 ,  1 ,  2014-07-03 07:27:31 ,  PayAnyBizDB ,  1 ,  90 ,   ,  proof of delieveryNACHA File Layout (Excel document).xls , null);
INSERT INTO   transactionsaudits   VALUES ( 428 ,  1033 ,  1 ,  2014-07-03 07:45:12 ,  PayAnyBizDB ,  1 ,  92 ,   ,  inv5678PayAnyBiz Executive Summary June.pdf , null);
INSERT INTO   transactionsaudits   VALUES ( 429 ,  1031 ,  1 ,  2014-07-05 19:21:40 ,  PayAnyBizDB ,  1 ,  90 ,   ,  invPayAnyBiz Executive Summary June.pdf , null);
INSERT INTO   transactionsaudits   VALUES ( 430 ,  1030 ,  1 ,  2014-07-05 19:24:14 ,  PayAnyBizDB ,  1 ,  90 ,   ,  ertfgIMG_5010.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 431 ,  1028 ,  1 ,  2014-07-05 19:24:25 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV456789NACHA File Layout (Word document).doc , null);
INSERT INTO   transactionsaudits   VALUES ( 432 ,  1044 ,  1 ,  2014-07-05 19:41:31 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 433 ,  1028 ,  1 ,  2014-07-05 19:42:55 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test2Test Document.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 434 ,  1034 ,  1 ,  2014-07-05 19:48:33 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test1Test Document.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 435 ,  1044 ,  1 ,  2014-07-05 19:49:25 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 436 ,  1044 ,  1 ,  2014-07-05 19:54:25 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 437 ,  1044 ,  1 ,  2014-07-05 20:05:14 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 438 ,  1030 ,  1 ,  2014-07-05 20:13:04 ,  PayAnyBizDB ,  1 ,  90 ,   ,  ertfgIMG_5010.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 439 ,  1044 ,  1 ,  2014-07-05 20:16:24 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 440 ,  1044 ,  1 ,  2014-07-05 20:16:36 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 441 ,  1044 ,  1 ,  2014-07-05 20:20:01 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 442 ,  1044 ,  1 ,  2014-07-05 20:20:23 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 443 ,  1044 ,  1 ,  2014-07-05 20:20:28 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 444 ,  1044 ,  1 ,  2014-07-05 20:20:35 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 445 ,  1044 ,  2 ,  2014-07-06 13:48:33 ,  PayAnyBizDB ,  1 ,  12 ,  4,500.00 ,  4,100.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 446 ,  1044 ,  1 ,  2014-07-06 13:53:24 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 447 ,  1044 ,  2 ,  2014-07-06 15:15:51 ,  PayAnyBizDB ,  1 ,  4 , null,  55555 , null);
INSERT INTO   transactionsaudits   VALUES ( 448 ,  1044 ,  1 ,  2014-07-06 18:49:49 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 449 ,  1044 ,  1 ,  2014-07-06 18:49:55 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL45678PayAnyBiz Brief Summary June 2014.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 450 ,  734 ,  2 ,  2014-07-08 08:54:13 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 451 ,  734 ,  2 ,  2014-07-08 09:03:39 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 452 ,  1045 ,  1 ,  2014-07-08 09:39:46 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 453 ,  1046 ,  1 ,  2014-07-08 09:42:37 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 454 ,  1043 ,  1 ,  2014-07-08 12:19:28 ,  PayAnyBizDB ,  1 ,  92 ,   ,  tettLapeyreStyle_businesscard_hand.png , null);
INSERT INTO   transactionsaudits   VALUES ( 455 ,  1043 ,  1 ,  2014-07-08 12:19:31 ,  PayAnyBizDB ,  1 ,  92 ,   ,  tettLapeyreStyle_businesscard_hand.png , null);
INSERT INTO   transactionsaudits   VALUES ( 456 ,  1043 ,  1 ,  2014-07-08 12:19:35 ,  PayAnyBizDB ,  1 ,  92 ,   ,  tettLapeyreStyle_businesscard_hand.png , null);
INSERT INTO   transactionsaudits   VALUES ( 457 ,  1043 ,  1 ,  2014-07-08 12:19:36 ,  PayAnyBizDB ,  1 ,  92 ,   ,  tettLapeyreStyle_businesscard_hand.png , null);
INSERT INTO   transactionsaudits   VALUES ( 458 ,  1046 ,  1 ,  2014-07-08 12:54:15 ,  PayAnyBizDB ,  1 ,  92 ,   ,  fffffBusiness-Neg-Cios-Dr-S-A-548917.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 459 ,  1046 ,  1 ,  2014-07-08 12:55:57 ,  PayAnyBizDB ,  1 ,  92 ,   ,  rrrrrBusiness-Neg-Cios-Dr-S-A-548917.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 460 ,  1046 ,  3 ,  2014-07-08 12:56:21 ,  PayAnyBizDB ,  1 ,  93 ,  rrrrrBusiness-Neg-Cios-Dr-S-A-548917.jpg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 461 ,  1046 ,  3 ,  2014-07-08 12:56:29 ,  PayAnyBizDB ,  1 ,  93 ,  fffffBusiness-Neg-Cios-Dr-S-A-548917.jpg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 462 ,  1046 ,  1 ,  2014-07-08 12:58:31 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Business-Neg-Cios-Dr-S-A-548917.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 463 ,  1046 ,  1 ,  2014-07-08 15:15:59 ,  PayAnyBizDB ,  1 ,  92 ,   ,  dddddBusiness-Neg-Cios-Dr-S-A-548917.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 464 ,  1047 ,  1 ,  2014-07-08 21:39:37 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 465 ,  645 ,  2 ,  2014-07-09 07:37:18 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 466 ,  1034 ,  1 ,  2014-07-09 20:44:37 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test1Test Document.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 467 ,  1046 ,  2 ,  2014-07-10 21:13:45 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 468 ,  1046 ,  2 ,  2014-07-10 21:13:45 ,  PayAnyBizDB ,  1 ,  18 ,   ,  530.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 469 ,  1047 ,  2 ,  2014-07-13 19:21:51 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 470 ,  1047 ,  2 ,  2014-07-13 19:21:51 ,  PayAnyBizDB ,  1 ,  18 ,   ,  5,821.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 471 ,  658 ,  2 ,  2014-07-14 07:09:21 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 472 ,  248 ,  2 ,  2014-07-14 21:45:21 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 473 ,  249 ,  2 ,  2014-07-14 21:45:21 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 474 ,  1045 ,  2 ,  2014-07-14 21:50:54 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 475 ,  9 ,  2 ,  2014-07-15 11:26:14 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 476 ,  9 ,  2 ,  2014-07-15 11:26:23 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 477 ,  528 ,  2 ,  2014-07-15 11:27:55 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 478 ,  1030 ,  1 ,  2014-07-15 18:34:20 ,  PayAnyBizDB ,  1 ,  90 ,   ,  ertfgIMG_5010.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 479 ,  1030 ,  1 ,  2014-07-15 18:34:27 ,  PayAnyBizDB ,  1 ,  90 ,   ,  ertfgIMG_5010.JPG , null);
INSERT INTO   transactionsaudits   VALUES ( 480 ,  1044 ,  2 ,  2014-07-17 05:59:25 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 481 ,  1044 ,  2 ,  2014-07-17 05:59:41 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 482 ,  1029 ,  2 ,  2014-07-21 19:56:04 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 483 ,  1045 ,  2 ,  2014-07-21 20:02:05 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 484 ,  1030 ,  2 ,  2014-07-21 20:03:36 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 485 ,  298 ,  2 ,  2014-07-21 20:16:46 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 486 ,  1034 ,  2 ,  2014-07-24 20:28:19 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 487 ,  1034 ,  2 ,  2014-07-24 20:28:19 ,  PayAnyBizDB ,  1 ,  18 ,   ,  5,334.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 488 ,  1031 ,  2 ,  2014-07-24 21:10:09 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 489 ,  1053 ,  1 ,  2014-07-29 09:53:20 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 490 ,  1053 ,  2 ,  2014-07-29 09:55:25 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 491 ,  673 ,  2 ,  2014-07-31 17:47:09 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 492 ,  1002 ,  2 ,  2014-08-07 19:11:28 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 493 ,  1002 ,  2 ,  2014-08-07 19:11:28 ,  PayAnyBizDB ,  1 ,  18 ,   ,  0.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 494 ,  1027 ,  2 ,  2014-08-07 19:30:41 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 495 ,  1027 ,  2 ,  2014-08-07 19:30:41 ,  PayAnyBizDB ,  1 ,  18 ,   ,  233.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 496 ,  1056 ,  1 ,  2014-08-07 19:35:26 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 497 ,  1056 ,  2 ,  2014-08-07 19:35:42 ,  PayAnyBizDB ,  1 ,  10 , null,  2014-08-13 04:00:00 , null);
INSERT INTO   transactionsaudits   VALUES ( 498 ,  1057 ,  1 ,  2014-08-07 20:39:18 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 499 ,  1046 ,  1 ,  2014-08-07 20:40:20 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Test123Test Document (1).txt , null);
INSERT INTO   transactionsaudits   VALUES ( 500 ,  1058 ,  1 ,  2014-08-07 20:41:37 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 501 ,  1059 ,  1 ,  2014-08-07 20:42:29 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 502 ,  1059 ,  2 ,  2014-08-07 20:43:18 ,  PayAnyBizDB ,  1 ,  1 ,  2 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 503 ,  1060 ,  1 ,  2014-08-07 20:43:57 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 504 ,  1056 ,  1 ,  2014-08-07 21:52:44 ,  PayAnyBizDB ,  1 ,  94 ,   ,  vcbcvbcvbBusiness-Neg-Cios-Dr-S-A-548917.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 505 ,  1056 ,  1 ,  2014-08-07 21:52:51 ,  PayAnyBizDB ,  1 ,  94 ,   ,  vcbcvbcvbBusiness-Neg-Cios-Dr-S-A-548917.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 506 ,  1026 ,  2 ,  2014-08-07 22:06:50 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 507 ,  1032 ,  2 ,  2014-08-07 22:06:50 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 508 ,  1033 ,  2 ,  2014-08-07 22:06:50 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 , null);
INSERT INTO   transactionsaudits   VALUES ( 509 ,  1057 ,  1 ,  2014-08-07 22:20:01 ,  PayAnyBizDB ,  1 ,  90 ,   ,  test08082014glyphicons-halflings-regular.eot , null);
INSERT INTO   transactionsaudits   VALUES ( 510 ,  1057 ,  1 ,  2014-08-07 22:20:16 ,  PayAnyBizDB ,  1 ,  90 ,   ,  test08082014glyphicons-halflings-regular.eot , null);
INSERT INTO   transactionsaudits   VALUES ( 511 ,  1057 ,  1 ,  2014-08-07 22:21:26 ,  PayAnyBizDB ,  1 ,  90 ,   ,  test08082014glyphicons-halflings-regular.eot , null);
INSERT INTO   transactionsaudits   VALUES ( 512 ,  1057 ,  1 ,  2014-08-07 22:22:16 ,  PayAnyBizDB ,  1 ,  90 ,   ,  2222glyphicons-halflings-regular.woff , null);
INSERT INTO   transactionsaudits   VALUES ( 513 ,  1057 ,  1 ,  2014-08-07 22:22:23 ,  PayAnyBizDB ,  1 ,  90 ,   ,  2222glyphicons-halflings-regular.woff , null);
INSERT INTO   transactionsaudits   VALUES ( 514 ,  1058 ,  1 ,  2014-08-09 20:24:42 ,  PayAnyBizDB ,  1 ,  92 ,   ,  inv789Issue Found in PayAnyBiz.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 515 ,  1058 ,  1 ,  2014-08-09 20:36:57 ,  PayAnyBizDB ,  1 ,  90 ,   ,  MAEU5784358NACHA File Layout (Excel document).xls , null);
INSERT INTO   transactionsaudits   VALUES ( 516 ,  1026 ,  1 ,  2014-08-10 20:04:10 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Inv5645444image.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 517 ,  297 ,  1 ,  2014-08-10 21:47:30 ,  PayAnyBizDB ,  1 ,  90 ,   ,  ttttt08-11-2014Test Document.txt , null);
INSERT INTO   transactionsaudits   VALUES ( 518 ,  485 ,  2 ,  2014-08-10 21:48:39 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 519 ,  485 ,  2 ,  2014-08-10 21:48:39 ,  PayAnyBizDB ,  1 ,  18 ,   ,  -3.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 520 ,  534 ,  2 ,  2014-08-10 21:48:39 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 521 ,  534 ,  2 ,  2014-08-10 21:48:39 ,  PayAnyBizDB ,  1 ,  18 ,   ,  716.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 522 ,  300 ,  1 ,  2014-08-11 08:39:15 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL65833112COLT-GMS Mutual NDA NCA generic.doc , null);
INSERT INTO   transactionsaudits   VALUES ( 523 ,  1060 ,  1 ,  2014-08-11 08:44:42 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV737382PayAnyBiz Executive Summary August.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 524 ,  1060 ,  1 ,  2014-08-11 08:46:10 ,  PayAnyBizDB ,  1 ,  92 ,   ,  POD7382092NACHA File Layout (Excel document).xls , null);
INSERT INTO   transactionsaudits   VALUES ( 525 ,  640 ,  2 ,  2014-08-11 08:47:14 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 526 ,  1047 ,  1 ,  2014-08-11 09:19:33 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOLPayAnyBiz Executive Summary August.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 527 ,  1061 ,  1 ,  2014-08-11 19:09:18 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 528 ,  1065 ,  1 ,  2014-08-11 19:26:55 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 529 ,  726 ,  1 ,  2014-08-12 06:12:00 ,  PayAnyBizDB ,  1 ,  90 ,   ,  logo info.docx , null);
INSERT INTO   transactionsaudits   VALUES ( 530 ,  726 ,  1 ,  2014-08-12 06:13:12 ,  PayAnyBizDB ,  1 ,  96 ,   ,  Proof of delieveryCommercial Property Loan Application.xls , null);
INSERT INTO   transactionsaudits   VALUES ( 531 ,  726 ,  1 ,  2014-08-12 06:14:16 ,  PayAnyBizDB ,  1 ,  92 ,   ,  This is an invoice for this transactionsF4QCommercial Property Loan Application.xls , null);
INSERT INTO   transactionsaudits   VALUES ( 532 ,  726 ,  2 ,  2014-08-12 06:14:59 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 , null);
INSERT INTO   transactionsaudits   VALUES ( 533 ,  726 ,  2 ,  2014-08-12 06:14:59 ,  PayAnyBizDB ,  1 ,  18 ,   ,  200.00 , null);
INSERT INTO   transactionsaudits   VALUES ( 534 ,  726 ,  1 ,  2014-08-12 06:16:50 ,  PayAnyBizDB ,  1 ,  90 ,   ,  Proof for waiting time docCopy of PayAnyBiz 4 year financial model-Final.xlsx , null);
INSERT INTO   transactionsaudits   VALUES ( 535 ,  1066 ,  1 ,  2014-08-12 09:20:08 ,  PayAnyBizDB ,  1 ,  0 ,   ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 536 ,  1061 ,  1 ,  2014-08-12 11:13:56 ,  PayAnyBizDB ,  1 ,  90 ,   ,  Test08122014angular-dialog-service-master.zip , null);
INSERT INTO   transactionsaudits   VALUES ( 537 ,  1061 ,  3 ,  2014-08-12 11:14:04 ,  PayAnyBizDB ,  1 ,  91 ,  Test08122014angular-dialog-service-master.zip ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 538 ,  1043 ,  1 ,  2014-08-17 10:44:33 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test 8/17/2014stock-photo-27321186-global-business-team.jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 539 ,  1043 ,  3 ,  2014-08-17 10:44:44 ,  PayAnyBizDB ,  1 ,  93 ,  test 8/17/2014stock-photo-27321186-global-business-team.jpg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 540 ,  1066 ,  1 ,  2014-08-17 10:57:31 ,  PayAnyBizDB ,  1 ,  90 ,   ,  test 3 8/17/2014Business-Neg-Cios-Dr-S-A-548917 (1).jpg , null);
INSERT INTO   transactionsaudits   VALUES ( 541 ,  1066 ,  3 ,  2014-08-17 10:57:45 ,  PayAnyBizDB ,  1 ,  91 ,  test 3 8/17/2014Business-Neg-Cios-Dr-S-A-548917 (1).jpg ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 542 ,  1066 ,  1 ,  2014-08-17 10:59:37 ,  PayAnyBizDB ,  1 ,  90 ,   ,  322Test Document (1).txt , null);
INSERT INTO   transactionsaudits   VALUES ( 543 ,  1066 ,  3 ,  2014-08-17 10:59:46 ,  PayAnyBizDB ,  1 ,  91 ,  322Test Document (1).txt ,   , null);
INSERT INTO   transactionsaudits   VALUES ( 544 ,  1033 ,  2 ,  2014-08-17 11:12:01 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 , null);
INSERT INTO   transactionsaudits   VALUES ( 545 ,  648 ,  1 ,  2014-08-18 11:28:09 ,  PayAnyBizDB ,  1 ,  90 ,   ,  bolCopy of PayAnyBiz 4 year financial model April.xlsx ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 546 ,  1060 ,  2 ,  2014-08-18 11:32:36 ,  PayAnyBizDB ,  1 ,  13 , null,  Adding something on the description field\n ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 547 ,  1067 ,  1 ,  2014-08-18 11:38:35 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 548 ,  1068 ,  1 ,  2014-08-18 11:40:19 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 549 ,  1065 ,  2 ,  2014-08-22 05:04:55 ,  PayAnyBizDB ,  1 ,  15 ,  34534 ,  34534-112 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 550 ,  1065 ,  2 ,  2014-08-22 05:05:44 ,  PayAnyBizDB ,  1 ,  3 ,  634634 ,  634634-111 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 551 ,  1065 ,  2 ,  2014-08-22 05:05:44 ,  PayAnyBizDB ,  1 ,  4 ,  34534 ,  34534-111 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 552 ,  1065 ,  2 ,  2014-08-22 05:05:44 ,  PayAnyBizDB ,  1 ,  12 ,  435,345.00 ,  435,351.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 553 ,  1053 ,  1 ,  2014-08-26 05:16:02 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV56789A-1 SITE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 554 ,  1053 ,  1 ,  2014-08-26 05:16:19 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV56789A-1 SITE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 555 ,  1053 ,  1 ,  2014-08-26 05:16:23 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV56789A-1 SITE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 556 ,  1053 ,  1 ,  2014-08-26 05:17:27 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV56789A-1 SITE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 557 ,  1053 ,  1 ,  2014-08-26 05:17:34 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV56789A-1 SITE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 558 ,  1065 ,  1 ,  2014-08-26 09:31:54 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL4567890A-1 SITE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 559 ,  1065 ,  1 ,  2014-08-26 09:32:28 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL4567890A-1 SITE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 560 ,  1065 ,  2 ,  2014-08-26 09:37:10 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 561 ,  1065 ,  2 ,  2014-08-26 09:37:10 ,  PayAnyBizDB ,  1 ,  18 , null,  35,000.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 562 ,  1065 ,  1 ,  2014-08-26 09:37:10 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL4567890A-1 SITE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 563 ,  1065 ,  1 ,  2014-08-26 09:39:29 ,  PayAnyBizDB ,  1 ,  90 ,   ,  PODA-2 LANDSCAPE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 564 ,  1059 ,  1 ,  2014-08-26 16:19:32 ,  PayAnyBizDB ,  1 ,  92 ,   ,  A-1 SITE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 565 ,  1059 ,  1 ,  2014-08-26 16:19:57 ,  PayAnyBizDB ,  1 ,  92 ,   ,  A-1 SITE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 566 ,  1059 ,  1 ,  2014-08-26 16:20:02 ,  PayAnyBizDB ,  1 ,  92 ,   ,  A-1 SITE PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 567 ,  1067 ,  1 ,  2014-08-26 16:25:06 ,  PayAnyBizDB ,  1 ,  90 ,   ,  bol456789A-3 FLOOR PLAN.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 568 ,  1009 ,  1 ,  2014-08-26 17:14:56 ,  PayAnyBizDB ,  1 ,  90 ,   ,  hgjkA-5 ELEVATIONS.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 569 ,  1009 ,  2 ,  2014-08-26 17:15:54 ,  PayAnyBizDB ,  1 ,  3 ,  4WLVFWTZZ0ORXRY ,  4WLVFWTZZ0ORXRY-1 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 570 ,  633 ,  2 ,  2014-08-26 17:32:23 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 571 ,  633 ,  2 ,  2014-08-26 17:32:23 ,  PayAnyBizDB ,  1 ,  18 , null,  96.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 572 ,  1069 ,  1 ,  2014-08-26 18:03:16 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 573 ,  1047 ,  2 ,  2014-08-26 19:57:31 ,  PayAnyBizDB ,  1 ,  4 ,  3456789 ,  34567892 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 574 ,  1060 ,  2 ,  2014-08-26 19:58:41 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 575 ,  1069 ,  2 ,  2014-08-26 20:28:25 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 576 ,  622 ,  2 ,  2014-08-26 20:43:40 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 577 ,  589 ,  1 ,  2014-08-26 20:44:04 ,  PayAnyBizDB ,  1 ,  90 ,   ,  TestTest Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 578 ,  648 ,  2 ,  2014-08-26 20:46:40 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 579 ,  1068 ,  2 ,  2014-08-28 21:35:46 ,  PayAnyBizDB ,  1 ,  17 ,  5 ,  6 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 580 ,  1067 ,  2 ,  2014-09-08 19:29:01 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 581 ,  1067 ,  2 ,  2014-09-08 19:29:01 ,  PayAnyBizDB ,  1 ,  18 , null,  2,000.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 582 ,  1047 ,  1 ,  2014-09-08 19:38:41 ,  PayAnyBizDB ,  1 ,  90 ,   ,  board.json ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 583 ,  412 ,  1 ,  2014-09-15 06:14:49 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL56789Picture 054.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 584 ,  412 ,  2 ,  2014-09-15 06:15:16 ,  PayAnyBizDB ,  1 ,  13 ,  TXN-02 ,  TXN-02 \nHello i am testing this ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 585 ,  412 ,  2 ,  2014-09-15 06:16:15 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 586 ,  412 ,  2 ,  2014-09-15 06:16:45 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 587 ,  450 ,  1 ,  2014-09-15 07:41:41 ,  PayAnyBizDB ,  1 ,  90 ,   ,  Picture 054.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 588 ,  1061 ,  2 ,  2014-09-18 18:49:07 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 589 ,  1061 ,  2 ,  2014-09-18 18:49:07 ,  PayAnyBizDB ,  1 ,  18 , null,  22.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 590 ,  1069 ,  1 ,  2014-09-18 19:26:50 ,  PayAnyBizDB ,  1 ,  90 ,   ,  5555Test Document (1).txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 591 ,  1061 ,  2 ,  2014-09-18 20:27:31 ,  PayAnyBizDB ,  1 ,  12 ,  55.00 ,  33.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 592 ,  1061 ,  2 ,  2014-09-18 20:27:31 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 593 ,  1070 ,  1 ,  2014-09-18 20:27:31 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 594 ,  1071 ,  1 ,  2014-09-21 09:27:59 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 595 ,  1071 ,  1 ,  2014-09-21 09:29:56 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL6743K_id  Chore Sheet.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 596 ,  1046 ,  2 ,  2014-09-22 17:14:29 ,  PayAnyBizDB ,  1 ,  12 ,  555.00 ,  530.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 597 ,  1046 ,  2 ,  2014-09-22 17:14:29 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 598 ,  1072 ,  1 ,  2014-09-22 17:14:30 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 599 ,  1071 ,  2 ,  2014-09-22 17:30:45 ,  PayAnyBizDB ,  1 ,  12 ,  9,875.00 ,  2,300.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 600 ,  1071 ,  2 ,  2014-09-22 17:31:47 ,  PayAnyBizDB ,  1 ,  12 ,  2,300.00 ,  7,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 601 ,  1071 ,  2 ,  2014-09-22 17:32:41 ,  PayAnyBizDB ,  1 ,  12 ,  7,000.00 ,  2,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 602 ,  1047 ,  2 ,  2014-09-22 17:51:26 ,  PayAnyBizDB ,  1 ,  12 ,  5,826.00 ,  5,821.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 603 ,  1047 ,  2 ,  2014-09-22 17:51:26 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 604 ,  1073 ,  1 ,  2014-09-22 17:51:27 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 605 ,  1026 ,  2 ,  2014-09-26 06:03:40 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 606 ,  1074 ,  1 ,  2014-09-27 12:02:25 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 607 ,  1075 ,  1 ,  2014-09-27 12:08:34 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 608 ,  1027 ,  1 ,  2014-10-03 05:36:41 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL57367222Picture 054.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 609 ,  1034 ,  2 ,  2014-10-03 05:37:47 ,  PayAnyBizDB ,  1 ,  12 ,  5,400.00 ,  5,334.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 610 ,  1034 ,  2 ,  2014-10-03 05:37:47 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 611 ,  1076 ,  1 ,  2014-10-03 05:37:48 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 612 ,  4 ,  2 ,  2014-10-20 19:15:22 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 613 ,  1067 ,  2 ,  2014-10-21 20:22:58 ,  PayAnyBizDB ,  1 ,  16 ,  11 ,  3 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 614 ,  1033 ,  2 ,  2014-10-21 20:22:58 ,  PayAnyBizDB ,  1 ,  16 ,  11 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 615 ,  315 ,  2 ,  2014-10-21 20:22:58 ,  PayAnyBizDB ,  1 ,  16 ,  11 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 616 ,  1067 ,  2 ,  2014-10-21 20:22:58 ,  PayAnyBizDB ,  1 ,  17 ,  3 ,  11 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 617 ,  1033 ,  2 ,  2014-10-21 20:22:58 ,  PayAnyBizDB ,  1 ,  17 ,  3 ,  11 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 618 ,  315 ,  2 ,  2014-10-21 20:22:58 ,  PayAnyBizDB ,  1 ,  17 ,  3 ,  11 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 619 ,  1077 ,  1 ,  2014-10-21 20:32:50 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 620 ,  1077 ,  2 ,  2014-10-21 20:33:15 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 621 ,  1078 ,  1 ,  2014-10-22 18:04:59 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 622 ,  444 ,  2 ,  2014-10-22 18:57:34 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 623 ,  1032 ,  2 ,  2014-10-22 21:40:46 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 624 ,  1009 ,  2 ,  2014-10-22 21:57:21 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 625 ,  1075 ,  1 ,  2014-10-22 22:36:52 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Test Attachment EmailTest Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 626 ,  1075 ,  1 ,  2014-10-22 22:38:19 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test attachment 2Test Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 627 ,  1075 ,  1 ,  2014-10-22 22:41:13 ,  PayAnyBizDB ,  1 ,  92 ,   ,  test attchment 3Test Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 628 ,  1075 ,  1 ,  2014-10-22 22:45:35 ,  PayAnyBizDB ,  1 ,  92 ,   ,  attachment 4Test Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 629 ,  1075 ,  1 ,  2014-10-22 22:50:20 ,  PayAnyBizDB ,  1 ,  92 ,   ,  attachment5Test Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 630 ,  1075 ,  3 ,  2014-10-22 22:52:33 ,  PayAnyBizDB ,  1 ,  93 ,  attachment5Test Document.txt ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 631 ,  1075 ,  3 ,  2014-10-22 22:52:48 ,  PayAnyBizDB ,  1 ,  93 ,  attachment 4Test Document.txt ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 632 ,  1075 ,  3 ,  2014-10-22 22:52:53 ,  PayAnyBizDB ,  1 ,  93 ,  test attchment 3Test Document.txt ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 633 ,  1075 ,  3 ,  2014-10-22 22:52:56 ,  PayAnyBizDB ,  1 ,  93 ,  test attachment 2Test Document.txt ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 634 ,  1075 ,  3 ,  2014-10-22 22:53:00 ,  PayAnyBizDB ,  1 ,  93 ,  Test Attachment EmailTest Document.txt ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 635 ,  1075 ,  1 ,  2014-10-22 23:12:19 ,  PayAnyBizDB ,  1 ,  92 ,   ,  testTest Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 636 ,  1075 ,  3 ,  2014-10-22 23:16:36 ,  PayAnyBizDB ,  1 ,  93 ,  testTest Document.txt ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 637 ,  1075 ,  1 ,  2014-10-22 23:52:17 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Test Attchment1Test Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 638 ,  1079 ,  1 ,  2014-10-23 05:34:00 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 639 ,  1080 ,  1 ,  2014-10-23 05:45:18 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 640 ,  1080 ,  1 ,  2014-10-23 06:44:44 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INVreu7e8Picture 065.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 641 ,  1080 ,  1 ,  2014-10-23 06:45:32 ,  PayAnyBizDB ,  1 ,  96 ,   ,  PODJim Blaeser.docx ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 642 ,  1080 ,  1 ,  2014-10-23 06:47:14 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INVreu7e8Picture 065.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 643 ,  1080 ,  1 ,  2014-10-23 06:47:16 ,  PayAnyBizDB ,  1 ,  96 ,   ,  PODJim Blaeser.docx ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 644 ,  1080 ,  2 ,  2014-10-23 06:48:54 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 645 ,  1080 ,  1 ,  2014-10-23 07:13:17 ,  PayAnyBizDB ,  9 ,  92 ,   ,  BOLLOGO.JPG ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 646 ,  1080 ,  2 ,  2014-10-23 07:27:45 ,  PayAnyBizDB ,  1 ,  12 ,  6,700.00 ,  6,800.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 647 ,  1080 ,  1 ,  2014-10-23 07:47:03 ,  PayAnyBizDB ,  1 ,  96 ,   ,  Pic of ShipmentPicture 066.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 648 ,  1080 ,  2 ,  2014-10-23 07:49:22 ,  PayAnyBizDB ,  1 ,  3 ,  5643325785 ,  5643325785-1 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 649 ,  1080 ,  2 ,  2014-10-23 07:55:07 ,  PayAnyBizDB ,  1 ,  12 ,  6,800.00 ,  6,900.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 650 ,  1080 ,  2 ,  2014-10-23 08:05:08 ,  PayAnyBizDB ,  1 ,  12 ,  6,900.00 ,  12,500.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 651 ,  1080 ,  2 ,  2014-10-23 08:06:16 ,  PayAnyBizDB ,  9 ,  15 , null,  PRN736438 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 652 ,  1080 ,  1 ,  2014-10-23 08:09:06 ,  PayAnyBizDB ,  1 ,  96 ,   ,  CODPayAnyBiz-Website 091614-C.doc ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 653 ,  1080 ,  1 ,  2014-10-23 08:14:20 ,  PayAnyBizDB ,  1 ,  96 ,   ,  picture of shipmentPicture 067.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 654 ,  1079 ,  2 ,  2014-10-23 08:18:19 ,  PayAnyBizDB ,  1 ,  12 ,  5,600.00 ,  9,500.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 655 ,  1079 ,  1 ,  2014-10-23 08:19:18 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL7464768Picture 057.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 656 ,  1079 ,  2 ,  2014-10-23 08:20:56 ,  PayAnyBizDB ,  1 ,  12 ,  9,500.00 ,  10,500.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 657 ,  1081 ,  1 ,  2014-10-23 08:25:13 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 658 ,  1081 ,  1 ,  2014-10-23 08:27:40 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV775590909Summary of WV Deal.docx ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 659 ,  1081 ,  2 ,  2014-10-23 08:42:55 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 660 ,  1081 ,  1 ,  2014-10-23 08:45:13 ,  PayAnyBizDB ,  9 ,  96 ,   ,  POD84373Reyes-back yard 2014 picture.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 661 ,  1078 ,  1 ,  2014-10-23 09:18:34 ,  PayAnyBizDB ,  9 ,  90 ,   ,  BOL76238343Summary of WV Deal.docx ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 662 ,  1082 ,  1 ,  2014-10-23 09:33:04 ,  PayAnyBizDB ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 663 ,  1082 ,  1 ,  2014-10-23 09:34:15 ,  PayAnyBizDB ,  9 ,  90 ,   ,  BOLMaersk310MIG.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 664 ,  1083 ,  1 ,  2014-10-23 10:29:58 ,  PayAnyBizDB ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 665 ,  1083 ,  1 ,  2014-10-23 10:34:45 ,  PayAnyBizDB ,  9 ,  90 ,   ,  BOL83838Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 666 ,  1083 ,  2 ,  2014-10-23 10:46:07 ,  PayAnyBizDB ,  9 ,  12 ,  48,000.00 ,  51,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 667 ,  1083 ,  1 ,  2014-10-23 11:12:23 ,  PayAnyBizDB ,  9 ,  92 ,   ,  INV8383Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 668 ,  1083 ,  2 ,  2014-10-23 11:19:02 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 669 ,  1083 ,  2 ,  2014-10-23 11:23:52 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 670 ,  1079 ,  2 ,  2014-10-23 11:26:30 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 671 ,  1079 ,  2 ,  2014-10-23 11:26:49 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 672 ,  1080 ,  2 ,  2014-10-23 11:26:49 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 673 ,  1081 ,  2 ,  2014-10-23 19:27:34 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 674 ,  1081 ,  2 ,  2014-10-23 19:27:34 ,  PayAnyBizDB ,  9 ,  18 , null,  43,000.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 675 ,  1071 ,  1 ,  2014-10-23 21:10:58 ,  PayAnyBizDB ,  1 ,  90 ,   ,  teesttnumber 6.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 676 ,  1071 ,  1 ,  2014-10-23 21:12:40 ,  PayAnyBizDB ,  1 ,  90 ,   ,  testt2number456.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 677 ,  1084 ,  1 ,  2014-10-24 08:25:02 ,  PayAnyBizDB ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 678 ,  1084 ,  1 ,  2014-10-24 08:25:49 ,  PayAnyBizDB ,  9 ,  90 ,   ,  LOGO.JPG ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 679 ,  1071 ,  2 ,  2014-10-29 05:27:49 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 680 ,  1071 ,  2 ,  2014-10-29 05:30:19 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 681 ,  1060 ,  2 ,  2014-11-04 21:28:12 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 682 ,  1065 ,  2 ,  2014-11-04 21:28:12 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 683 ,  837 ,  2 ,  2014-11-05 09:38:56 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 684 ,  839 ,  2 ,  2014-11-05 09:38:56 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 685 ,  855 ,  2 ,  2014-11-05 09:38:56 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 686 ,  837 ,  2 ,  2014-11-05 09:39:16 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 687 ,  839 ,  2 ,  2014-11-05 09:39:16 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 688 ,  855 ,  2 ,  2014-11-05 09:39:16 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 689 ,  1082 ,  2 ,  2014-11-05 20:13:40 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 690 ,  1084 ,  2 ,  2014-11-05 20:13:40 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 691 ,  1078 ,  2 ,  2014-11-05 20:20:36 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 692 ,  1078 ,  2 ,  2014-11-05 20:20:36 ,  PayAnyBizDB ,  9 ,  18 , null,  25.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 694 ,  884 ,  2 ,  2014-11-05 20:32:09 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 695 ,  892 ,  2 ,  2014-11-05 20:32:22 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 696 ,  894 ,  2 ,  2014-11-05 20:32:23 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 697 ,  856 ,  2 ,  2014-11-05 20:46:41 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 698 ,  825 ,  2 ,  2014-11-05 20:46:41 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 699 ,  819 ,  2 ,  2014-11-05 20:48:38 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 700 ,  814 ,  2 ,  2014-11-05 20:57:30 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 701 ,  799 ,  2 ,  2014-11-05 20:57:31 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 702 ,  770 ,  2 ,  2014-11-05 21:06:15 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 703 ,  708 ,  2 ,  2014-11-05 21:06:16 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 704 ,  740 ,  2 ,  2014-11-05 21:06:16 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 705 ,  688 ,  2 ,  2014-11-05 21:09:02 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 706 ,  667 ,  2 ,  2014-11-05 21:09:06 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 707 ,  621 ,  2 ,  2014-11-05 21:12:05 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 708 ,  655 ,  2 ,  2014-11-05 21:14:08 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 709 ,  646 ,  2 ,  2014-11-05 21:19:43 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 710 ,  594 ,  2 ,  2014-11-05 21:24:11 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 711 ,  578 ,  2 ,  2014-11-05 21:31:00 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 712 ,  545 ,  2 ,  2014-11-05 21:31:03 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 713 ,  557 ,  2 ,  2014-11-05 21:31:03 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 714 ,  809 ,  2 ,  2014-11-05 21:45:40 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 715 ,  1075 ,  2 ,  2014-11-05 21:45:40 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 716 ,  1085 ,  1 ,  2014-11-06 08:28:33 ,  PayAnyBizDB ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 717 ,  1085 ,  1 ,  2014-11-06 08:29:00 ,  PayAnyBizDB ,  9 ,  92 ,   ,  Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 718 ,  1085 ,  1 ,  2014-11-06 08:30:34 ,  PayAnyBizDB ,  9 ,  92 ,   ,  Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 719 ,  1085 ,  1 ,  2014-11-06 08:42:32 ,  PayAnyBizDB ,  9 ,  92 ,   ,  Copy of PayAnyBiz 4 year financial model-1st Yr per month-5M- 102014A.xlsx ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 720 ,  1072 ,  2 ,  2014-11-06 11:34:41 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 721 ,  1072 ,  2 ,  2014-11-06 11:34:41 ,  PayAnyBizDB ,  1 ,  18 , null,  12.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 722 ,  1085 ,  2 ,  2014-11-06 11:35:41 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 723 ,  1085 ,  2 ,  2014-11-06 11:35:41 ,  PayAnyBizDB ,  1 ,  18 , null,  333.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 724 ,  1074 ,  2 ,  2014-11-06 11:37:14 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 725 ,  1074 ,  2 ,  2014-11-06 11:37:14 ,  PayAnyBizDB ,  1 ,  18 , null,  800.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 726 ,  1076 ,  2 ,  2014-11-06 11:40:55 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 727 ,  1076 ,  2 ,  2014-11-06 11:40:55 ,  PayAnyBizDB ,  1 ,  18 , null,  5.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 728 ,  425 ,  2 ,  2014-11-06 20:25:41 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 729 ,  425 ,  2 ,  2014-11-06 20:25:41 ,  PayAnyBizDB ,  1 ,  18 , null,  84.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 730 ,  438 ,  2 ,  2014-11-06 20:25:42 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 731 ,  438 ,  2 ,  2014-11-06 20:25:42 ,  PayAnyBizDB ,  1 ,  18 , null,  699.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 732 ,  440 ,  2 ,  2014-11-06 20:25:42 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 733 ,  440 ,  2 ,  2014-11-06 20:25:42 ,  PayAnyBizDB ,  1 ,  18 , null,  687.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 734 ,  425 ,  2 ,  2014-11-06 20:26:35 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 735 ,  438 ,  2 ,  2014-11-06 20:26:35 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 736 ,  440 ,  2 ,  2014-11-06 20:26:35 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 737 ,  873 ,  2 ,  2014-11-06 20:26:35 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 738 ,  889 ,  2 ,  2014-11-06 20:26:35 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 739 ,  1000 ,  2 ,  2014-11-06 20:26:36 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 740 ,  1002 ,  2 ,  2014-11-06 20:26:36 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 741 ,  1032 ,  2 ,  2014-11-06 20:26:36 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 742 ,  833 ,  2 ,  2014-11-06 20:27:18 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 743 ,  835 ,  2 ,  2014-11-06 20:27:18 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 744 ,  841 ,  2 ,  2014-11-06 20:27:18 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 745 ,  867 ,  2 ,  2014-11-06 20:27:18 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 746 ,  775 ,  2 ,  2014-11-06 20:29:52 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 747 ,  777 ,  2 ,  2014-11-06 20:29:53 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 748 ,  811 ,  2 ,  2014-11-06 20:29:53 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 749 ,  1060 ,  2 ,  2014-11-06 20:30:53 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 750 ,  1065 ,  2 ,  2014-11-06 20:30:53 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 751 ,  1071 ,  2 ,  2014-11-06 20:30:53 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 752 ,  1075 ,  2 ,  2014-11-06 20:30:53 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 753 ,  1026 ,  2 ,  2014-11-06 20:34:38 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 754 ,  1042 ,  2 ,  2014-11-06 20:34:38 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 755 ,  1043 ,  2 ,  2014-11-06 20:34:38 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 756 ,  996 ,  2 ,  2014-11-06 20:38:30 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 757 ,  996 ,  2 ,  2014-11-06 20:38:30 ,  PayAnyBizDB ,  1 ,  18 , null,  648.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 758 ,  999 ,  2 ,  2014-11-06 20:38:30 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 759 ,  999 ,  2 ,  2014-11-06 20:38:30 ,  PayAnyBizDB ,  1 ,  18 , null,  855.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 760 ,  1009 ,  2 ,  2014-11-06 20:38:30 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 761 ,  1009 ,  2 ,  2014-11-06 20:38:30 ,  PayAnyBizDB ,  1 ,  18 , null,  684.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 762 ,  996 ,  2 ,  2014-11-06 20:41:42 ,  PayAnyBizDB ,  1 ,  18 ,  648.00 ,  5.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 763 ,  999 ,  2 ,  2014-11-06 20:41:42 ,  PayAnyBizDB ,  1 ,  18 ,  855.00 ,  5.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 764 ,  1009 ,  2 ,  2014-11-06 20:41:42 ,  PayAnyBizDB ,  1 ,  18 ,  684.00 ,  5.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 765 ,  964 ,  2 ,  2014-11-06 20:46:17 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 766 ,  964 ,  2 ,  2014-11-06 20:46:17 ,  PayAnyBizDB ,  1 ,  18 , null,  5.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 767 ,  967 ,  2 ,  2014-11-06 20:46:18 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 768 ,  967 ,  2 ,  2014-11-06 20:46:18 ,  PayAnyBizDB ,  1 ,  18 , null,  5.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 769 ,  974 ,  2 ,  2014-11-06 20:46:18 ,  PayAnyBizDB ,  1 ,  14 ,  3 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 770 ,  974 ,  2 ,  2014-11-06 20:46:18 ,  PayAnyBizDB ,  1 ,  18 , null,  5.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 771 ,  1060 ,  2 ,  2014-11-06 20:47:50 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 772 ,  1060 ,  2 ,  2014-11-06 20:47:50 ,  PayAnyBizDB ,  1 ,  18 , null,  6.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 773 ,  1065 ,  2 ,  2014-11-06 20:47:51 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 774 ,  1065 ,  2 ,  2014-11-06 20:47:51 ,  PayAnyBizDB ,  1 ,  18 ,  35,000.00 ,  6.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 775 ,  1071 ,  2 ,  2014-11-06 20:47:51 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 776 ,  1071 ,  2 ,  2014-11-06 20:47:51 ,  PayAnyBizDB ,  1 ,  18 , null,  6.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 777 ,  1026 ,  2 ,  2014-11-06 20:55:57 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 778 ,  1042 ,  2 ,  2014-11-09 13:09:40 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 779 ,  1043 ,  2 ,  2014-11-09 13:18:19 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 780 ,  1075 ,  2 ,  2014-11-09 13:18:19 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 781 ,  1090 ,  1 ,  2014-11-09 13:29:56 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 782 ,  1091 ,  1 ,  2014-11-09 13:31:25 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 783 ,  1091 ,  2 ,  2014-11-09 13:32:03 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 784 ,  1091 ,  2 ,  2014-11-09 13:32:03 ,  PayAnyBizDB ,  9 ,  18 , null,  100.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 785 ,  1091 ,  2 ,  2014-11-09 13:32:22 ,  PayAnyBizDB ,  1 ,  12 ,  200.00 ,  100.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 786 ,  1091 ,  2 ,  2014-11-09 13:32:22 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 787 ,  1092 ,  1 ,  2014-11-09 13:32:22 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 788 ,  1092 ,  2 ,  2014-11-09 13:33:30 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 789 ,  1092 ,  2 ,  2014-11-09 13:34:06 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 790 ,  1093 ,  1 ,  2014-11-09 14:25:05 ,  PayAnyBizDB ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 791 ,  1093 ,  1 ,  2014-11-09 14:28:12 ,  PayAnyBizDB ,  9 ,  90 ,   ,  CODE OF ACADEMIC INTEGRITY.docx ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 792 ,  1093 ,  2 ,  2014-11-09 14:35:26 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 793 ,  1094 ,  1 ,  2014-11-09 16:35:27 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 794 ,  1094 ,  1 ,  2014-11-09 16:37:24 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 795 ,  1094 ,  1 ,  2014-11-09 16:37:49 ,  PayAnyBizDB ,  1 ,  90 ,   ,  Carrier Questionaire.doc ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 796 ,  1094 ,  1 ,  2014-11-09 16:42:08 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number:  | Container: 120-001 | Amount:1,500.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 797 ,  1094 ,  1 ,  2014-11-09 16:42:08 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number:  | Container: 560-284 | Amount:8,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 798 ,  1094 ,  1 ,  2014-11-09 16:42:08 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number:  | Container: 121-009 | Amount:4,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 799 ,  1094 ,  1 ,  2014-11-09 16:42:08 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number:  | Container: 980-482 | Amount:5,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 800 ,  1094 ,  1 ,  2014-11-09 16:42:08 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number:  | Container: 212-837 | Amount:10,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 801 ,  1094 ,  1 ,  2014-11-09 16:42:08 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number: 84739475 | Container: 840-282 | Amount:10,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 802 ,  1094 ,  2 ,  2014-11-09 16:43:27 ,  PayAnyBizDB ,  1 ,  99 ,  Number:  | Container: 212-837 | Amount:10,000.00 ,  Number: 145667435-43 | Container: 212-837 | Amount:10,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 803 ,  1002 ,  2 ,  2014-11-09 16:45:18 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 804 ,  1000 ,  2 ,  2014-11-09 16:45:18 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 805 ,  811 ,  2 ,  2014-11-09 16:47:21 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 806 ,  1094 ,  2 ,  2014-11-09 17:14:57 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 807 ,  1094 ,  2 ,  2014-11-09 17:14:57 ,  PayAnyBizDB ,  9 ,  18 , null,  28,500.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 808 ,  1094 ,  2 ,  2014-11-09 17:25:51 ,  PayAnyBizDB ,  1 ,  12 ,  28,500.00 ,  0.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 809 ,  1094 ,  2 ,  2014-11-09 17:25:51 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 810 ,  1095 ,  1 ,  2014-11-09 17:25:51 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 811 ,  1096 ,  1 ,  2014-11-09 17:31:50 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 812 ,  1096 ,  1 ,  2014-11-09 17:32:27 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL MAEU8473955Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 813 ,  1095 ,  2 ,  2014-11-09 17:51:08 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 814 ,  1095 ,  2 ,  2014-11-09 17:51:50 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 815 ,  388 ,  2 ,  2014-11-09 18:11:47 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 816 ,  388 ,  2 ,  2014-11-09 18:11:47 ,  PayAnyBizDB ,  9 ,  18 , null,  62.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 817 ,  392 ,  2 ,  2014-11-09 18:11:47 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 818 ,  392 ,  2 ,  2014-11-09 18:11:47 ,  PayAnyBizDB ,  9 ,  18 , null,  46.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 819 ,  414 ,  2 ,  2014-11-09 18:11:47 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 820 ,  414 ,  2 ,  2014-11-09 18:11:47 ,  PayAnyBizDB ,  9 ,  18 , null,  14.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 821 ,  617 ,  1 ,  2014-11-09 21:03:55 ,  PayAnyBizDB ,  9 ,  90 ,   ,  BOL 4643256Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 822 ,  617 ,  1 ,  2014-11-09 21:10:41 ,  PayAnyBizDB ,  9 ,  90 ,   ,  Error or Enhancement Found10232014.docx ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 823 ,  1096 ,  1 ,  2014-11-09 21:13:14 ,  PayAnyBizDB ,  9 ,  92 ,   ,  Copy of ACH Report.xlsx ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 824 ,  1053 ,  2 ,  2014-11-09 21:14:04 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 825 ,  1090 ,  1 ,  2014-11-09 21:23:08 ,  PayAnyBizDB ,  1 ,  90 ,   ,  test YCR 1Test Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 826 ,  1090 ,  1 ,  2014-11-09 21:27:54 ,  PayAnyBizDB ,  1 ,  90 ,   ,  test YCR 2Test Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 827 ,  1090 ,  1 ,  2014-11-09 21:28:38 ,  PayAnyBizDB ,  1 ,  90 ,   ,  test YCR 3Test Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 828 ,  523 ,  2 ,  2014-11-09 21:29:28 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 829 ,  1090 ,  1 ,  2014-11-09 21:33:09 ,  PayAnyBizDB ,  1 ,  90 ,   ,  test YCR 4Test Document (1).txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 830 ,  523 ,  2 ,  2014-11-09 21:35:45 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 831 ,  523 ,  2 ,  2014-11-09 21:54:25 ,  PayAnyBizDB ,  9 ,  14 ,  3 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 832 ,  523 ,  2 ,  2014-11-09 21:54:25 ,  PayAnyBizDB ,  9 ,  18 , null, null,  1 );
INSERT INTO   transactionsaudits   VALUES ( 833 ,  527 ,  2 ,  2014-11-09 21:54:25 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 834 ,  527 ,  2 ,  2014-11-09 21:54:25 ,  PayAnyBizDB ,  9 ,  18 , null, null,  1 );
INSERT INTO   transactionsaudits   VALUES ( 835 ,  1097 ,  1 ,  2014-11-09 22:30:36 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 836 ,  1098 ,  1 ,  2014-11-09 23:34:52 ,  PayAnyBizDB ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 837 ,  1098 ,  2 ,  2014-11-09 23:35:17 ,  PayAnyBizDB ,  9 ,  16 ,  6 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 838 ,  1098 ,  2 ,  2014-11-09 23:44:41 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 839 ,  1090 ,  1 ,  2014-11-10 07:19:24 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number: ctn111 | Container: 100-1 | Amount:20.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 840 ,  1090 ,  2 ,  2014-11-10 07:23:48 ,  PayAnyBizDB ,  1 ,  12 ,  100.00 ,  150.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 841 ,  1090 ,  2 ,  2014-11-10 07:24:27 ,  PayAnyBizDB ,  1 ,  1 ,  5 ,  4 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 842 ,  1090 ,  2 ,  2014-11-10 07:45:01 ,  PayAnyBizDB ,  1 ,  12 ,  150.00 ,  155.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 843 ,  1099 ,  1 ,  2014-11-10 08:15:10 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 844 ,  1099 ,  1 ,  2014-11-10 08:20:35 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV90910293Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 845 ,  1100 ,  1 ,  2014-11-10 08:27:08 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 846 ,  1100 ,  1 ,  2014-11-10 08:45:40 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Sample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 847 ,  1090 ,  2 ,  2014-11-10 08:48:40 ,  PayAnyBizDB ,  1 ,  12 ,  155.00 ,  160.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 848 ,  1090 ,  2 ,  2014-11-10 08:49:15 ,  PayAnyBizDB ,  1 ,  1 ,  4 ,  1 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 849 ,  1097 ,  2 ,  2014-11-10 09:17:04 ,  PayAnyBizDB ,  9 ,  15 , null,  PRN3782092-2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 850 ,  1097 ,  1 ,  2014-11-10 09:18:34 ,  PayAnyBizDB ,  9 ,  92 ,   ,  inv87362934Sample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 851 ,  1097 ,  1 ,  2014-11-10 09:55:23 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number:  | Container: 433-556 | Amount:50.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 852 ,  1097 ,  1 ,  2014-11-10 09:55:23 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number: 55438455 | Container: 744-2643 | Amount:100.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 853 ,  1097 ,  2 ,  2014-11-10 09:58:50 ,  PayAnyBizDB ,  1 ,  99 ,  Number: 55438455 | Container: 744-2643 | Amount:100.00 ,  Number: 55438455 | Container: 744-2643 | Amount:100.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 854 ,  1097 ,  1 ,  2014-11-10 09:58:50 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number:  | Container:  | Amount:0.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 855 ,  1097 ,  1 ,  2014-11-10 09:58:50 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number:  | Container:  | Amount:0.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 856 ,  1101 ,  1 ,  2014-11-10 10:05:24 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 857 ,  1101 ,  1 ,  2014-11-10 10:05:39 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INVSample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 858 ,  1101 ,  1 ,  2014-11-10 10:05:54 ,  PayAnyBizDB ,  1 ,  90 ,   ,  BOL982374Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 859 ,  1101 ,  2 ,  2014-11-10 10:30:22 ,  PayAnyBizDB ,  9 ,  15 , null,  PRN739824 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 860 ,  1101 ,  1 ,  2014-11-10 10:30:22 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number:  | Container: 87363-2221 | Amount:3,500.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 861 ,  1101 ,  1 ,  2014-11-10 10:30:22 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number:  | Container: 38364-4373 | Amount:30,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 862 ,  1101 ,  1 ,  2014-11-10 10:30:22 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number:  | Container: 83730363-33 | Amount:30,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 863 ,  1101 ,  1 ,  2014-11-10 10:30:22 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number: u8w6e373445 | Container: 38474-2764 | Amount:20,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 864 ,  1099 ,  2 ,  2014-11-10 10:54:09 ,  PayAnyBizDB ,  9 ,  15 , null,  jkoawef ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 865 ,  1099 ,  2 ,  2014-11-10 11:05:49 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 866 ,  1096 ,  1 ,  2014-11-10 11:33:03 ,  PayAnyBizDB ,  9 ,  94 ,   ,  Sample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 867 ,  1096 ,  2 ,  2014-11-10 11:33:10 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 868 ,  1096 ,  2 ,  2014-11-10 11:33:10 ,  PayAnyBizDB ,  9 ,  18 , null,  3,000.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 869 ,  1096 ,  2 ,  2014-11-10 11:58:14 ,  PayAnyBizDB ,  9 ,  15 , null,  PRN98373 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 870 ,  1096 ,  2 ,  2014-11-10 11:58:38 ,  PayAnyBizDB ,  1 ,  12 ,  33,000.00 ,  30,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 871 ,  1096 ,  2 ,  2014-11-10 11:58:38 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 872 ,  1102 ,  1 ,  2014-11-10 11:58:39 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 873 ,  1103 ,  1 ,  2014-11-10 13:36:35 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 874 ,  1103 ,  2 ,  2014-11-10 14:21:00 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 875 ,  1103 ,  1 ,  2014-11-10 14:30:32 ,  PayAnyBizDB ,  1 ,  92 ,   ,  TestTest Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 876 ,  1103 ,  1 ,  2014-11-10 14:33:00 ,  PayAnyBizDB ,  1 ,  92 ,   ,  Test 2Test Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 877 ,  1090 ,  2 ,  2014-11-10 14:52:45 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 878 ,  1090 ,  2 ,  2014-11-10 14:52:45 ,  PayAnyBizDB ,  1 ,  18 , null,  5.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 879 ,  366 ,  2 ,  2014-11-10 15:27:09 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 880 ,  366 ,  2 ,  2014-11-10 15:27:09 ,  PayAnyBizDB ,  1 ,  18 , null,  9.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 881 ,  450 ,  2 ,  2014-11-10 15:29:38 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 882 ,  450 ,  2 ,  2014-11-10 15:29:38 ,  PayAnyBizDB ,  1 ,  18 , null,  100.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 883 ,  1103 ,  2 ,  2014-11-10 15:50:20 ,  PayAnyBizDB ,  1 ,  12 ,  500.00 ,  550.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 884 ,  1102 ,  2 ,  2014-11-10 15:50:56 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 885 ,  1102 ,  2 ,  2014-11-10 15:50:56 ,  PayAnyBizDB ,  9 ,  18 , null,  150.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 886 ,  1097 ,  2 ,  2014-11-10 16:32:44 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 887 ,  1097 ,  2 ,  2014-11-10 16:32:44 ,  PayAnyBizDB ,  1 ,  18 , null,  50.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 888 ,  1103 ,  1 ,  2014-11-10 17:25:30 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number: CONT1 | Container: 100 | Amount:50.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 889 ,  1103 ,  1 ,  2014-11-10 17:26:19 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number: CONT2 | Container: 100-2 | Amount:50.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 890 ,  1102 ,  2 ,  2014-11-10 17:31:28 ,  PayAnyBizDB ,  9 ,  15 , null,  111 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 891 ,  1090 ,  3 ,  2014-11-10 17:31:28 ,  PayAnyBizDB ,  1 ,  100 ,  Number: ctn111 | Container: 100-1 | Amount:20.00 ,  --- DELETED --- ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 892 ,  1101 ,  3 ,  2014-11-10 17:31:28 ,  PayAnyBizDB ,  9 ,  100 ,  Number:  | Container: 87363-2221 | Amount:3,500.00 ,  --- DELETED --- ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 893 ,  1101 ,  3 ,  2014-11-10 17:31:28 ,  PayAnyBizDB ,  9 ,  100 ,  Number:  | Container: 38364-4373 | Amount:30,000.00 ,  --- DELETED --- ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 894 ,  1101 ,  3 ,  2014-11-10 17:31:28 ,  PayAnyBizDB ,  9 ,  100 ,  Number:  | Container: 83730363-33 | Amount:30,000.00 ,  --- DELETED --- ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 895 ,  1101 ,  3 ,  2014-11-10 17:31:28 ,  PayAnyBizDB ,  9 ,  100 ,  Number: u8w6e373445 | Container: 38474-2764 | Amount:20,000.00 ,  --- DELETED --- ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 896 ,  1103 ,  3 ,  2014-11-10 17:31:28 ,  PayAnyBizDB ,  1 ,  100 ,  Number: CONT1 | Container: 100 | Amount:50.00 ,  --- DELETED --- ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 897 ,  1103 ,  3 ,  2014-11-10 17:31:29 ,  PayAnyBizDB ,  1 ,  100 ,  Number: CONT2 | Container: 100-2 | Amount:50.00 ,  --- DELETED --- ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 898 ,  1102 ,  1 ,  2014-11-10 17:31:29 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number: x | Container: 1 | Amount:100.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 899 ,  1102 ,  1 ,  2014-11-10 17:31:29 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number: x1 | Container: 122 | Amount:500.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 900 ,  1103 ,  1 ,  2014-11-10 18:48:40 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number: CONT-1 | Container: 1-1 | Amount:20.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 901 ,  360 ,  2 ,  2014-11-10 19:04:20 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 902 ,  360 ,  2 ,  2014-11-10 19:04:20 ,  PayAnyBizDB ,  1 ,  18 , null,  68.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 903 ,  589 ,  2 ,  2014-11-10 19:14:52 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 904 ,  589 ,  2 ,  2014-11-10 19:14:52 ,  PayAnyBizDB ,  1 ,  18 , null,  55.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 905 ,  420 ,  2 ,  2014-11-10 19:24:01 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 906 ,  420 ,  2 ,  2014-11-10 19:24:01 ,  PayAnyBizDB ,  1 ,  18 , null,  5.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 907 ,  409 ,  2 ,  2014-11-10 19:27:20 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 908 ,  409 ,  2 ,  2014-11-10 19:27:20 ,  PayAnyBizDB ,  1 ,  18 , null,  44.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 909 ,  1104 ,  1 ,  2014-11-11 06:44:51 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 910 ,  1104 ,  1 ,  2014-11-11 06:45:20 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV837298Sample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 911 ,  1104 ,  1 ,  2014-11-11 06:45:25 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV837298Sample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 912 ,  1104 ,  1 ,  2014-11-11 06:45:31 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV837298Sample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 913 ,  1104 ,  1 ,  2014-11-11 07:18:52 ,  PayAnyBizDB ,  9 ,  90 ,   ,  BOL837398Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 914 ,  1104 ,  2 ,  2014-11-11 07:20:10 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 915 ,  1104 ,  2 ,  2014-11-11 07:20:29 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 916 ,  1105 ,  1 ,  2014-11-11 07:41:38 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 917 ,  1105 ,  1 ,  2014-11-11 07:43:32 ,  PayAnyBizDB ,  1 ,  92 ,   ,  INV48736328Sample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 918 ,  1100 ,  2 ,  2014-11-11 08:04:16 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 919 ,  1101 ,  2 ,  2014-11-11 08:04:16 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 920 ,  1105 ,  2 ,  2014-11-11 08:04:16 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 921 ,  1105 ,  2 ,  2014-11-11 09:11:50 ,  PayAnyBizDB ,  9 ,  15 , null,  4tt5 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 922 ,  1105 ,  1 ,  2014-11-11 09:11:50 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number: C1 | Container: 1C1 | Amount:20.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 923 ,  348 ,  2 ,  2014-11-11 09:14:31 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 924 ,  348 ,  2 ,  2014-11-11 09:14:31 ,  PayAnyBizDB ,  9 ,  18 , null,  86.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 925 ,  284 ,  2 ,  2014-11-11 09:15:21 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 926 ,  284 ,  2 ,  2014-11-11 09:15:21 ,  PayAnyBizDB ,  9 ,  18 , null,  14.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 927 ,  1103 ,  3 ,  2014-11-11 17:47:29 ,  PayAnyBizDB ,  1 ,  100 ,  Number: CONT-1 | Container: 1-1 | Amount:20.00 ,  --- DELETED --- ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 928 ,  1090 ,  1 ,  2014-11-11 17:47:29 ,  PayAnyBizDB ,  1 ,  98 ,   ,  Number: ffffs11 | Container: cd4 | Amount:10.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 929 ,  1090 ,  2 ,  2014-11-11 17:47:35 ,  PayAnyBizDB ,  1 ,  99 ,  Number: ffffs11 | Container: cd4 | Amount:10.00 ,  Number: ffffs11 | Container: cd41111 | Amount:10.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 930 ,  1090 ,  2 ,  2014-11-11 17:48:43 ,  PayAnyBizDB ,  1 ,  99 ,  Number: ffffs11 | Container: cd41111 | Amount:10.00 ,  Number: ffffs11 | Container: cd3 | Amount:10.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 931 ,  1073 ,  2 ,  2014-11-11 20:00:52 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 932 ,  1073 ,  2 ,  2014-11-11 20:00:52 ,  PayAnyBizDB ,  1 ,  18 , null,  3.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 933 ,  521 ,  1 ,  2014-11-11 20:33:38 ,  PayAnyBizDB ,  9 ,  90 ,   ,  BOLBill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 934 ,  521 ,  2 ,  2014-11-11 20:36:31 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 935 ,  521 ,  2 ,  2014-11-11 20:36:31 ,  PayAnyBizDB ,  9 ,  18 , null,  82.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 936 ,  252 ,  1 ,  2014-11-11 20:39:40 ,  PayAnyBizDB ,  9 ,  90 ,   ,  BOL GCKQCJQMPXCUATUBill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 937 ,  264 ,  1 ,  2014-11-11 21:12:38 ,  PayAnyBizDB ,  9 ,  90 ,   ,  BOL QEXBill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 938 ,  119 ,  2 ,  2014-11-11 21:54:05 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 939 ,  119 ,  2 ,  2014-11-11 21:54:05 ,  PayAnyBizDB ,  9 ,  18 , null,  58.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 940 ,  339 ,  1 ,  2014-11-13 13:45:43 ,  PayAnyBizDB ,  9 ,  90 ,   ,  BOL 9374986y353Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 941 ,  339 ,  2 ,  2014-11-13 13:47:50 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 942 ,  339 ,  2 ,  2014-11-13 13:48:28 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 943 ,  3 ,  3 ,  2014-11-13 15:23:03 ,  PayAnyBizDB , null,  100 ,  Number:  | Container:  | Amount:1.00 ,  --- DELETED --- ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1943 ,  1108 ,  1 ,  2014-11-13 18:34:15 ,  PayAnyBizDB ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1944 ,  1108 ,  1 ,  2014-11-13 18:35:17 ,  PayAnyBizDB ,  9 ,  90 ,   ,  Test333Test Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1945 ,  1103 ,  1 ,  2014-11-13 18:35:48 ,  PayAnyBizDB ,  9 ,  92 ,   ,  test7Test Document.txt ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1946 ,  1109 ,  1 ,  2014-11-13 18:48:31 ,  PayAnyBizDB ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1947 ,  1110 ,  1 ,  2014-11-13 18:56:25 ,  PayAnyBizDB ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1948 ,  1110 ,  1 ,  2014-11-13 18:56:58 ,  PayAnyBizDB ,  9 ,  92 ,   ,  INV4734874321 Day Complaint Free Challenge.docx ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1949 ,  1110 ,  2 ,  2014-11-13 19:06:31 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1950 ,  1110 ,  2 ,  2014-11-13 19:06:31 ,  PayAnyBizDB ,  9 ,  18 , null,  600.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1951 ,  1110 ,  1 ,  2014-11-14 07:52:41 ,  PayAnyBizDB ,  1 ,  94 ,   ,  Storage fee documentsSample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1952 ,  1110 ,  1 ,  2014-11-14 07:54:59 ,  PayAnyBizDB ,  1 ,  94 ,   ,  Storage fee documentsSample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1953 ,  1110 ,  1 ,  2014-11-14 07:55:16 ,  PayAnyBizDB ,  1 ,  94 ,   ,  Storage fee documentsSample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1954 ,  1110 ,  1 ,  2014-11-14 07:56:00 ,  PayAnyBizDB ,  1 ,  94 ,   ,  testing attachmentsPayment Method Screen.jpg ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1955 ,  1110 ,  2 ,  2014-11-14 10:22:38 ,  PayAnyBizDB ,  1 ,  12 ,  16,600.00 ,  16,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1956 ,  1110 ,  2 ,  2014-11-14 10:22:38 ,  PayAnyBizDB ,  1 ,  14 ,  4 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1957 ,  1111 ,  1 ,  2014-11-14 10:22:38 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1958 ,  1112 ,  1 ,  2014-11-14 10:28:11 ,  PayAnyBizDB ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1959 ,  1111 ,  1 ,  2014-11-14 11:04:19 ,  PayAnyBizDB ,  9 ,  92 ,   ,  INV47434Sample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1960 ,  1111 ,  2 ,  2014-11-14 11:05:53 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1961 ,  1111 ,  2 ,  2014-11-14 11:05:53 ,  PayAnyBizDB ,  9 ,  18 , null,  300.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1962 ,  1101 ,  2 ,  2014-11-18 07:40:40 ,  PayAnyBizDB ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1963 ,  1112 ,  1 ,  2014-11-24 07:36:39 ,  PayAnyBizDB ,  9 ,  92 ,   ,  INV983873Sample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1964 ,  1112 ,  2 ,  2014-11-24 07:37:39 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1965 ,  1112 ,  2 ,  2014-11-24 07:37:39 ,  PayAnyBizDB ,  9 ,  18 , null,  500.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1966 ,  1112 ,  2 ,  2014-11-24 07:47:28 ,  PayAnyBizDB ,  9 ,  12 ,  9,500.00 ,  100.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1967 ,  1112 ,  2 ,  2014-11-24 07:47:28 ,  PayAnyBizDB ,  9 ,  15 , null,  PRN837639 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1968 ,  1108 ,  1 ,  2014-11-24 10:02:57 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number:  | Container: 291871-00 | Amount:33.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1969 ,  1108 ,  1 ,  2014-11-24 10:02:57 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number:  | Container: 372763-11 | Amount:100.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1970 ,  1108 ,  1 ,  2014-11-24 10:02:57 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number:  | Container: 47383-22 | Amount:100.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1971 ,  1108 ,  1 ,  2014-11-24 10:02:57 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number: 83739843 | Container: 823783-33 | Amount:100.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1972 ,  1103 ,  2 ,  2014-11-24 20:24:57 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1973 ,  1109 ,  1 ,  2014-11-24 20:53:24 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number: FFF | Container: 4RGG | Amount:54.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1974 ,  1109 ,  1 ,  2014-11-24 20:53:24 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number: 1KLJ | Container: 5R44 | Amount:500.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1975 ,  1108 ,  2 ,  2014-11-24 20:57:44 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1976 ,  1108 ,  2 ,  2014-11-24 20:57:44 ,  PayAnyBizDB ,  1 ,  18 , null,  33.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1977 ,  1109 ,  2 ,  2014-11-24 21:02:29 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1978 ,  449 ,  1 ,  2014-12-03 10:05:39 ,  PayAnyBizDB ,  9 ,  90 ,   ,  BOL 03983043Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1979 ,  449 ,  2 ,  2014-12-03 10:07:10 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1980 ,  449 ,  2 ,  2014-12-03 10:07:10 ,  PayAnyBizDB ,  9 ,  18 , null,  62.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1981 ,  232 ,  1 ,  2014-12-03 10:10:24 ,  PayAnyBizDB ,  9 ,  90 ,   ,  BOL83839Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1982 ,  232 ,  2 ,  2014-12-03 10:11:02 ,  PayAnyBizDB ,  9 ,  13 ,  TXN-02 ,  TXN-02  i am adding more to this ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1983 ,  232 ,  2 ,  2014-12-03 10:11:34 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1984 ,  232 ,  2 ,  2014-12-03 10:11:34 ,  PayAnyBizDB ,  9 ,  18 , null,  98.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1985 ,  1112 ,  1 ,  2014-12-06 09:13:39 ,  PayAnyBizDB ,  9 ,  92 ,   ,  Dr. Seuss Week 029.JPG ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1986 ,  617 ,  2 ,  2014-12-12 07:54:58 ,  PayAnyBizDB ,  9 ,  14 ,  1 ,  4 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1987 ,  617 ,  2 ,  2014-12-12 07:54:58 ,  PayAnyBizDB ,  9 ,  18 , null,  18.00 ,  1 );
INSERT INTO   transactionsaudits   VALUES ( 1988 ,  386 ,  2 ,  2014-12-31 17:28:39 ,  PayAnyBizDB ,  1 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1989 ,  386 ,  2 ,  2014-12-31 17:29:57 ,  PayAnyBizDB ,  1 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1990 ,  1113 ,  1 ,  2015-01-08 11:37:17 ,  PayAnyBizDB ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1991 ,  1113 ,  1 ,  2015-01-08 11:37:51 ,  PayAnyBizDB ,  9 ,  92 ,   ,  INV8384993Sample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1992 ,  1113 ,  1 ,  2015-01-08 11:38:46 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number:  | Container: 64677 | Amount:3,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1993 ,  1113 ,  1 ,  2015-01-08 11:38:46 ,  PayAnyBizDB ,  9 ,  98 ,   ,  Number: 8387093 | Container: 345664 | Amount:3,000.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1994 ,  1113 ,  1 ,  2015-01-08 11:39:01 ,  PayAnyBizDB ,  9 ,  92 ,   ,  INV8384993Sample Invoice.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1995 ,  1113 ,  1 ,  2015-01-08 11:41:32 ,  PayAnyBizDB ,  1 ,  90 ,   ,  Bill_Of_Lading.pdf ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1996 ,  1114 ,  1 ,  2015-02-17 09:14:43 ,  PayAnyBiz2015 ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1997 ,  1114 ,  1 ,  2015-02-17 09:15:14 ,  PayAnyBiz2015 ,  9 ,  98 ,   ,  Number: 123456 | Container: 2134321 | Amount:10.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1998 ,  1113 ,  2 ,  2015-02-17 09:27:16 ,  PayAnyBiz2015 ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 1999 ,  1114 ,  2 ,  2015-02-18 13:57:59 ,  PayAnyBiz2015 ,  9 ,  3 ,  123456 ,  222 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 2000 ,  1114 ,  2 ,  2015-02-18 13:57:59 ,  PayAnyBiz2015 ,  9 ,  7 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 2001 ,  1114 ,  2 ,  2015-02-18 13:57:59 ,  PayAnyBiz2015 ,  9 ,  17 ,  3 ,  5 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 2002 ,  1115 ,  1 ,  2015-02-18 18:43:05 ,  PayAnyBiz2015 ,  9 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 2003 ,  1116 ,  1 ,  2015-02-19 12:16:58 ,  PayAnyBiz2015 ,  1 ,  0 ,   ,   ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 2004 ,  1116 ,  1 ,  2015-02-19 12:17:29 ,  PayAnyBiz2015 ,  1 ,  98 ,   ,  Number: 121212 | Container: 3213 | Amount:10.00 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 2008 ,  1115 ,  2 ,  2015-02-25 11:37:30 ,  PayAnyBiz2015 ,  9 ,  14 ,  1 ,  2 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 2009 ,  1115 ,  2 ,  2015-02-25 11:38:07 ,  PayAnyBiz2015 ,  9 ,  14 ,  2 ,  3 ,  0 );
INSERT INTO   transactionsaudits   VALUES ( 2010 ,  1117 ,  1 ,  2015-02-26 07:23:17 ,  PayAnyBiz2015 ,  9 ,  0 ,   ,   ,  0 );

-- ----------------------------
-- Table structure for transactionscomments
-- ----------------------------
DROP TABLE IF EXISTS   transactionscomments  ;
CREATE TABLE   transactionscomments   (
  id int(11) NOT NULL,
    transactions_id int(11) DEFAULT NULL,
    customers_id int(11) DEFAULT NULL,
    Comment   text,
    createdOn   datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    active   tinyint(4) NOT NULL,
    users_id int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY   customers_id(  customers_id   ),
  KEY   transactions_id(  transactions_id   ),
  KEY   users_id(  users_id   ),
  CONSTRAINT   transactionscomments_ibfk_1   FOREIGN KEY (  customers_id   ) REFERENCES   customerss  (id),
  CONSTRAINT   transactionscomments_ibfk_2   FOREIGN KEY (  transactions_id   ) REFERENCES   transactions  (id),
  CONSTRAINT   transactionscomments_ibfk_3   FOREIGN KEY (  users_id   ) REFERENCES   users   (id)
) ;

-- ----------------------------
-- Records of transactionscomments
-- ----------------------------
INSERT INTO   transactionscomments   VALUES ( 1 ,  1090 ,  3 ,  Test comment dispute 1 ,  2014-11-11 00:00:00 ,  2014-11-11 00:00:00 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 8 ,  1090 ,  3 ,  test2 ,  2014-11-11 17:29:03 ,  2014-11-11 17:29:03 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 9 ,  1071 ,  3 ,  No pagare ,  2014-11-11 17:37:03 ,  2014-11-11 17:37:03 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 10 ,  1090 ,  3 ,  Test Reply 123 ,  2014-11-12 18:27:48 ,  2014-11-12 18:27:48 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 11 ,  1090 ,  3 ,  hfvhjfjhfjh ,  2014-11-12 18:29:01 ,  2014-11-12 18:29:01 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 12 ,  1110 ,  3 ,  This invoice does match the difference of the $600.00 is storage fees that were added making it a total of $16,600.00 ,  2014-11-14 07:49:28 ,  2014-11-14 07:49:28 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 13 ,  1110 ,  11 ,  Can you show me back up for the $600.00 please ,  2014-11-14 07:50:36 ,  2014-11-14 07:50:36 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 14 ,  1110 ,  3 ,  There should be an attachment area here to attach certain documents to support the dispute or reply ,  2014-11-14 07:51:51 ,  2014-11-14 07:51:51 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 15 ,  1110 ,  11 ,  you know what i am not going to pay you ,  2014-11-14 07:58:16 ,  2014-11-14 07:58:16 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 16 ,  1110 ,  11 , null,  2014-11-14 07:58:16 ,  2014-11-14 07:58:16 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 17 ,  1110 ,  11 , null,  2014-11-14 07:58:34 ,  2014-11-14 07:58:34 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 18 ,  1110 ,  11 , null,  2014-11-14 07:58:43 ,  2014-11-14 07:58:43 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 19 ,  1110 ,  3 ,  are you getting my messages ,  2014-11-14 10:18:15 ,  2014-11-14 10:18:15 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 20 ,  1110 ,  11 ,  yes i am getting your messages. i dont like you  ,  2014-11-14 10:18:56 ,  2014-11-14 10:18:56 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 21 ,  1110 ,  11 , null,  2014-11-14 10:18:56 ,  2014-11-14 10:18:56 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 22 ,  1110 ,  11 ,  Hello any one home ,  2014-11-14 10:19:54 ,  2014-11-14 10:19:54 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 23 ,  1110 ,  3 ,  i like you less ,  2014-11-14 10:20:26 ,  2014-11-14 10:20:26 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 24 ,  1097 ,  3 ,  hello\n ,  2014-11-14 10:24:30 ,  2014-11-14 10:24:30 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 25 ,  1111 ,  3 ,  you are wrong it is correct pay now, Carrawawa ,  2014-11-14 11:07:18 ,  2014-11-14 11:07:18 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 26 ,  1111 ,  11 ,  i am not a carawawa. i am  ,  2014-11-14 11:08:19 ,  2014-11-14 11:08:19 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 27 ,  1112 ,  3 ,  this does reflect our agreement, we have an approved time by your trucker. ,  2014-11-24 07:40:46 ,  2014-11-24 07:40:46 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 28 ,  1112 ,  11 ,  The trucker d_id  not approved a waiting time and it was not approved by us as per contract.  ,  2014-11-24 07:41:48 ,  2014-11-24 07:41:48 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 29 ,  1112 ,  11 ,  Wait it looks like we d_id  approve the waiting time but it was only $250 ,  2014-11-24 07:44:34 ,  2014-11-24 07:44:34 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 30 ,  1112 ,  3 ,  i will adjust the price to $9250.00 now.  ,  2014-11-24 07:45:25 ,  2014-11-24 07:45:25 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 31 ,  1112 ,  3 , null,  2014-11-24 07:45:25 ,  2014-11-24 07:45:25 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 32 ,  1097 ,  11 ,  yoU ARE WRONG yANIER HAS LONG HAIR\n ,  2014-11-24 10:12:48 ,  2014-11-24 10:12:48 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 33 ,  232 ,  3 ,  this is not correct you pay this fee all of the time. you owe the 598 ,  2014-12-03 10:12:20 ,  2014-12-03 10:12:20 ,  1 ,  1 );
INSERT INTO   transactionscomments   VALUES ( 34 ,  232 ,  11 ,  you are wrong like always ,  2014-12-03 10:14:10 ,  2014-12-03 10:14:10 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 35 ,  1112 ,  11 ,  eres feo ,  2014-12-06 09:14:21 ,  2014-12-06 09:14:21 ,  1 ,  9 );
INSERT INTO   transactionscomments   VALUES ( 36 ,  1071 ,  3 ,  I don\ t agree ,  2014-12-30 09:53:24 ,  2014-12-30 09:53:24 ,  1 ,  1 );

-- ----------------------------
-- Table structure for transactions_currencyss
-- ----------------------------
DROP TABLE IF EXISTS   transactions_currencyss  ;
CREATE TABLE   transactions_currencyss   (
  id int(11) NOT NULL,
    name   varchar(20) NOT NULL,
    createdOn   datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    active   tinyint(4) NOT NULL,
  PRIMARY KEY (id)
) ;

-- ----------------------------
-- Records of transactions_currencyss
-- ----------------------------

-- ----------------------------
-- Table structure for transactionsdirections
-- ----------------------------
DROP TABLE IF EXISTS   transactionsdirections  ;
CREATE TABLE   transactionsdirections   (
  id int(11) NOT NULL,
    description   varchar(20) DEFAULT NULL,
    createdOn   datetime DEFAULT NULL,
    modifiedOn   datetime DEFAULT NULL,
    active   tinyint(4) NOT NULL,
  PRIMARY KEY (id)
) ;

-- ----------------------------
-- Records of transactionsdirections
-- ----------------------------

-- ----------------------------
-- Table structure for transactions_disputedetails
-- ----------------------------
DROP TABLE IF EXISTS   transactions_disputedetails  ;
CREATE TABLE   transactions_disputedetails   (
  id int(11) NOT NULL,
    transactions_id int(11) DEFAULT NULL,
    dispute_reasons_id int(11) DEFAULT NULL,
    dispute_categorys_id int(11) DEFAULT NULL,
    description   longtext,
    createdOn   datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    active   tinyint(4) NOT NULL,
    users_id int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY   dispute_reasons_id(  dispute_reasons_id   ),
  KEY   dispute_categorys_id(  dispute_categorys_id   ),
  KEY   transactions_id(  transactions_id   ),
  KEY   users_id(  users_id   ),
  CONSTRAINT   transactions_disputedetails_ibfk_1   FOREIGN KEY (  dispute_reasons_id   ) REFERENCES   dispute_reasons   (id),
  CONSTRAINT   transactions_disputedetails_ibfk_2   FOREIGN KEY (  dispute_categorys_id   ) REFERENCES   dispute_categorys   (id),
  CONSTRAINT   transactions_disputedetails_ibfk_3   FOREIGN KEY (  transactions_id   ) REFERENCES   transactions  (id),
  CONSTRAINT   transactions_disputedetails_ibfk_4   FOREIGN KEY (  users_id   ) REFERENCES   users   (id)
) ;

-- ----------------------------
-- Records of transactions_disputedetails
-- ----------------------------
INSERT INTO   transactions_disputedetails   VALUES ( 1 ,  835 ,  1 ,  2 ,  que te pasa cono. carrero ,  2014-04-03 08:48:17 ,  2014-04-03 08:48:17 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 4 ,  867 ,  1 ,  2 ,  you are charging me 100 to much let me pay the 875 ,  2014-04-20 21:32:21 ,  2014-04-20 21:32:21 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 5 ,  841 ,  1 ,  2 ,  you are to expensive. ,  2014-04-27 14:36:28 ,  2014-04-27 14:36:28 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 6 ,  777 ,  1 ,  2 ,  que caro ,  2014-04-29 10:55:56 ,  2014-04-29 10:55:56 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 7 ,  889 ,  1 ,  2 , null,  2014-05-16 10:20:32 ,  2014-05-16 10:20:32 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 8 ,  833 ,  1 ,  2 , null,  2014-05-21 06:04:59 ,  2014-05-21 06:04:59 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 12 ,  752 ,  1 ,  2 , null,  2014-05-25 18:43:50 ,  2014-05-25 18:43:50 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 13 ,  873 ,  1 ,  1 ,  test ,  2014-05-27 23:42:33 ,  2014-05-27 23:42:33 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 14 ,  1032 ,  1 ,  1 ,  test ,  2014-05-27 21:09:42 ,  2014-05-27 21:09:42 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 15 ,  1033 ,  1 ,  1 ,  test ,  2014-05-27 21:09:42 ,  2014-05-27 21:09:42 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 16 ,  733 ,  1 ,  2 , null,  2014-05-28 09:14:15 ,  2014-05-28 09:14:15 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 17 ,  593 ,  1 ,  2 ,  These transactionshave been pa_id  already please cancel them. ,  2014-05-28 09:27:51 ,  2014-05-28 09:27:51 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 18 ,  614 ,  1 ,  2 ,  These transactionshave been pa_id  already please cancel them. ,  2014-05-28 09:27:51 ,  2014-05-28 09:27:51 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 19 ,  550 ,  1 ,  2 ,  teting dispute ,  2014-05-28 16:31:42 ,  2014-05-28 16:31:42 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 20 ,  548 ,  1 ,  2 ,  teting dispute ,  2014-05-28 16:31:42 ,  2014-05-28 16:31:42 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 21 ,  553 ,  1 ,  2 ,  teting dispute ,  2014-05-28 16:31:42 ,  2014-05-28 16:31:42 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 22 ,  748 ,  1 ,  2 ,  i am writing in here because i feel like it ,  2014-05-31 14:51:57 ,  2014-05-31 14:51:57 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 23 ,  538 ,  1 ,  2 ,  i have already pa_id  for these transactions, please cancel ,  2014-05-31 14:53:43 ,  2014-05-31 14:53:43 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 24 ,  561 ,  1 ,  2 ,  i have already pa_id  for these transactions, please cancel ,  2014-05-31 14:53:43 ,  2014-05-31 14:53:43 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 25 ,  581 ,  1 ,  2 ,  i have already pa_id  for these transactions, please cancel ,  2014-05-31 14:53:43 ,  2014-05-31 14:53:43 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 26 ,  454 ,  1 ,  2 ,  please fix the amount that is not correct ,  2014-06-05 11:37:50 ,  2014-06-05 11:37:50 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 27 ,  486 ,  1 ,  2 ,  please fix the amount that is not correct ,  2014-06-05 11:37:50 ,  2014-06-05 11:37:50 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 28 ,  716 ,  1 ,  2 ,  sazxdcfghjkllkjhgfdssdfghj ,  2014-06-06 09:49:51 ,  2014-06-06 09:49:51 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 32 ,  432 ,  1 ,  2 ,  these transactionshave already been pa_id . please cancel ,  2014-06-17 17:01:39 ,  2014-06-17 17:01:39 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 33 ,  436 ,  1 ,  2 ,  these transactionshave already been pa_id . please cancel ,  2014-06-17 17:01:39 ,  2014-06-17 17:01:39 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 34 ,  1046 ,  1 ,  1 ,  test ,  2014-07-11 00:13:46 ,  2014-07-11 00:13:46 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 35 ,  1047 ,  1 ,  1 , null,  2014-07-13 22:22:04 ,  2014-07-13 22:22:04 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 36 ,  1034 ,  1 ,  1 , null,  2014-07-24 23:28:25 ,  2014-07-24 23:28:25 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 37 ,  1002 ,  1 ,  1 ,  test ,  2014-08-07 19:11:27 ,  2014-08-07 19:11:27 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 38 ,  1027 ,  1 ,  1 ,  ghjklghjkl\njkljkl ,  2014-08-07 19:30:40 ,  2014-08-07 19:30:40 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 39 ,  534 ,  1 ,  2 ,  dfgdfg ,  2014-08-10 21:48:38 ,  2014-08-10 21:48:38 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 40 ,  485 ,  1 ,  2 ,  dfgdfg ,  2014-08-10 21:48:38 ,  2014-08-10 21:48:38 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 41 ,  726 ,  1 ,  2 ,  I am disputing this because the amount is incorrect. ,  2014-08-12 06:14:59 ,  2014-08-12 06:14:59 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 42 ,  1065 ,  5 ,  2 ,   ,  2014-08-26 09:37:10 ,  2014-11-06 22:47:57 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 43 ,  633 ,  1 ,  2 ,  etdrfyugojpyugihol ,  2014-08-26 17:32:23 ,  2014-08-26 17:32:23 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 44 ,  1067 ,  1 ,  1 ,  llk ,  2014-09-08 22:29:30 ,  2014-09-08 22:29:30 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 45 ,  1061 ,  1 ,  1 , null,  2014-09-18 21:49:08 ,  2014-09-18 21:49:08 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 46 ,  1081 ,  1 ,  2 ,  This transactionsshould only be for 42,000 not 43000 ,  2014-10-23 19:27:32 ,  2014-10-23 19:27:32 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 47 ,  1078 ,  1 ,  2 , null,  2014-11-05 22:20:36 ,  2014-11-05 22:20:36 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 48 ,  1072 ,  5 ,  1 , null,  2014-11-06 11:34:40 ,  2014-11-06 11:34:40 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 49 ,  1085 ,  2 ,  2 , null,  2014-11-06 11:35:40 ,  2014-11-06 11:35:40 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 50 ,  1074 ,  2 ,  2 ,  Test ,  2014-11-06 11:37:13 ,  2014-11-06 11:37:13 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 51 ,  1076 ,  1 ,  1 , null,  2014-11-06 11:40:54 ,  2014-11-06 11:40:54 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 52 ,  425 ,  2 ,  1 ,   ,  2014-11-06 22:25:47 ,  2014-11-06 22:25:47 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 53 ,  438 ,  2 ,  1 ,   ,  2014-11-06 22:25:47 ,  2014-11-06 22:25:47 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 54 ,  440 ,  2 ,  1 ,   ,  2014-11-06 22:25:47 ,  2014-11-06 22:25:47 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 55 ,  1009 ,  3 ,  2 ,   ,  2014-11-06 22:38:36 ,  2014-11-06 22:41:48 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 56 ,  996 ,  3 ,  2 ,   ,  2014-11-06 22:38:36 ,  2014-11-06 22:41:48 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 57 ,  999 ,  3 ,  2 ,   ,  2014-11-06 22:38:36 ,  2014-11-06 22:41:48 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 58 ,  964 ,  1 ,  3 ,   ,  2014-11-06 22:46:24 ,  2014-11-06 22:46:24 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 59 ,  974 ,  1 ,  3 ,   ,  2014-11-06 22:46:24 ,  2014-11-06 22:46:24 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 60 ,  967 ,  1 ,  3 ,   ,  2014-11-06 22:46:24 ,  2014-11-06 22:46:24 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 61 ,  1060 ,  5 ,  2 ,   ,  2014-11-06 22:47:57 ,  2014-11-06 22:47:57 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 62 ,  1071 ,  5 ,  2 ,   ,  2014-11-06 22:47:57 ,  2014-11-06 22:47:57 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 63 ,  1091 ,  1 ,  1 , null,  2014-11-09 13:32:02 ,  2014-11-09 13:32:02 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 64 ,  1094 ,  1 ,  2 ,  This transactionsis not being charged as per our contract ,  2014-11-09 17:14:57 ,  2014-11-09 17:14:57 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 65 ,  388 ,  1 ,  2 ,  these transactionsd_id  not reflect our contract ,  2014-11-09 18:11:47 ,  2014-11-09 18:11:47 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 66 ,  392 ,  1 ,  2 ,  these transactionsd_id  not reflect our contract ,  2014-11-09 18:11:47 ,  2014-11-09 18:11:47 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 67 ,  414 ,  1 ,  2 ,  these transactionsd_id  not reflect our contract ,  2014-11-09 18:11:47 ,  2014-11-09 18:11:47 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 68 ,  523 ,  3 ,  2 ,  These payments are already pa_id  ,  2014-11-09 21:54:25 ,  2014-11-09 21:54:25 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 69 ,  527 ,  3 ,  2 ,  These payments are already pa_id  ,  2014-11-09 21:54:25 ,  2014-11-09 21:54:25 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 70 ,  1096 ,  1 ,  2 ,  this does not reflect our contract ,  2014-11-10 11:33:09 ,  2014-11-10 11:33:09 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 71 ,  1090 ,  5 ,  1 , null,  2014-11-10 16:52:50 ,  2014-11-10 16:52:50 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 72 ,  366 ,  4 ,  2 , null,  2014-11-10 17:27:14 ,  2014-11-10 17:27:14 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 73 ,  450 ,  1 ,  3 , null,  2014-11-10 17:29:43 ,  2014-11-10 17:29:43 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 74 ,  1102 ,  1 ,  1 , null,  2014-11-10 15:50:55 ,  2014-11-10 15:50:55 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 75 ,  1097 ,  1 ,  2 , null,  2014-11-10 16:32:43 ,  2014-11-10 16:32:43 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 76 ,  360 ,  1 ,  2 , null,  2014-11-10 19:04:19 ,  2014-11-10 19:04:19 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 77 ,  589 ,  2 ,  1 ,  Test description Dispute ,  2014-11-10 19:14:52 ,  2014-11-10 19:14:52 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 78 ,  420 ,  2 ,  1 ,  description Dispute Test2 ,  2014-11-10 21:24:08 ,  2014-11-10 21:24:08 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 79 ,  409 ,  6 ,  1 ,  Legal Reason for disputed... test red font on description :) ,  2014-11-10 19:27:20 ,  2014-11-10 19:27:20 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 80 ,  348 ,  1 ,  1 ,  gsgdsfgsdf ,  2014-11-11 11:14:30 ,  2014-11-11 11:14:30 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 81 ,  284 ,  1 ,  1 ,  gffgfgggf ,  2014-11-11 11:15:20 ,  2014-11-11 11:15:20 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 82 ,  1073 ,  1 ,  1 ,  test descriptiogv \nsdfgsdfgdfg ,  2014-11-11 22:00:52 ,  2014-11-11 22:00:52 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 83 ,  521 ,  2 ,  2 ,  I am disputing this transactionsbecause it does not reflect our contract. ,  2014-11-11 20:36:31 ,  2014-11-11 20:36:31 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 84 ,  119 ,  1 ,  2 ,  does not reflect our agreed upon contract ,  2014-11-11 21:54:05 ,  2014-11-11 21:54:05 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 85 ,  1110 ,  1 ,  2 ,  This invoice does not reflect the agreement we have. ,  2014-11-13 19:06:31 ,  2014-11-13 19:06:31 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 86 ,  1111 ,  1 ,  2 ,  you are not charging the correct rates. please fix ,  2014-11-14 11:05:53 ,  2014-11-14 11:05:53 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 87 ,  1112 ,  1 ,  2 ,  This does not reflect our agreement, please adjust price ,  2014-11-24 07:37:39 ,  2014-11-24 07:37:39 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 88 ,  1108 ,  1 ,  2 ,  No quiero pagar tanto ,  2014-11-24 22:58:02 ,  2014-11-24 22:58:02 ,  0 ,  1 );
INSERT INTO   transactions_disputedetails   VALUES ( 89 ,  449 ,  1 ,  2 ,  This does not reflect my rates ,  2014-12-03 10:07:10 ,  2014-12-03 10:07:10 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 90 ,  232 ,  1 ,  1 ,  98 should be removed because i sa_id  so ,  2014-12-03 10:11:34 ,  2014-12-03 10:11:34 ,  0 ,  9 );
INSERT INTO   transactions_disputedetails   VALUES ( 91 ,  617 ,  1 ,  2 ,  you screwed up i am only paying you 700.00 ,  2014-12-12 07:54:57 ,  2014-12-12 07:54:57 ,  0 ,  9 );

-- ----------------------------
-- Table structure for transactions_payments
-- ----------------------------
DROP TABLE IF EXISTS   transactions_payments  ;
CREATE TABLE   transactions_payments   (
  id int(11) NOT NULL,
    transactions_id int(11) NOT NULL,
    paymentmethod   int(11) DEFAULT NULL,
    Amount   decimal(19,4) DEFAULT NULL,
    currency   int(11) DEFAULT NULL,
    createdOn   datetime DEFAULT NULL,
    modifiedOn   datetime DEFAULT NULL,
    active   tinyint(4) NOT NULL,
  PRIMARY KEY (id),
  KEY   currency   (  currency  ),
  KEY   paymentmethod   (  paymentmethod  ),
  KEY   transactions_id(  transactions_id   ),
  CONSTRAINT   transactions_payments_ibfk_1   FOREIGN KEY (  currency  ) REFERENCES   transactions_currencyss   (id),
  CONSTRAINT   transactions_payments_ibfk_2   FOREIGN KEY (  paymentmethod  ) REFERENCES   paymentmethod   (id),
  CONSTRAINT   transactions_payments_ibfk_3   FOREIGN KEY (  transactions_id   ) REFERENCES   transactions  (id)
) ;

-- ----------------------------
-- Records of transactions_payments
-- ----------------------------

-- ----------------------------
-- Table structure for transactionsrelatednumbers
-- ----------------------------
DROP TABLE IF EXISTS   transactionsrelatednumbers  ;
CREATE TABLE   transactionsrelatednumbers   (
  id int(11) NOT NULL,
    transactions_id int(11) DEFAULT NULL,
    Number   varchar(20) DEFAULT NULL,
    Container   varchar(20) DEFAULT NULL,
    Amount   decimal(19,4) DEFAULT NULL,
    createdOn   datetime DEFAULT NULL,
    modifiedOn   datetime DEFAULT NULL,
    active   tinyint(4) NOT NULL,
    users_id int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY   transactions_id(  transactions_id   ),
  CONSTRAINT   transactionsrelatednumbers_ibfk_1   FOREIGN KEY (  transactions_id   ) REFERENCES   transactions  (id)
) ;

-- ----------------------------
-- Records of transactionsrelatednumbers
-- ----------------------------
INSERT INTO   transactionsrelatednumbers   VALUES ( 1 ,  15 ,  Test ,  CON-1 ,  100.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 2 ,  3 ,   ,   ,  3.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 3 ,  3 ,   ,   ,  2.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 5 ,  3 ,   ,   ,  456.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 6 ,  3 ,   ,   ,  456.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 7 ,  3 ,   ,   ,  56.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 8 ,  1027 ,  test ,  cn ,  333.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 9 ,  11 ,  REF1 ,  CN-01 ,  100.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 10 ,  7 ,  REF-01 ,  CN-01 ,  100.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 11 ,  475 ,  3221-655 ,  55335-3 ,  442.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 12 ,  475 ,  1123434 ,  3456-1 ,  444.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 13 ,  475 ,  234566 ,  1111-1 ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 14 ,  775 ,  Test 2 ,  T2 ,  150.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 15 ,  775 ,  TEst ,  T1 ,  100.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 16 ,  1031 ,  12121212 ,  343434 ,  12000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 17 ,  1031 ,  12121212 ,  232323 ,  4000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 18 ,  1031 ,  12121212 ,  121212 ,  4000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 19 ,  531 ,  1234567 ,  12121212 ,  120.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 20 ,  551 ,   ,  343434 ,  103.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 21 ,  551 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 22 ,  551 ,   ,  454545 ,  700.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 23 ,  551 ,   ,  232323 ,  100.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 24 ,  551 ,  123456 ,  121212 ,  400.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 25 ,  861 ,   ,  6367824 ,  31.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 26 ,  861 ,  345678765 ,  242424 ,  20.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 27 ,  861 ,   ,  547576 ,  100.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 28 ,  861 ,  4567890987654 ,  242424242 ,  20.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 29 ,  259 ,   ,  76543 ,  38.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 30 ,  259 ,  765438765 ,  45678 ,  735.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 31 ,  835 ,  123456 ,  454545 ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 32 ,  835 ,   ,  4r5678 ,  19.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 33 ,  835 ,   ,  87654 ,  500.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 34 ,  835 ,   ,  12121212 ,  100.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 35 ,  1032 ,   ,  67543 ,  2294.5000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 36 ,  1032 ,  5e980 ,  08974 ,  2294.5000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 37 ,  1032 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 38 ,  1032 ,   ,  46534232 ,  2295.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 39 ,  1032 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 40 ,  1032 ,   ,  54e69075 ,  2295.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 41 ,  1032 ,  09876849 ,  3789432024 ,  2294.5000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 42 ,  7 ,   ,  4444 ,  66.0000 ,  1900-01-01 08:00:00 ,  1900-01-01 08:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 43 ,  7 ,   ,   ,  55.0000 ,  1900-01-01 08:00:00 ,  1900-01-01 08:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 44 ,  315 ,  654325 ,  765432 ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 45 ,  291 ,   ,  755444 ,  9.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 46 ,  291 ,   ,  785444 ,  45.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 47 ,  291 ,   ,  87654 ,  55.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 48 ,  291 ,  098765 ,  34653 ,  35.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 49 ,  1033 ,   ,  9765444 ,  348.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 50 ,  1033 ,   ,  u765456765 ,  1500.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 51 ,  1033 ,  9890000998 ,  5432356 ,  1500.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 52 ,  1031 ,   ,  8888868 ,  10000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 53 ,  1031 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 54 ,  287 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 55 ,  271 ,   ,  11122233343 ,  699.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 56 ,  271 ,   ,  7545666644 ,  1000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 57 ,  271 ,  765432765 ,  6543 ,  1200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 58 ,  1026 ,  34567 ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 59 ,  1026 ,   ,  3456 ,  279.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 60 ,  1026 ,   ,  65456 ,  300.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 61 ,  1026 ,   ,  e45678 ,  100.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 62 ,  1026 ,  345678 ,  8765r4e3456 ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 63 ,  1028 ,  2313222 ,  11111111234 ,  1800.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 64 ,  1028 ,   ,  888888765 ,  2000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 65 ,  1028 ,   ,  43232456 ,  2000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 66 ,  1028 ,   ,   , null,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 67 ,  1028 ,   ,   , null,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 68 ,  1028 ,   ,   , null,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 69 ,  1029 ,  8765432 ,  576432 ,  150.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 70 ,  640 ,   ,   ,  28.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 71 ,  640 ,   ,   ,  190.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 72 ,  640 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 73 ,  640 ,  467283 ,  5478923er ,  22.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 74 ,  640 ,   ,  4334 ,  40.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 75 ,  640 ,  5678 ,  reewt554 ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 76 ,  1043 ,   ,  6543 ,  10000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 77 ,  1043 ,   ,  765 ,  15000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 78 ,  1043 ,   ,  87654 ,  20000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 79 ,  1043 ,  765432 ,  543 ,  20000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 80 ,  726 ,   ,  88888 ,  98.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 81 ,  726 ,   ,  456789 ,  100.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 82 ,  726 ,  4r5t6y7uio ,  5t6y7u ,  100.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 83 ,  726 ,   ,  87654 ,  100.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 84 ,  726 ,   ,  76543 ,  67.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 85 ,  1034 ,  dd ,  ddd ,  3.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 86 ,  259 ,   ,  345678 ,  854.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 87 ,  259 ,  2345678 ,  0987654 ,  1000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 88 ,  259 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 89 ,  259 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 90 ,  259 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 91 ,  259 ,   ,  e34567 ,  1090.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 92 ,  734 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 93 ,  734 ,   ,  34567 ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 94 ,  734 ,  23e456 ,  ertyu ,  235.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 95 ,  734 ,  2345678 ,  45678 ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 96 ,  726 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 97 ,  1028 ,   ,   , null,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 98 ,  1030 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 99 ,  1030 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 100 ,  1030 ,   ,  765 ,  24234.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 101 ,  1030 ,   ,  8765 ,  5000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 102 ,  1030 ,  76543 ,  543 ,  5000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 103 ,  1030 ,  098765 ,  6754 ,  24234.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 104 ,  1030 ,  876543 ,  7654 ,  5000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 105 ,  1030 ,   ,  6543 ,  5001.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 106 ,  1030 ,  8765 ,  5435 ,  24234.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 107 ,  809 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 108 ,  809 ,   ,  432 ,  10.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 109 ,  809 ,   ,  65455 ,  5.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 110 ,  809 ,  65432 ,  654 ,  11.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 111 ,  809 ,  87654 ,  10t5r4e ,  10.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 112 ,  1044 ,   ,   ,  34.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 113 ,  1044 ,   ,   ,  44.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 114 ,  1044 ,  dfgdg ,  dfgdfg ,  443.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 115 ,  1045 ,  dfg ,  dfhd ,  44.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 116 ,  1046 ,  dddd ,  hhh ,  66.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 117 ,  1046 ,  fff ,  ddd ,  44.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 118 ,  1046 ,   ,   ,  55.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 119 ,  1047 ,   ,  34567899 ,  1826.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 120 ,  1047 ,  11111999999 ,  345678 ,  3000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 121 ,  1047 ,   ,  9876543 ,  1000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 122 ,  1056 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 123 ,  1056 ,  76765 ,  765765 ,  76575.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 124 ,  1059 ,  444 ,  555 ,  786.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 125 ,  1059 ,  222 ,  333 ,  33.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 126 ,  1059 ,   ,   ,  4.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 127 ,  1060 ,   ,  02034874 ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 128 ,  1060 ,  456789 ,  090931 ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 129 ,  1060 ,   ,  03872653 ,  155.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 130 ,  1060 ,   ,  081212 ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 131 ,  1060 ,   ,  085632 ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 132 ,  1059 ,   ,   ,  6.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 133 ,  1059 ,   ,   ,  5.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 134 ,  1059 ,   ,   ,  4.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 135 ,  1059 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 136 ,  1059 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 137 ,  1059 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 138 ,  1059 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 139 ,  1059 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 140 ,  1059 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 141 ,  1059 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 142 ,  1059 ,   ,   ,  5000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 143 ,  1060 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 144 ,  1060 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 145 ,  1060 ,   ,   ,  0.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 146 ,  1067 ,   ,  12121-2 ,  2000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 147 ,  1067 ,   ,  4322-1 ,  2000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 148 ,  1067 ,  2345554 ,  3111-1 ,  1000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 151 ,  1053 ,   ,   ,  200.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 152 ,  1053 ,   ,   ,  300.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 153 ,  1053 ,   ,  1122211 ,  300.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 154 ,  1053 ,   ,  5433-1 ,  1000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 155 ,  1053 ,  34567 ,  345677 ,  2000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 156 ,  1066 ,   ,   ,  10.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 161 ,  1068 ,  90 ,  90 ,  9000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 162 ,  1068 ,  9090 ,  990 ,  20000.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 163 ,  412 ,   ,  9876545 ,  283.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 164 ,  412 ,  76543w ,  4344 ,  500.0000 ,  1900-01-01 05:00:00 ,  1900-01-01 05:00:00 ,  0 , null);
INSERT INTO   transactionsrelatednumbers   VALUES ( 165 ,  1094 ,   ,  120-001 ,  1500.0000 ,  2014-11-09 16:42:08 ,  2014-11-09 16:42:08 ,  0 ,  1 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 166 ,  1094 ,   ,  560-284 ,  8000.0000 ,  2014-11-09 16:42:08 ,  2014-11-09 16:42:08 ,  0 ,  1 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 167 ,  1094 ,   ,  121-009 ,  4000.0000 ,  2014-11-09 16:42:08 ,  2014-11-09 16:42:08 ,  0 ,  1 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 168 ,  1094 ,   ,  980-482 ,  5000.0000 ,  2014-11-09 16:42:08 ,  2014-11-09 16:42:08 ,  0 ,  1 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 169 ,  1094 ,  145667435-43 ,  212-837 ,  10000.0000 ,  2014-11-09 16:42:08 ,  2014-11-09 16:43:27 ,  0 ,  1 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 170 ,  1094 ,  84739475 ,  840-282 ,  10000.0000 ,  2014-11-09 16:42:08 ,  2014-11-09 16:42:08 ,  0 ,  1 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 172 ,  1097 ,   ,  433-556 ,  50.0000 ,  2014-11-10 09:55:23 ,  2014-11-10 09:55:23 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 173 ,  1097 ,  55438455 ,  744-2643 ,  100.0000 ,  2014-11-10 09:55:23 ,  2014-11-10 09:58:50 ,  0 ,  1 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 174 ,  1097 ,   ,   ,  0.0000 ,  2014-11-10 09:58:50 ,  2014-11-10 09:58:50 ,  0 ,  1 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 175 ,  1097 ,   ,   ,  0.0000 ,  2014-11-10 09:58:50 ,  2014-11-10 09:58:50 ,  0 ,  1 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 182 ,  1102 ,  x ,  1 ,  100.0000 ,  2014-11-10 19:31:34 ,  2014-11-10 19:31:34 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 183 ,  1102 ,  x1 ,  122 ,  500.0000 ,  2014-11-10 19:31:34 ,  2014-11-10 19:31:34 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 185 ,  1105 ,  C1 ,  1C1 ,  20.0000 ,  2014-11-11 11:11:50 ,  2014-11-11 11:11:50 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 186 ,  1090 ,  ffffs11 ,  cd3 ,  10.0000 ,  2014-11-11 17:47:29 ,  2014-11-11 17:48:43 ,  0 ,  1 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 187 ,  1108 ,   ,  291871-00 ,  33.0000 ,  2014-11-24 10:02:56 ,  2014-11-24 10:02:56 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 188 ,  1108 ,   ,  372763-11 ,  100.0000 ,  2014-11-24 10:02:56 ,  2014-11-24 10:02:56 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 189 ,  1108 ,   ,  47383-22 ,  100.0000 ,  2014-11-24 10:02:56 ,  2014-11-24 10:02:56 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 190 ,  1108 ,  83739843 ,  823783-33 ,  100.0000 ,  2014-11-24 10:02:56 ,  2014-11-24 10:02:56 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 191 ,  1109 ,  FFF ,  4RGG ,  54.0000 ,  2014-11-24 22:53:41 ,  2014-11-24 22:53:41 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 192 ,  1109 ,  1KLJ ,  5R44 ,  500.0000 ,  2014-11-24 22:53:41 ,  2014-11-24 22:53:41 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 193 ,  1113 ,   ,  64677 ,  3000.0000 ,  2015-01-08 11:38:46 ,  2015-01-08 11:38:46 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 194 ,  1113 ,  8387093 ,  345664 ,  3000.0000 ,  2015-01-08 11:38:46 ,  2015-01-08 11:38:46 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 195 ,  1114 ,  123456 ,  2134321 ,  10.0000 ,  2015-02-17 08:15:13 ,  2015-02-17 08:15:13 ,  0 ,  9 );
INSERT INTO   transactionsrelatednumbers   VALUES ( 196 ,  1116 ,  121212 ,  3213 ,  10.0000 ,  2015-02-19 11:17:28 ,  2015-02-19 11:17:28 ,  0 ,  1 );

-- ----------------------------
-- Table structure for transactions_status
-- ----------------------------
DROP TABLE IF EXISTS   transactions_status  ;
CREATE TABLE   transactions_status   (
  id int(11) NOT NULL,
    description   varchar(20) NOT NULL,
    createdOn   datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    active   tinyint(4) NOT NULL,
  PRIMARY KEY (id)
) ;

-- ----------------------------
-- Records of transactions_status
-- ----------------------------
INSERT INTO   transactions_status   VALUES ( 1 ,  Pending ,  2013-11-17 18:46:10 ,  2013-11-17 18:46:10 ,  1 );
INSERT INTO   transactions_status   VALUES ( 2 ,  Verified ,  2013-11-17 18:46:10 ,  2013-11-17 18:46:10 ,  1 );
INSERT INTO   transactions_status   VALUES ( 3 ,  Approved ,  2013-11-17 18:46:10 ,  2013-11-17 18:46:10 ,  1 );
INSERT INTO   transactions_status   VALUES ( 4 ,  Disputed ,  2013-11-17 18:46:10 ,  2013-11-17 18:46:10 ,  1 );

-- ----------------------------
-- Table structure for transactions_types
-- ----------------------------
DROP TABLE IF EXISTS   transactions_types  ;
CREATE TABLE   transactions_types   (
  id int(11) NOT NULL,
    description   varchar(20) NOT NULL,
    createdOn   datetime NOT NULL,
    modifiedOn   datetime NOT NULL,
    active   tinyint(4) NOT NULL,
  PRIMARY KEY (id)
) ;

-- ----------------------------
-- Records of transactions_types
-- ----------------------------
INSERT INTO   transactions_types   VALUES ( 1 ,  BOL ,  2013-11-17 18:43:00 ,  2013-11-17 18:43:00 ,  1 );
INSERT INTO   transactions_types   VALUES ( 2 ,  Invoice ,  2013-11-17 18:43:00 ,  2013-11-17 18:43:00 ,  1 );

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS   users  ;
CREATE TABLE   users   (
  id int(11) NOT NULL,
    usersname   varchar(50) NOT NULL,
    name   longtext,
    Lastname   longtext,
    Email   longtext,
    active   tinyint(4) DEFAULT NULL,
    createdOn   datetime DEFAULT NULL,
    modifiedOn   datetime DEFAULT NULL,
    customers_id int(11) DEFAULT NULL,
    connections_id longtext,
    image_profile   varchar(100) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY   customers_id(  customers_id   ),
  CONSTRAINT   users_ibfk_1   FOREIGN KEY (  customers_id   ) REFERENCES   customerss  (id)
) ;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO   users   VALUES ( 1 ,  admin ,  administrator123 ,  admin ,  angelmpino87@yahoo.com ,  1 ,  2013-12-08 12:01:28 ,  2013-12-08 12:01:28 ,  3 , null,  /images/userss/1.jpg );
INSERT INTO   users   VALUES ( 2 ,  payor #4 ,  payor #4 ,  LN ,  e@e.com ,  1 ,  2013-12-30 21:21:19 ,  2013-12-30 21:21:19 ,  4 , null, null);
INSERT INTO   users   VALUES ( 3 ,  Payer #5 ,  Payer #5 ,  LN ,  e@e.com ,  1 ,  2013-12-30 21:21:19 ,  2013-12-30 21:21:19 ,  5 , null, null);
INSERT INTO   users   VALUES ( 4 ,  biller #6 ,  biller #6 ,  LN ,  e@e.com ,  1 ,  2013-12-30 21:21:19 ,  2013-12-30 21:21:19 ,  6 , null, null);
INSERT INTO   users   VALUES ( 5 ,  Payer #7 ,  Payer #7 ,  LN ,  e@e.com ,  1 ,  2013-12-30 21:21:19 ,  2013-12-30 21:21:19 ,  7 , null, null);
INSERT INTO   users   VALUES ( 6 ,  Payer #8 ,  Payer #8 ,  LN ,  e@e.com ,  1 ,  2013-12-30 21:21:19 ,  2013-12-30 21:21:19 ,  8 , null, null);
INSERT INTO   users   VALUES ( 7 ,  biller #9 ,  biller #9 ,  LN ,  e@e.com ,  1 ,  2013-12-30 21:21:19 ,  2013-12-30 21:21:19 ,  9 , null, null);
INSERT INTO   users   VALUES ( 8 ,  Payer #10 ,  Payer #10 ,  LN ,  e@e.com ,  1 ,  2013-12-30 21:21:19 ,  2013-12-30 21:21:19 ,  10 , null, null);
INSERT INTO   users   VALUES ( 9 ,  payor11 ,  payor 11 users ,  LN ,  greyes@payanybiz.com ,  1 ,  2013-12-30 21:21:19 ,  2013-12-30 21:21:19 ,  11 , null,  /images/userss/9.jpg );
INSERT INTO   users   VALUES ( 10 ,  biller #12 ,  biller #12 ,  LN ,  e@e.com ,  1 ,  2013-12-30 21:21:19 ,  2013-12-30 21:21:19 ,  12 , null, null);
INSERT INTO   users   VALUES ( 11 ,  PayAnyBiz1 ,  George ,  Reyes , null,  0 ,  2014-05-16 09:04:44 ,  2014-05-16 09:04:44 ,  3 , null, null);
INSERT INTO   users   VALUES ( 12 ,  ycr ,  yainier ,  caraballo ,  yainierc@yahoo.es ,  1 ,  2014-06-20 21:53:22 ,  2014-06-20 21:53:22 ,  3 , null, null);
INSERT INTO   users   VALUES ( 13 ,  ycaraballo ,  Yainier ,  Caraballo ,  ycaraballo@payanybiz.com ,  1 ,  2014-06-20 21:55:41 ,  2014-06-20 21:55:41 ,  3 , null, null);
INSERT INTO   users   VALUES ( 14 ,  usersname ,  George  ,  Pingon , null,  0 ,  2014-06-25 14:53:44 ,  2014-06-25 14:53:44 , null, null, null);
INSERT INTO   users   VALUES ( 21 ,  qwerty ,  Yainier ,  Caraballo ,  yainierc@yahoo.es ,  1 ,  2014-06-27 00:29:30 ,  2014-06-27 00:29:30 ,  3 , null, null);
INSERT INTO   users   VALUES ( 22 ,  George ,  Joe ,  Smith ,  greyes@gmslending.com ,  1 ,  2014-06-30 17:34:58 ,  2014-06-30 17:34:58 ,  3 , null, null);
INSERT INTO   users   VALUES ( 23 ,  test ,  test ,  test ,  greyes@gmslending.com ,  1 ,  2014-06-30 17:36:06 ,  2014-06-30 17:36:06 ,  3 , null, null);
INSERT INTO   users   VALUES ( 24 ,  testing ,  testing ,  testing ,  greyes@gmslending.com ,  1 ,  2014-06-30 17:51:54 ,  2014-06-30 17:51:54 ,  3 , null, null);
INSERT INTO   users   VALUES ( 25 ,  rrrrrrr ,  rrrr ,  rrrr ,  yainierc@yahoo.es ,  1 ,  2014-07-11 00:16:19 ,  2014-07-11 00:16:19 ,  3 , null, null);
INSERT INTO   users   VALUES ( 26 ,  asasas ,  ttqqq ,  qqqqq ,  yainierc@yahoo.es ,  1 ,  2014-07-22 04:27:43 ,  2014-07-22 04:27:43 ,  3 , null, null);
INSERT INTO   users   VALUES ( 27 ,  fffffffffdf ,  ffff4566 ,  fffff ,  yainierc@yahoo.es ,  1 ,  2014-07-22 04:32:10 ,  2014-07-22 04:32:10 ,  3 , null, null);
INSERT INTO   users   VALUES ( 28 ,  payanybiz ,  payanybiz ,  payanybiz ,  yainierc@yahoo.es ,  1 ,  2014-07-24 22:55:08 ,  2014-07-24 22:55:08 ,  3 , null, null);
INSERT INTO   users   VALUES ( 29 ,  joeusers ,  Joe ,  Smith ,  gmsent@bellsouth.net ,  1 ,  2014-08-26 05:55:16 ,  2014-08-26 05:55:16 ,  3 , null, null);
INSERT INTO   users   VALUES ( 30 ,  007 ,  users007 ,  Bond ,  yainierc@yahoo.es ,  1 ,  2014-11-06 22:57:45 ,  2014-11-06 22:57:45 ,  3 , null, null);
INSERT INTO   users   VALUES ( 31 ,  009 ,  users009 ,  009 ,  009@009.com ,  1 ,  2014-11-11 15:30:58 ,  2014-11-11 15:30:58 ,  3 , null, null);
INSERT INTO   users   VALUES ( 66 ,  angel01987 ,  AM ,  PD ,  angel@ultconsulting.com ,  1 ,  2015-02-09 11:40:39 ,  2015-02-09 11:40:39 ,  43 , null, null);
INSERT INTO   users   VALUES ( 67 ,  users011111 ,  asd ,  asdasf ,  angel@ultconsulting.com ,  1 ,  2015-02-09 12:39:58 ,  2015-02-09 12:39:58 ,  44 , null, null);
INSERT INTO   users   VALUES ( 68 ,  ericgildev1979 ,  Eric ,  Gil ,  angel@ultconsulting.com ,  1 ,  2015-02-09 12:45:53 ,  2015-02-09 12:45:53 ,  45 , null, null);
INSERT INTO   users   VALUES ( 69 ,  ja001987 ,  adsd ,  asdas ,  angel@ultconsulting.com ,  1 ,  2015-02-09 12:55:17 ,  2015-02-09 12:55:17 ,  46 , null, null);
INSERT INTO   users   VALUES ( 73 ,  ericgil09187 ,  sdasdas ,  dasd ,  angel@ultconsulting.com ,  1 ,  2015-02-09 13:28:55 ,  2015-02-09 13:28:55 ,  50 , null, null);
INSERT INTO   users   VALUES ( 74 ,  yainierc2015 ,  Yainier ,  Caraballo ,  yainierc@yahoo.es ,  1 ,  2015-02-09 20:01:45 ,  2015-02-09 20:01:45 ,  51 , null, null);
INSERT INTO   users   VALUES ( 75 ,  yainierc84 ,  Yainier ,  Caraballo ,  yainierc84@gmail.com ,  1 ,  2015-02-11 20:16:37 ,  2015-02-11 20:16:37 ,  52 , null, null);
INSERT INTO   users   VALUES ( 76 ,  rrrrrrrrr ,  rrrr ,  rrrr ,  jenice_lapeyre@yahoo.es ,  1 ,  2015-02-11 21:00:58 ,  2015-02-11 21:00:58 ,  53 , null, null);

-- ----------------------------
-- Table structure for webpages_memberships
-- ----------------------------
DROP TABLE IF EXISTS   webpages_memberships  ;
CREATE TABLE   webpages_memberships   (
    users_id int(11) NOT NULL,
    CreateDate   datetime DEFAULT NULL,
    ConfirmationToken   varchar(128) DEFAULT NULL,
    IsConfirmed   tinyint(4) DEFAULT NULL,
    LastPasswordFailureDate   datetime DEFAULT NULL,
    PasswordFailuresSinceLastSuccess   int(11) NOT NULL,
    Password   varchar(128) NOT NULL,
    PasswordChangedDate   datetime DEFAULT NULL,
    PasswordSalt   varchar(128) NOT NULL,
    PasswordVerificationToken   varchar(128) DEFAULT NULL,
    PasswordVerificationTokenExpirationDate   datetime DEFAULT NULL,
  PRIMARY KEY (  users_id   )
) ;

-- ----------------------------
-- Records of webpages_memberships
-- ----------------------------
INSERT INTO   webpages_memberships   VALUES ( 1 ,  2013-12-08 19:01:28 , null,  1 ,  2015-02-20 14:18:23 ,  0 ,  ALp/dmgLXqPtVRz4V2cWAQHDXT0nbpgna+/n6kr6JrPCV7XjcL15I1kPQJqRnOe8iA== ,  2013-12-08 19:01:28 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 2 ,  2013-12-30 21:26:12 , null,  1 , null,  0 ,  ALp/dmgLXqPtVRz4V2cWAQHDXT0nbpgna+/n6kr6JrPCV7XjcL15I1kPQJqRnOe8iA== ,  2013-12-30 21:26:12 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 3 ,  2013-12-30 21:26:12 , null,  1 , null,  0 ,  AKlbqRjrJV1ZF7miRAd74Y+6BG2WtmL0dT28XhytQhB1/butXuL27IBKy9J0kgvOvw== ,  2013-12-30 21:26:12 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 4 ,  2013-12-30 21:26:12 , null,  1 , null,  0 ,  AKlbqRjrJV1ZF7miRAd74Y+6BG2WtmL0dT28XhytQhB1/butXuL27IBKy9J0kgvOvw== ,  2013-12-30 21:26:12 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 5 ,  2013-12-30 21:26:12 , null,  1 , null,  0 ,  AKlbqRjrJV1ZF7miRAd74Y+6BG2WtmL0dT28XhytQhB1/butXuL27IBKy9J0kgvOvw== ,  2013-12-30 21:26:12 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 6 ,  2013-12-30 21:26:12 , null,  1 , null,  0 ,  AKlbqRjrJV1ZF7miRAd74Y+6BG2WtmL0dT28XhytQhB1/butXuL27IBKy9J0kgvOvw== ,  2013-12-30 21:26:12 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 7 ,  2013-12-30 21:26:12 , null,  1 , null,  0 ,  AKlbqRjrJV1ZF7miRAd74Y+6BG2WtmL0dT28XhytQhB1/butXuL27IBKy9J0kgvOvw== ,  2013-12-30 21:26:12 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 8 ,  2013-12-30 21:26:12 , null,  1 , null,  0 ,  AKlbqRjrJV1ZF7miRAd74Y+6BG2WtmL0dT28XhytQhB1/butXuL27IBKy9J0kgvOvw== ,  2013-12-30 21:26:12 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 9 ,  2013-12-30 21:26:12 , null,  1 ,  2015-02-23 14:21:38 ,  0 ,  ALp/dmgLXqPtVRz4V2cWAQHDXT0nbpgna+/n6kr6JrPCV7XjcL15I1kPQJqRnOe8iA== ,  2013-12-30 21:26:12 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 10 ,  2013-12-30 21:26:12 , null,  1 , null,  0 ,  AKlbqRjrJV1ZF7miRAd74Y+6BG2WtmL0dT28XhytQhB1/butXuL27IBKy9J0kgvOvw== ,  2013-12-30 21:26:12 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 11 ,  2014-05-16 16:04:44 , null,  1 , null,  0 ,  AB+UDm7i6nXtE0F2ZPyG0NGMwAkujKx1qs4GMzpV/UjTdMthIEN+89T1F/iWasrNQA== ,  2014-05-16 16:04:44 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 12 ,  2014-06-21 01:53:23 , null,  1 , null,  0 ,  AMzgXlhtSYt/OjUQ8jEkV49TlQfpKOtPI3yxA9OtkuRcs55vgPv+VKzJscsi5asvTw== ,  2014-06-21 01:53:23 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 13 ,  2014-06-21 01:55:42 , null,  1 , null,  0 ,  AIIQIEsixDw7MjSsGum2MIhjqM1W8MAYiQk55B3iZjqRc35WdXuajeYtpDzYXkNcmQ== ,  2014-06-21 01:55:42 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 14 ,  2014-06-25 21:53:44 , null,  1 , null,  0 ,  ACV/lzLR6Go+VMYj66YFeC4FKgGGfz9e3Y1jZSdxsIjVsnDMXYyJ2/Vswiq6w57k0g== ,  2014-06-25 21:53:44 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 15 ,  2014-06-27 04:16:07 , null,  1 , null,  0 ,  ANvwSONqWBtYrWGLiHsi7wW1MDuIlq/rBCLol1L5CYL/gCkyJPuXaJgP6sxeGcXDCQ== ,  2014-06-27 04:16:07 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 16 ,  2014-06-27 04:18:12 , null,  1 , null,  0 ,  ADFVsgKUNAE4gj8bO2IiMRvejqhZA+FzPa15SzTrEzuIBtmybZJxoRRb7ShgAClOdA== ,  2014-06-27 04:18:12 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 17 ,  2014-06-27 04:20:52 , null,  1 , null,  0 ,  AHHH/rrVkfeP7GSLPxxjd+fZ0HdKWEW2fSIilK1MkvgZzKyUbKewzTdQHrkpjbLHtg== ,  2014-06-27 04:20:52 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 18 ,  2014-06-27 04:21:58 , null,  1 , null,  0 ,  AIv0mHpp/eUIa1BdgsOSI7qtllkTpg+vnS/4+JyKpNIYD9oVLtVpzAjCSnXWQeQC+w== ,  2014-06-27 04:21:58 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 19 ,  2014-06-27 04:23:19 , null,  1 , null,  0 ,  AB1c6bSjmMB9RbSF00VdhVvhvFEPmqSdzwMfY86Ak7BDTTD79ZwMQ_id tlsIcoVu2aQ== ,  2014-06-27 04:23:19 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 20 ,  2014-06-27 04:23:41 , null,  1 , null,  0 ,  AAvmucTQqhlweLWVFOo/++aEmAUxAw+0HlXyUy2oxg0iIS/rdpfc8FupYuNBd3u0lw== ,  2014-06-27 04:23:41 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 21 ,  2014-06-27 04:29:31 , null,  1 , null,  0 ,  ANMF2USV+hjSqa+CChjFjMml13O5U1uJdUjlk3fQ9SbyJPWMOnhHBdrGTOdk095LqA== ,  2014-06-27 04:29:31 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 22 ,  2014-07-01 00:34:58 , null,  1 ,  2015-02-05 18:47:22 ,  0 ,  ABp6aGFa/uxWTwVdLBGwShwkAfvIbpmvvVPnnOZr4M1MtrFfLgDCjm_id l8rDV06+Aw== ,  2015-02-05 18:44:48 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 23 ,  2014-07-01 00:36:06 , null,  1 , null,  0 ,  AJj8k7oQaEtqtWK92rTWKoiHYgr7LFxGKceevfYtaQbeBGLmhvFWhfS+IfSMtQ3KYQ== ,  2014-07-01 00:36:06 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 24 ,  2014-07-01 00:51:54 , null,  1 , null,  0 ,  AJCMbOFj7ZFeikHsvF5q81tr+Fmnwzc+4r2t6RqxDFh2+moPKlQ8/e6WC6c+K1170w== ,  2014-07-01 00:51:54 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 25 ,  2014-07-11 04:16:20 , null,  1 , null,  0 ,  APV/UretbhyHipvBkQxnZ5zIj1eBBMc7Thv/xC0jJmeWEgl0Q01deVPIoHmP02xr2w== ,  2014-07-11 04:16:20 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 26 ,  2014-07-22 11:27:43 , null,  1 , null,  0 ,  ABeXc38Up/Mh+T5Ltku8U7Jbkohgm0DPIyNTZgBcfn+Ja8vXPXBsdPaIjeAbrMgP0A== ,  2014-07-22 11:27:43 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 27 ,  2014-07-22 11:32:10 , null,  1 , null,  0 ,  AP3br9ditsITGIsVk3EAaT/3iypb+ivSRZfhDUlD7bJzEAqzlmhWq3znvxdqge8EEg== ,  2014-07-22 11:32:10 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 28 ,  2014-07-25 02:55:08 , null,  1 , null,  0 ,  ALp/dmgLXqPtVRz4V2cWAQHDXT0nbpgna+/n6kr6JrPCV7XjcL15I1kPQJqRnOe8iA== ,  2014-07-25 02:55:08 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 29 ,  2014-08-26 12:55:16 , null,  1 , null,  0 ,  ADD3j7jYRansWuTfdDG9ziwI7ICg7vawoMNrvkLsj4KHDnYGUDEkSbZrtDaOWYbeSw== ,  2014-08-26 12:55:16 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 30 ,  2014-11-07 03:57:45 , null,  1 , null,  0 ,  AJOODK6CsGD5YEJ48vJnMA+vE/pJ2ZTino74bJ8IPolZVHVBOfuqHgWPoxtSRy7UGg== ,  2014-11-07 03:57:45 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 31 ,  2014-11-11 20:30:59 , null,  1 , null,  0 ,  AMBpTD/sITNS72DBjml8TduPHyIZpGl9nt/B1mEp7zR8NLqimV0WGYPU0aJsCohcHw== ,  2014-11-11 20:30:59 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 65 ,  2015-02-09 16:26:01 , null,  1 ,  2015-02-09 16:31:00 ,  0 ,  AAND1cUhgpJ2R6OxumJjEaJipPVIPMdRz3Jk4bC+hZ0z644Nh8CGW870GaoIvZyOAQ== ,  2015-02-09 16:30:43 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 66 ,  2015-02-09 16:40:39 , null,  1 ,  2015-02-09 17:33:59 ,  0 ,  AHOBQdm2SRe983lZX2b3fWxE3Xf6JvP/5TZe7kpoAapGbCLDCezrYzygnhaaz7UTOg== ,  2015-02-09 16:40:39 ,   ,  g9Dn3mOr0IyePkVxuYOQdg2 ,  2015-02-10 16:40:45 );
INSERT INTO   webpages_memberships   VALUES ( 67 ,  2015-02-09 17:39:58 , null,  1 ,  2015-02-09 17:41:31 ,  0 ,  AHdKVrL9t6+JFli87hleEuswGWmaS3D5bZL61JrPE4mwVgK5Wlbrz197U/kV/P1RAw== ,  2015-02-09 17:40:54 ,   ,  41YFgq0t55RB4hAyXMUmKA2 ,  2015-02-10 17:48:11 );
INSERT INTO   webpages_memberships   VALUES ( 68 ,  2015-02-09 17:45:53 , null,  1 , null,  0 ,  AP281OIOQCoGir0ZoY1ErWDYmTJp5UnIoGhi9JdwjPWQJy7aGCLRzfGrfJvMZ60wuA== ,  2015-02-09 17:49:42 ,   ,  2lX1ng13FkNzllX66gGVfg2 ,  2015-02-10 18:20:30 );
INSERT INTO   webpages_memberships   VALUES ( 69 ,  2015-02-09 17:55:17 , null,  1 , null,  0 ,  ADz2p6OKon1wdvyBpdgug9Rjgp5pFPwyJZSLdkOqqFEqj4rsGpMBPGoTnRB/lVOC4w== ,  2015-02-09 17:55:17 ,   ,  7aVINWI4r2aA6tvL52u5og2 ,  2015-02-10 17:55:17 );
INSERT INTO   webpages_memberships   VALUES ( 70 ,  2015-02-09 18:17:09 , null,  1 , null,  0 ,  AOCtk+FW7zzaeU7M90OYahlX9Yac27PfbZMFJR/9w+bg3Mi6hGVEDhxVJe+pUOua2g== ,  2015-02-09 18:17:09 ,   ,  qW55eNsFBA0rjTV0kTBesw2 ,  2015-02-10 18:17:09 );
INSERT INTO   webpages_memberships   VALUES ( 71 ,  2015-02-09 18:19:38 , null,  1 , null,  0 ,  AO4/i01PwKqOMphD6MjL0T/wUOSn4ICG1rUupql9th3gtKbfFmk10IoGxbCAN6O2tA== ,  2015-02-09 18:19:38 ,   ,  bMbQzbKhgGUoVEQsCm6kwQ2 ,  2015-02-10 18:19:38 );
INSERT INTO   webpages_memberships   VALUES ( 72 ,  2015-02-09 18:24:34 , null,  1 , null,  0 ,  AAKLkYrfxFAG7x+BUpS6nma6kSy0QN1qedpqVXShyv+i8Oqo1eIf3aa4jnsb/ZWCyg== ,  2015-02-09 18:24:34 ,   ,  hGHhShAfvNuRxK3gi1U7aw2 ,  2015-02-10 18:24:34 );
INSERT INTO   webpages_memberships   VALUES ( 73 ,  2015-02-09 18:28:55 , null,  1 , null,  0 ,  AG4zVtlyXoY3d74KppQrj4aSWnJV55zkYHR9UHRxshSmaeC5NXC4e0wW9QaHFR0Z7A== ,  2015-02-09 18:29:44 ,   , null, null);
INSERT INTO   webpages_memberships   VALUES ( 74 ,  2015-02-10 01:01:45 , null,  1 , null,  0 ,  ADkHTM+Ou7NdAA3iGQ+OWbDqYxvSkb3eHC6uQiATixSw4gfkWhaRvqcmjR2QnYIw0Q== ,  2015-02-10 01:01:45 ,   ,  -IhOweZlF6CFAd8TgCiXPA2 ,  2015-02-11 01:01:45 );
INSERT INTO   webpages_memberships   VALUES ( 75 ,  2015-02-12 01:16:38 , null,  1 , null,  0 ,  ACXv929vp0XEq++WDV01JMetGzHsRAVqcg/7NliZDGsbzkW1fPprvEmnag8tPrNtew== ,  2015-02-12 01:16:38 ,   ,  X5fpYi7imVdKDM_E8gSx6w2 ,  2015-02-13 01:16:39 );
INSERT INTO   webpages_memberships   VALUES ( 76 ,  2015-02-12 02:00:58 , null,  1 , null,  0 ,  AFMt1eCDpWgxkxd94aMrSu9QCrHGuV8TSopLSTn31nCCHtjaxrcLb8qCah+WaQBZxA== ,  2015-02-12 02:00:58 ,   ,  QAHO4PGzX2j6Epn5g38X1w2 ,  2015-02-13 02:00:59 );

-- ----------------------------
-- Table structure for webpages_oauthmembership
-- ----------------------------
DROP TABLE IF EXISTS   webpages_oauthmembership  ;
CREATE TABLE   webpages_oauthmembership   (
    Prov_id er   varchar(30) NOT NULL,
    Prov_id erusers_idvarchar(100) NOT NULL,
    users_id int(11) NOT NULL,
  PRIMARY KEY (  Prov_id er  ,  Prov_id erusers_id   )
);

-- ----------------------------
-- Records of webpages_oauthmembership
-- ----------------------------

-- ----------------------------
-- Table structure for webpages_roles
-- ----------------------------
DROP TABLE IF EXISTS   webpages_roles  ;
CREATE TABLE   webpages_roles   (
    role_id int(11) NOT NULL,
    rolename   longtext NOT NULL,
  PRIMARY KEY (  role_id   )
);

-- ----------------------------
-- Records of webpages_roles
-- ----------------------------
INSERT INTO   webpages_roles   VALUES ( 1 ,  Admin );
INSERT INTO   webpages_roles   VALUES ( 2 ,  Company );
INSERT INTO   webpages_roles   VALUES ( 3 ,  users );

-- ----------------------------
-- Table structure for webpages_userssinroles
-- ----------------------------
DROP TABLE IF EXISTS   webpages_userssinroles  ;
CREATE TABLE   webpages_userssinroles   (
    users_id int(11) NOT NULL,
    role_id int(11) NOT NULL,
  PRIMARY KEY (  users_id   ,  role_id   ),
  KEY   role_id(  role_id   ),
  CONSTRAINT   webpages_userssinroles_ibfk_1   FOREIGN KEY (  role_id   ) REFERENCES   webpages_roles   (  role_id   ),
  CONSTRAINT   webpages_userssinroles_ibfk_2   FOREIGN KEY (  users_id   ) REFERENCES   users   (id)
) ;

-- ----------------------------
-- Records of webpages_userssinroles
-- ----------------------------
INSERT INTO   webpages_userssinroles   VALUES ( 1 ,  1 );
INSERT INTO   webpages_userssinroles   VALUES ( 2 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 3 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 4 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 5 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 6 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 7 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 8 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 9 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 10 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 11 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 12 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 13 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 14 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 21 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 22 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 23 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 24 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 25 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 26 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 27 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 28 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 29 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 30 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 31 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 66 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 67 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 68 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 69 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 73 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 74 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 75 ,  2 );
INSERT INTO   webpages_userssinroles   VALUES ( 76 ,  2 );