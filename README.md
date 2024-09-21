### 1. Introduction
###### _Context and Motivation_ 

Pm10, abbreviation of particle matter 10, is an air particle with a diameter of less than 10µm. Although it seems 
the majority of people in Berlin are not aware of it, pm10 can cause severe short and long term health issues.

Short term health complications include:
- Irritated eyes, nose and throat
- Worsening of asthma and lung diseases 
- Increased risk of heart attacks and arrhythmias in people with heart disease

Whereas long term health risks include:
- Reduced lung function
- Development of cardiovascular and respiratory diseases
- Increased rate of disease progression
- Reduction in life expectancy

I personally came into contact with the topic of air quality in 2017/18 when I spend 6 month in China. Especially in the winter 
month the air got so bad that even opening the windows was strongly advised against. This experience caused me to be more aware
of potential harm caused by bad air quality even years after. 

The motivation of this project is to bring more awareness of the effect of air quality to both my classmates and people using my 
application. Additionally, the final models should support the knowledge base of pm10 values in Berlin and help make informed
decisions about activities and protective measures. To define the exact goals of the project two problem statements and two use cases were developed.
(source: https://www.health.nsw.gov.au/environment/air/Pages/particulate-matter.aspx)

###### _Problem Statements_

1. **Inability to plan short-term outdoor due to lack of pm10 prediction.**   
No weather station in Berlin and the majority of weather apps do not offer short-term predictions of pm10 or any other air particle.
This disables individuals and organisation to make informed decisions about outdoor activities, which could pose health risks during
periods of unhealthy pm10 levels.


2. **Missing historical data leads to an incomplete understanding of PM10 trends and developments.**    
The weather monitoring system in Berlin (BLUME) experiences sensor failures over longer period of times, 
leading to gaps in historical data collection for PM10 levels. This missing data makes it difficult to analyze past trends, 
assess air quality over time, and accurately support long-term environmental decisions.

To address these problem statements three use cases were created. The first two focus on predicting pm10 values of the future,
whereas the third use cas has the goal of imputing missing historic data.
1. **Use Case 1:** Predicting the pm10 value of the next hour without historic pm10 and pm2.5 data outcomes without historic data, exclusively based on correlating measured data points.  
<br>
2. **Use Case 2:** Predicting the pm10 value of the next hour by including historic pm10 and pm2.5 as well as correlating data points.   
<br>
3. **Use Case 3:** Imputing missing pm10 values based on historic pm10 and correlating data points.    

###### _Objective_   
The goal is to develop predictive models for each use case, evaluate their performance, determine their applicability, 
and deploy the most effective model.

###### _Applied Technologies_   
The models were developed in Jupyter Notebook using Python 3.11.8. Additionally, to organise the virtual environments Anaconda was used. All required dependencies for the project can be found in the following file: anaconda_dependencies.yaml

### 2. Methodology

###### _Data Acquisition & Description_
**Air particle data** 
The data was acquired through an open-data API provided by the city of Berlin. An overview of the API can be found under the following link: https://luftdaten.berlin.de/api/doc.
<br>
The model was trained on data from the station with the station code mc124. This weather station is categorised as a traffic station type and is located at Mariendorfer Damm 148, Tempelhof-Schöneberg, 12099 Berlin.
More information about the weather station can be found here: https://luftdaten.berlin.de/station/mc124#station-info
<br>
Mc124 in Tempelhof-Schöneberg provides the following data points:
- datetime
- station
- core
- component
- period
- value

The core feature contains the different air particles which are measured. 
Moreover, component contains the core and its period. 
For more details please refer to the official documentation or use the following API call:

``` curl
https://luftdaten.berlin.de/api/stations/mc124/data
```

Key features for the model development are the datetime and every value associated with the period of "1h". 
These include pm10, pm2 (particle matter 2.5), no2 (nitrogen dioxide), no (nitrogen monoxide) and nox (nitrogen oxide).

To efficiently request the data from 2016 to 2024 a
[python script](https://github.com/Aiiii-den/ml_pm10/blob/main/scripts_data_acquision/Hourly_script_mc124_tempelhof-sch%C3%B6neberg%20.ipynb)
was implemented and utilized to iterate through each month.

**Wind data**
<br> 
The wind data is provided as open-data by the _Deutscher Wetterdienst_ (German weather service).
The data was initially downloaded manually as a zip file named _stundenwerte_wind_399_akt_ from the following website: https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate_urban/hourly/wind/recent/.
<br>
However, later on the data was acquired using an [automated script](https://github.com/Aiiii-den/ml_pm10/blob/main/scripts_data_acquision/download_and_process_recent_wind.sh).

The file _stundenwerte_wind_399_akt_ includes the wind information for the at Berlin Alexanderplatz at a height of 37 meter.
The data includes the following columns: 
- STATIONS_ID - engl.: station_id
- MESS_DATUM - engl.: date of measurement
- QUALITAETS_NIVEAU - engl.: quality of measurement
- STRUKTUR_VERSION - engl.: version of structure
- WINDGESCHWINDIGKEIT - engl.: wind speed
- WINDRICHTUNG - engl.: wind direction
- eor - engl.: eor
- <br>
Out of those the date of measurement, wind speed and wind direction were used as input features for training the model by being merged with the air particle data based on the date of measurement/datetime.

###### _Data Preprocessing and Engineering_
**Air particle data** #TODO
<br>
_Data Cleaning:_ Explain the steps you took to clean the data.
<br>
_Feature Engineering:_ Discuss any features you created or modified.
<br>
_Train-Test Splitting:_ Detail how the data was split into training and test sets
<br>
_Sprint Tie-In:_ Mention that Sprints 2 and 3 were dedicated to data cleaning and feature engineering. These sprints addressed handling missing values, outliers, and creating new features to improve model performance.

**Wind data** #TODO
<br>
_Data Cleaning:_ Explain the steps you took to clean the data.
<br>
_Feature Engineering:_ Discuss any features you created or modified.
<br>
_Train-Test Splitting:_ Detail how the data was split into training and test sets
<br>
_Sprint Tie-In:_ Mention that Sprints 2 and 3 were dedicated to data cleaning and feature engineering. These sprints addressed handling missing values, outliers, and creating new features to improve model performance.

###### _Machine Learning Models_ #TODO
_Model Selection:_ Describe the models you chose and why. 
<br>
_Rationale:_ Explain your reasoning behind choosing these models. 
<br>
_Hyperparameter Tuning:_ Detail the strategies used to tune the models. 
<br>
_Sprint Tie-In:_ Sprints 4 to 6 covered model selection, baseline testing, and hyperparameter tuning. You can mention that Sprint 4 focused on trying out different models, Sprint 5 evaluated the models’ baseline performances, and Sprint 6 handled hyperparameter tuning using techniques like grid search and randomized search.

###### _Model Evaluation_ #TODO
_Cross-Validation:_ Detail the cross-validation strategy used.
	Example: “5-fold cross-validation was used to prevent overfitting and ensure the model generalized well.”
<br>
_Evaluation Metrics:_ Describe the metrics used to assess model performance.
<br>
_Sprint Tie-In:_ Sprints 7 and 8 focused on model evaluation and testing strategies. Sprint 7 implemented cross-validation, while Sprint 8 measured and compared the models using RMSE, MAE, and R-squared values.

### 3. Sprint Overview #TODO
The project consist of 11 sprints running from BEGINNING DATE to END DATE, excluding a summer break from BD-ED. 
The sprint planning was structured according to the ML development cycle by SOURCE. This cycle includes four or five 'TODO'
phases. 

###### Sprint 1: Data Research & Acquisition (Phase 1)
Task: Gathering the data and performing an initial exploratory analysis.
Outcome: Found several missing values and skewed data distributions in key features like ‘price’ and ‘house size’.
NOT IN THE FIRST but Erkenntnis, dass Neujahr und Ostern große pm10 Mengen verursachen -- Link zur Studie zu Ostern in Hamburg (https://luft.hamburg.de/resource/blob/774550/528d6ac03e2a09cd495dd8b5c54bec80/bericht-osterfeuer-feinstaub-hamburg-2023-data.pdf)

###### Sprint 2: Data Exploration (Phase 2)
Task: Removing duplicates and handling missing data.
Outcome: Imputed missing values for ‘year built’ and removed extreme outliers from the ‘price’ column.

###### Sprint 3: Data Exploration & Model Selection (Phase 2)

###### Sprint 4: Data Exploration (Phase 2)

###### Sprint 5: Data Exploration and Feature Engineering (Phase 2)

###### Sprint 6: Data Exploration, Feature Engineering, Model Selection (Phase 2)

###### Sprint 7: Data Exploration & Model Training + Evaluation (Phase 2 & 3)

###### Sprint 8: Model Training + Evaluation (Phase 3)

###### Sprint 9: Model Training + Evaluation (Phase 3)

###### Sprint 10: Final Testing and Model Comparison (Phase 3)
	
###### Sprint 11: Streamlit App Development + Deployment (Phase 4)
- describe what can be done and seen in the app
- explain situation with only getting the data of the past hour 20 min after it's past
- Model currently trained on data until Mai 2024, could be retrained every month to stay up to date

### 4. Analysis & Discussion #TODO

###### Use Case 1
Structure:
1. Model Performance:
        Summarize the performance of each model.
        Example: “Random Forest and XGBoost significantly outperformed Linear Regression, with XGBoost achieving the best RMSE of 490.” 
2. Insights Gained:
        Discuss what you learned from the feature importance analysis.
        Example: “Location had the highest feature importance, confirming that real estate prices are heavily influenced by geographic location.”
3. Visuals: Present tables or graphs that show model performance, feature importance, or other key insights.

###### Use Case 2
Structure:
1. Model Performance:
        Summarize the performance of each model.
        Example: “Random Forest and XGBoost significantly outperformed Linear Regression, with XGBoost achieving the best RMSE of 490.” 
2. Insights Gained:
        Discuss what you learned from the feature importance analysis.
        Example: “Location had the highest feature importance, confirming that real estate prices are heavily influenced by geographic location.”
3. Visuals: Present tables or graphs that show model performance, feature importance, or other key insights.

###### Use Case 3
Structure:
1. Model Performance:
        Summarize the performance of each model.
        Example: “Random Forest and XGBoost significantly outperformed Linear Regression, with XGBoost achieving the best RMSE of 490.” 
2. Insights Gained:
        Discuss what you learned from the feature importance analysis.
        Example: “Location had the highest feature importance, confirming that real estate prices are heavily influenced by geographic location.”
3. Visuals: Present tables or graphs that show model performance, feature importance, or other key insights.

### 5. Limitations & Future Possibilities 
###### _Data Limitations_
One of the main issue for utilising the trained model is the different data availability at each weather station in Berlin. 
For example mc282 - Karlshorst does not measure pm10 nor pm2.5 and is therefore not included in the stations the model can be applied to. In addition, multiple null values left gaps in the training data since data imputation was not feasable in the beginning and all null data was dropped. Finally, the utilised API only publishes the data for the previous hour around 20 minutes after the hour has passed; however, this is not always exactly timed. This leads to problems when real time data is needed at an exact time.

###### _Model Constraints_
While Random Forest Regression had the best result for most use cases and versions, it is computationally more expensive and takes longer to hyper-validate and train than the slightly weaker performing Decision Tree Regression model.

###### _Future Possibilities_
To improve use case 1 the particle O₃ could be added to the training features, due to its very high correlation to pm10. 
This was not done initially because the chosen weather station for training the model does not measure O₃.
<br>
Furthermore, additional data points use case 2, for example traffic data near the weather stations and more detailed wind and weather data (f.e. humidity, rainfall, etc.)
could be beneficial. Moreover, the model could be trained to predict pm10 values further in the future by using different increments of data points of the past. 
For example, training on h-2 to predict values two hours into the future.
<br>
In regard to use case 3 an iterative approach seems appropriate because as of now only the first missing hour is predictable. 
To completely fill all missing values, including longer time periods, the trained model could be used to incrementally predict each value one by one and utilise the predicted value as input for the following prediction.	Additionally, more functionality could be added to the Streamlit app. For example the treshhold for pm10 measurements according to the EU and/or WHO within the line graphs.
