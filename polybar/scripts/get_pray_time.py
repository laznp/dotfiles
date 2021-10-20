#!/usr/bin/env python
import requests as curl
from datetime import datetime, timedelta

key_list = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha']
URL = f"https://api.pray.zone/v2/times/today.json?city=jakarta&school=9"
data = curl.get(URL).json()
pray_datetime = data['results']['datetime']
pray_time = [ x['times'] for x in pray_datetime ][0]
time_now = datetime.strptime(datetime.strftime(datetime.now(), "%H:%M"), "%H:%M")
for key in pray_time:
    if key in key_list:
        pray_time_next = datetime.strptime(pray_time[key], "%H:%M")
        if time_now < pray_time_next:
            difference = datetime.strptime(str(pray_time_next - time_now), "%H:%M:%S")
            print(f"{key} in {difference.hour}:{difference.minute}")
            break


