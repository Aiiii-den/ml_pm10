#### Legende (was ist das englische Wort dafür??)

Version:
- 1: Prediction based on datetime only -- USE CASE 1 (tatsächliche Vorhersage)
- 1.0: all datetime features
- 1.1: specifically chosen datetime features
---------- CHECK -----------

- 2: Datetime plus wind data -- USE CASE 1 OR 2 (1 if we use the wind speed of the hour prior, 2: Value Imputation if we use live data)
- 2.0: all datetime features, wind data h-1: direction, speed
---------- CHECK -----------

- 3: Datetime, wind and fine dust data
- 3.0: all datetime features, wind data h-1: direction, speed, all fine dust features
- 3.1: all datetime features, wind data h-1: direction, speed, specifically chosen fine dust features (which are measured at nearly every station)
    - 3.1.1 only no
    - 3.1.2 no and o2
    - 3.1.3 only o2

- 4: Datetime and fine dust data