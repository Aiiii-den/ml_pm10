#### Legend - USE CASE 1

Version:
- 1: Prediction based on datetime only
- 1.0: all datetime features
- 1.1: specifically chosen datetime features
---------- CHECK -----------

- 2: Datetime plus wind data
- 2.0: all datetime features, wind data h-1: direction, speed
---------- CHECK -----------

- 3: Datetime, (wind) and fine dust data
- 3.0: all datetime features, all fine dust features h-1
- 3.1: all datetime features, wind data h-1: direction, speed, all fine dust features h-1
- 3.2: depending on 3.0 vs 3.1 all datetime features, wind data h-1: direction, speed, specifically chosen fine dust features (which are measured at nearly every station) OR all datetime features, specifically chosen fine dust features
    - 3.2.1 only no
    - 3.2.2 no and o2
    - 3.2.3 only o2