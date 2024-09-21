### 1. Introduction
###### _Context and Motivation_ 

Pm10, abbreviation of particle matter 10, is an air particle with a diameter of less than 10µm and is measured in micrograms per cubic meter (μg/m³). Although it seems 
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
   
2. **Use Case 2:** Predicting the pm10 value of the next hour by including historic pm10 and pm2.5 as well as correlating data points.   

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
- STATIONS_ID - eng.: station_id
- MESS_DATUM - eng.: date of measurement
- QUALITAETS_NIVEAU - eng.: quality of measurement
- STRUKTUR_VERSION - eng.: version of structure
- WINDGESCHWINDIGKEIT - eng.: wind speed
- WINDRICHTUNG - eng.: wind direction
- eor - eng.: eor

<br>
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

### 4. Analysis & Discussion

###### Use Case 1
An overview of the results for training and testing Decision Tree Regression, Random Forest Regression and k-Nearest-Neighbor 
can be found in table 1. Each machine learning model is annotated with the version of input features used.
Version 1 focuses on datetime features only. Version 2 add wind data and version three utilises datetime, fine dust and 
in a subversion wind data. For a more detailed explanation please refer to the [versioning information](https://github.com/Aiiii-den/ml_pm10/blob/documentation/sprint_9/uc1_versioning_information_v2.md) file.
<br>

The best performing model, considering test median error and rate of overfitting, is the DecisionTreeRegressor V3.1. 
This model used all datetime features, all fine dust features of the previous hour but excluded the wind data. 
With a median absolute error for test data of 5.94μg/m³ it showed the second-best result. 
While RandomForestRegressor V3.1 had a test median absolute error value of 5.51μg/m³, and therefore the best test error rate,
it showed strong overfitting with a difference of 2.59μg/m³ between test and train median absolute error rates. 
Because of this the DecisionTreeRegressor V3.1 was chosen as the best performing model with an overfitting rate of only 0.70.


The input features and hyperparameter of DecisionTreeRegressor V3.1 are the following: 
- **Input features:** hour, day, month, year, day_of_week, is_weekend, no2_h-1, no_h-1, nox_h-1, wind_speed_h-1, wind_direction_h-1
- **Hyperparameter:** max_depth=10, max_features='sqrt', min_samples_leaf=40, random_state=123

| Model + Version      | TEST_median_absolute_error | TRAIN_median_absolute_error | Difference |
|----------------------|----------------------------|-----------------------------|------------|
| DecisionTree V1.0    | 6.93 (+/- 0.34)            | 6.49 (+/- 0.15)             |  0.44      |
| DecisionTree V1.1    | 7.41 (+/- 0.43)            | 6.73 (+/- 0.14)             |  0.68      |
| DecisionTree V2.0    | 6.34 (+/- 0.17)            | 5.12 (+/- 0.09)             |  1.22      |
| DecisionTree V3.0    | 6.40 (+/- 0.48)            | 5.34 (+/- 0.11)             |  1.06      |
| DecisionTree V3.1    | 5.94 (+/- 0.49)            | 5.24 (+/- 0.13)             |  0.70      |
| RandomForest V1.0    | 6.83 (+/- 0.42)            | 5.64 (+/- 0.09)             |  1.19      |
| RandomForest V1.1    | 7.11 (+/- 0.44)            | 6.86 (+/- 0.14)             |  0.25      |
| RandomForest V2.0    | 6.27 (+/- 0.35)            | 4.23 (+/- 0.03)             |  2.04      |
| RandomForest V3.0    | 6.03 (+/- 0.50)            | 3.24 (+/- 0.03)             |  2.79      |
| RandomForest V3.1    | 5.51 (+/- 0.38)            | 2.92 (+/- 0.05)             |  2.59      |
| kNN V1.0             | 7.04 (+/- 0.37)            | 4.72 (+/- 0.14)             |  2.32      |
| kNN V1.1             | 7.44 (+/- 0.39)            | 7.44 (+/- 0.32)             |  0.00      |
_Table 1: Final results after hyperparameter tuning and cross-validation for use case 1_

This shows that adding wind data to the training features has a positive effect on the prediction.
However, with a median absolute error between 5.51μg/m³ and 7.44μg/m³ of a median pm10 value of 20μg/m³ the predictions
are lacking in accuracy and do not meet the expectation of ~10% deviation of the median value.

###### Use Case 2

For use case 2 training and evaluation only the two best performing models and the best main version from use case 1 were utilised. 
These are DecisionTreeRegressor and RandomForestRegressor for version 3. As shown in table 2 none of the trained models exhibit 
overfitting, with all values below 0.5μg/m³. Therefore, the best model was selected based on the median absolute error for test data.  
Out of all four models the RandomForestRegressor V3.0 is the best model for use case 2. With a test median absolute error of 
1.56μg/m³. 


The input features and hyperparameter of RandomForestRegressor V3.0 are the following: 
- **Input features:** hour, day, month, year, day_of_week, is_weekend, no2_h-1, no_h-1, nox_h-1, pm10_h-1, pm2.5_h-1
- **Hyperparameter:** max_depth=15, max_features='sqrt', min_samples_leaf=5, random_state=123

| Model + Version      | TEST_median_absolute_error in  | TRAIN_median_absolute_error | Difference |
|----------------------|--------------------------------|-----------------------------|------------|
| DecisionTree V3.0    | 1.89 (+/- 0.14)                | 1.67 (+/- 0.06)             | 0.29       |
| DecisionTree V3.1    | 2.23 (+/- 0.14)                | 1.89 (+/- 0.03)             | 0.34       |
| RandomForest V3.0    | 1.56 (+/- 0.10)                | 1.24 (+/- 0.01)             | 0.32       |
| RandomForest V3.1    | 1.61 (+/- 0.09)                | 1.24 (+/- 0.01)             | 0.37       |
_Table 2: Final results after hyperparameter tuning and cross-validation for use case 2_

Contrary to use case 1, wind data did not make a significant difference when predicting pm10 values based on past no, no2, nox,
pm10 and pm2.5. However, the impact of pm10 and pm2.5 is outstanding, leading to a difference of 4.47μg/m³ in test median absolute error
comparing RandomForest V3.0 use case 1 and RandomForest V3.0 use case 2. Additionally, the overfitting was severely reduced.

###### Use Case 3
Use case 3, imputation of missing historical data, utilises a different versioning system. Both version include the value of 
no2, no, nox of the current hour, and datetime features. However, in version 1, additionally to the pm10 and pm2.5 values of the previous hour,
the values of the previous hour of the previously mentioned particles were used. Whereas in the second version only the
pm10 and pm2.5 values of the previous hour and no2, no, and nox of the current hour were utilised as input features. The results for
use case 3 are presented in table 3. Similar to use case 2 no model exhibits strong overfitting, therefore the decision of the best
model will be made based on the test median absolute error. This results in RandomForestRegressor V1 being the best performing model.


The input features and hyperparameter of RandomForestRegressor V1 are the following: 
<br>
- **Input features:** hour, day, month, year, day_of_week, is_weekend, no2, no, nox, no2_h-1, no_h-1, nox_h-1, pm10_h-1, pm2.5_h-1
<br>
- **Hyperparameter:** max_depth=20, max_features='sqrt', min_samples_leaf=5, random_state=123

| Model + Version | TEST_median_absolute_error | TRAIN_median_absolute_error | Difference |
|-----------------|----------------------------|-----------------------------|------------|
| DecisionTree V1 | 1.89 (+/- 0.15)            | 1.63 (+/- 0.04)             | 0.26       |
| DecisionTree V2 | 1.86 (+/- 0.14)            | 1.61 (+/- 0.04)             | 0.25       |
| RandomForest V1 | 1.54 (+/- 0.11)            | 1.09 (+/- 0.01)             | 0.45       |
| RandomForest V2 | 1.55 (+/- 0.12)            | 1.28 (+/- 0.01)             | 0.27       |
_Table 3: Final results after hyperparameter tuning and cross-validation for use case 3_

This shows that the imputation of pm10 based on the previous hour is possible with a with an accuracy that meets the expectations
of test median absolute error < 2μg/m³ and overfitting rate < 0.5μg/m³. Nevertheless, longer periods of missing data are not able
to be predicted by barely using this model. To achieve that goal a model predicting pm2.5 needs to be developed and 
iteratively applied with the model of pm10 imputation. This way the predictions of pm10 and pm2.5 can be used as input for
the prediction of the next hour. 

### 5. Conclusion #TODO


### 6. Limitations & Future Possibilities 
###### _Data Limitations_
One of the main issue for utilising the trained model is the different data availability at each weather station in Berlin. 
For example mc282 - Karlshorst does not measure pm10 nor pm2.5 and is therefore not included in the stations the model can be applied to. 
In addition, multiple null values left gaps in the training data since data imputation was not feasible in the beginning and all null data was dropped. 
Finally, the utilised API only publishes the data for the previous hour around 20 minutes after the hour has passed; however, this is not always exactly timed. This leads to problems when real time data is needed at an exact time.

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
<br>
Additionally, the repository could be resturctured and clean in a way that the data files are not scattered in multiple directories
to make navigating and using the data more efficient.