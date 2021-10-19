#!/usr/bin/env python
import requests as curl
import notify2
from datetime import datetime, timedelta


key_list = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha']
today_date = datetime.strftime(datetime.now(), "%Y-%m-%d")
URL = f"https://api.pray.zone/v2/times/day.json?city=bekasi&date={today_date}"
data = curl.get(URL).json()
pray_datetime = data['results']['datetime']
pray_time = [ x['times'] for x in pray_datetime ][0]
time_now = datetime.strptime(datetime.strftime(datetime.now(), "%H:%M"), "%H:%M")
for key in pray_time:
    if key in key_list:
        # print(f"{key} -> {pray_time[key]}")
        pray_time_now = datetime.strptime(pray_time[key], "%H:%M")
        difference = datetime.strptime(str(pray_time_now - time_now), "%H:%M:%S")
        if difference.hour < 2:
            print(f"{key} in {difference.hour}:{difference.minute}")
        if pray_time_now == time_now:
            notif = notify2.Notification("Islamic Prayer Notification", f"Time to shalah {key}")

