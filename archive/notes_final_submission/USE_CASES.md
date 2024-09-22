Use Case 1: FORECASTING OF PM10 AT STATIONS WHICH DON'T MEASURE IT
- predicting pm10 values for the next hour
- for example: mc018 Schöneberg
  
Use Case 2: FORECASTING OF PM10 AT STATIONS WHICH MEASURE IT
- features and version chosen based on best performing in Use Case 1
- predicting pm10 values for the next hour
- for example: mc124 Tempelhof-Schöneberg
 
Use Case 3: VALUE IMPUTATION FOR MISSING DATA AT STATIONS WHICH MEASURE PM10 AND PM2.5 
- using all features except pm10 & pm2.5 (same sensor, when one isn't measured the other one isn't measured either)
- based on previous hour so that longer time periods can be imputated iteratively -> once with also noX_h-1
- value imputation (past)
- for example: mc124 Tempelhof-Schöneberg

Explanation:
Imputation typically refers to filling in missing data within an existing dataset, usually for historical or present data. -- NOT FOR ADDING A COMPLETELY NEW DATA FIELD THO
Forecasting or Prediction is the correct term when you’re estimating or predicting values into the future.