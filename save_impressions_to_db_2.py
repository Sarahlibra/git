# -*- coding: utf-8 -*-
"""
Created on Fri Mar 11 21:30:10 2016

@author: sara
"""
# 要求所有字段构成主键
import sys
import csv
import pymysql
from collections import namedtuple
maxInt = sys.maxsize
decrement = True

while decrement:
    decrement = False
    try:
        csv.field_size_limit(maxInt)
    except OverflowError:
        maxInt = int(maxInt/10)
        decrement = True
        
# connect to dbms
conn = pymysql.connect(host='127.0.0.1', port=3306, user='root', passwd='123456', db='xing',charset='UTF8')
cur=conn.cursor()

n = 0
with open(r'D:\lyl\junshen\data\trainningdata\impressions.csv','r') as f:
    spamreader = csv.reader(f, delimiter='\t', quoting=csv.QUOTE_NONE)
    headers = next(spamreader)
    Row = namedtuple('Row',headers)
    
    for r in spamreader:
        row = Row(*r)

        usr_id = int(row.user_id)
        week = int(row.week)
        itms = row.items.split(",")
                        
        sql = "INSERT INTO impressions (user_id, week, item_id) VALUES ('%d', '%d', '%d')"
        
        itm_ids = set()
        for itm_id in itms:
                        
            if itm_id in itm_ids:
                continue
            else:
                itm_ids.add(itm_id)
                
            cur.execute(sql % (usr_id, week, int(itm_id)))

        
        n += 1
        
        if n % 10000 == 0:
            conn.commit()
            print(n)
        else:
            pass
               
# close dbms
cur.close()
conn.close()
print("over")