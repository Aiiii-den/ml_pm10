Sprint 1:
- explored possbile data sets both in South Korea and Germany
- decided on using a dataset consisting of air quality data of Berlin

Sprint 2:
- Analysed data for a station in Berlin Wedding (mc010)
- analysed December 2022
- analysed March 2023 -> recognised a big spike at the end of the month (easter weakend)
- created heatmap of March 2024 to visualise correlation between each air particle (no2_1h, no_1h, nox_1h, o3_1h, pm10_1h, pm2_1h)
- made the initial decision to go with time series prediction

Sprint 3:
- analysed Jan 2024, displayed monthly and daily pm10 development --> influence New Year
- analysed March 2024 to assure that the abnormal values in 2023 were not a singular occurrence
- found study about the effect of easter fire in the city of Hamburg https://www.hamburg.de/resource/blob/847144/d0e93dd9d86723c7f3c549f30da2a96d/pdf-osterfeuerbericht-2024-data.pdf
- decided on using Facebook/Metas Prophet library for time series prediction

Sprint 4:
- implemented python script to request hourly data from the station mc124 Berlin Tempelhof-Schöneberg from January 1st 2008 to Mai 31sr 2024
- deep dive into Easter analysis (Friday  to Monday) 2024
- Challenges: time zone changes caused error when trying to plot -> quick solution was to convert to UTC; however this would miscue habits like commuting

Sprint 5:
- in depth analysis of New Year 2023-2024
- created annual comparison from 2016 to 2024 displaying total pm10, average pm10 and totoal pm10 counts
- as well a showing monthly comparisons of average pm10 between the years
- deep dive into November 2022 due to noticable difference within previous visualisations
- null values analysis of air quality input data
- fixed time zone problem by cutting off the time zone information from the datetime altogether
- explored wind data 
- created heatmap to visualise correlation between pm10, wind speed and wind data
 
 Sprint 6:
- decided to switch from initial decision of time series prediction to regression
- merged air quality data and wind data to create heatmap to explore correlations between air particles and wind speed

Sprint 7:
- created a heatmap showing the correlation between the hour of day, month, year, day, weekends and pm10
- trained and evaluated use case 1 V1.0 and V1.1 for decision tree, random forest, and kNN

Sprint 8:
- trained and evaluated use case 1 V2.0 for decision tree and random forest

Sprint 9:
- trained and evaluated use case 1 V3.0 and V3.1 for decision tree and random forest
- trained and evaluated use case 2 V3.0 and V3.1 for decision tree and random forest
- trained and evaluated use case 3 V1 and V2 for decision tree and random forest

decision for the final model:
**Random Forest:** 
      - input features: ['hour', 'day', 'month', 'year', 'day_of_week', 'is_weekend', 'no2_h-1', 'no_h-1', 'nox_h-1', 'pm10_h-1', 'pm2.5_h-1']
      - best results: RandomForestRegressor(max_depth=15, max_features='sqrt', min_samples_leaf=5, random_state=123)
      - test_median_absolute_error: 1.56 (+/- 0.10)
      - train_median_absolute_error: 1.24 (+/- 0.01) 
      - overfitting: barely any (difference of 0.32)
      - comparison to other models: better test and train results -> nr. 1

Sprint 10:
- tested the final model on four stations:
  1. mc124 (original station)
  2. mc190 - same category as mc124 (traffic)
  3. mc010 - different category as mc124 (residential area)
  4. mc032 - different category as mc124 (city outskirt)

- visualised deviation range in bar chart
- exported ml model as pkl and joblib file

Sprint 11:
- implemented Streamlit app 
- cleaned up repo
- wrote documentation