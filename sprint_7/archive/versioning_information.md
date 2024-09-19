#### Legende (was ist das englische Wort dafür??)

Version:
- 1: Prediction based on datetime only -- USE CASE 1 (tatsächliche Vorhersage)
- 1.0: all datetime features
- 1.1: specifically chosen datetime features

- 2: Datetime plus wind data -- USE CASE 1 OR 2 (1 if we use the wind speed of the hour prior, 2: Value Imputation if we use live data)
- 2.0: all datetime features, wind data: direction, speed
- 2.1: specifically chosen datetime features

-------------------- STOP HERE AND REPEAT VERSION 1 & 2 FOR RANDOM FOREST, kNN & LINEAR REGRESSION -------------------- 

- 3: Datetime, wind and fine dust data
- 3.0: all datetime features, wind data: direction, speed, all fine dust features
- 3.1: specifically chosen datetime features, wind data: direction, speed, all fine dust features
- 3.2: specifically chosen datetime features, wind data: direction, speed, specifically chosen fine dust features (which are measured at nearly every station)
    - only no
    - no and o2
    - only o2

TODO (nach Helena):
- einmal komplettes tuning für Version 1.0
- danach 1.1
- danach 2.0
- danach 2.1

- WOCHENTAGE AUFLÖSEN IN SPALTE PRO WOCHENTAG MIT BOOLEAN