### 1. Introduction
###### _Context and Motivation_ 

Pm10, abbreviation of particle matter 10, is an air particle with a diameter of less than 10µm and is measured in micrograms per cubic meter (μg/m³). Although it seems 
the majority of people are not aware of it, pm10 can cause severe short and long term health issues.

Short term health complications include:
- Irritated eyes, nose and throat
- Worsening of asthma and lung diseases 
- Increased risk of heart attacks and arrhythmias in people with heart disease

Whereas long term health risks include:
- Reduced lung function
- Development of cardiovascular and respiratory diseases
- Increased rate of disease progression
- Reduction in life expectancy [^1]

I personally came into contact with the topic of air quality in 2017/18 when I spend 6 month in China. Especially in the winter 
months the air got so bad that even opening the windows was strongly advised against. This experience caused me to be more aware
of potential harm caused by bad air quality even years after. 

The motivation of this project is to bring more awareness of the effect of air quality to both my classmates and people using my 
application. Additionally, the final models should support the knowledge base of pm10 values in Berlin and help make informed
decisions about activities and protective measures. To define the exact goals of the project two problem statements and two use cases were developed.


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
The models were developed in Jupyter Notebook using Python 3.11.8. 
Additionally, to organise the virtual environments Anaconda was used. 
All required dependencies for the project can be found in the following file: 
[conda_dependencies.yaml](https://github.com/Aiiii-den/ml_pm10/blob/main/configs/conda_dependencies.yaml)

### 2. Methodology

###### _Data Acquisition & Description_
**Air particle data** 
<br>
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
**Air particle data** 

_Data Cleaning:_ For the air particle data all null values were dropped after careful consideration.

_Feature Engineering:_ Six new features were extracted from the datetime column to provide a clearer understanding of 
how different aspects of the datetime information influence the model. These six features are:
_hour_, _day_, _month_, _year_, _day_of_week_, and _is_weekend_

**Wind data**

_Data Cleaning:_ For the wind data no cleaning was required because the data did not have any missing values.

_Feature Engineering:_ No new features were added; however, the columns _WINDGESCHWINDIGKEIT_ and _WINDRICHTUNG_ were
renamed to _wind_speed_ and _wind_direction_.
<br>

The final dataframe after data cleaning, feature engineering and merging the air particle data and wind data
is shown in figure 1.

![Complete Dataframe](https://github.com/Aiiii-den/ml_pm10/blob/main/archive/final_presentation/media/heatmaps/df_merged.png?raw=true)

_Figure 1: Overview of the complete dataframe after data pre-processing and feature engineering_

###### _Machine Learning Models_ 
For this project the following three regression models where selected: k-NN (k-nearest neighbors), Decision Tree and Random Forest. 
K-NN was chosen for its simplicity and small amount of hyperparameters to tune. Additionally, decision tree and random forest
were selected for their efficient handling collinearity and the interpretability of their results. Although predictions of 
random forests are more difficult to interpret, the algorithm is less prone to overfitting and more accurate and robust than
the decision tree algorithm. [^2]

For the hyperparameter tuning of the decision tree and random forest algorithm the following param grid is used:
``` python 
param_grid = {
    'max_depth': range(5, 35, 5), #for decision tree & range(5, 50, 5) for random forest
    'min_samples_leaf': [5, 10, 15, 20, 25, 30, 40, 50],
    'max_features': ["sqrt", "log2"], 
    'random_state': [123]
}
```

###### _Model Evaluation_ 
For validation a 5-fold cross-validation was applied to prevent overfitting and ensure that the model performs well on
training and test data. For the evaluation metrics the following scorers were utilised:
``` python 
scorers = {
    'mean_absolute_error': make_scorer(mean_absolute_error, greater_is_better=False),
    'median_absolute_error': make_scorer(median_absolute_error, greater_is_better=False),
    'root_mean_squared_error': make_scorer(root_mean_squared_error, greater_is_better=False),
    'mean_squared_error': make_scorer(mean_squared_error, greater_is_better=False)
}
```
Although mean absolute error, median absolute error, root mean squared error and mean squared error were assest, the final decision of
model performance based on the median absolute error. This metric was selected because of many unexplainable outliers in pm10
measurements, due to events, dust storms, etc. Therefore, the median absolute error seemed the most appropriate point of measurement.
<br> The acceptance criteria for the applicability of the model are deviance rate test median absolute error to median value of the training set <= 10%
and overfitting/underfitting rate (|test median absolute error - train median absolute error|) <= 0.5μg/m³.

### 3. Sprint Overview #TODO
The project consist of 11 sprints running from April 4th 2024 to September 23rd 2024, excluding a summer break from 29.07. - 19.08. 
The sprint planning was structured according to the ML development cycle by Microsoft. [^3]
This cycle includes five phases:
Business Understanding, Data Acquisition & Understanding, Feature Engineering, Modelling, Deployment and Customer Acceptance. Although the model proposes a 
circular and iterative development lifecycle this project was done in the following order, excluding the last phase of the original lifecycle:
1. Business Understanding (Phase 1)
2. Data Acquisition & Understanding (Phase 2)
3. Modelling (Phase 3)
4. Deployment (Phase 4)

###### Sprint 1: Data Research & Acquisition (Phase 1 & 2)
The first sprint focused on deciding on a project idea and researching quality data sets. At the end of the sprint the decision
to predict pm10 based on a dataset from Berlin Open Data.
<br> For more details please refer to the [sprint 1 documentation](https://github.com/Aiiii-den/ml_pm10/blob/main/sprint_1/01_use_case-data_research.md) 
file.

###### Sprint 2: Data Exploration (Phase 2)
Following the decision on the data source, first data analysis were conducted based on data from the weather station
mc010 Berlin Wedding. This includes visualisations of the months December 2022, March 2023 and March 2024. This enabled
the first irregular finding of pm10 values at the end of March 2023. At this point the Easter weekend is suspected to have caused 
the sudden spike.
<br>
Additionally, a first decision on using time series prediction for the project was made.
<br>
For more details please refer to the [sprint 2 documentation](https://github.com/Aiiii-den/ml_pm10/blob/main/sprint_2/02_data_exploration_1.md) 
file.

###### Sprint 3: Data Exploration (Phase 2)
The third sprint focussed on finding further spikes in pm10 caused by public holidays with special celebratory habits. To make sure 
the abnormal values in March 2023 were not a singular occurrence March 2024
Furthermore, online research lead to a study from the city Hamburg about the effect of pm10 values. The study can be found here:  
https://www.hamburg.de/resource/blob/847144/d0e93dd9d86723c7f3c549f30da2a96d/pdf-osterfeuerbericht-2024-data.pdf
<br>
In addition, New Years Eve 2023/24 was analysed and visualised to provide a better understanding of the influence of 
fireworks and pyrotechnics on pm10 levels.
<br> Lastly, it was decided to use Facebook/Metas Prophet library for time series prediction.
<br> For more details please refer to the [sprint 3 documentation](https://github.com/Aiiii-den/ml_pm10/blob/main/sprint_3/03_data_exploration_2.md) 
file.

###### Sprint 4: Data Exploration (Phase 2)
The fourth sprint was used to go on a deep dive of the Easter weekend, including a detailed analysis and visualisation of 
Easter 2024, from Friday to Sunday.
Furthermore, a python script was implemented to request hourly data from the station mc124 Berlin Tempelhof-Schöneberg from January 1st 2008 to Mai 31sr 2024.
However, in this sprint the first challenge occurred, caused by time-zone changes from daylight savings time. The different
timezones in the datetime feature cause visualisations to throw errors. A first quick solution of converting the datetime to UTC
was implemented.
<br> For more details please refer to the [sprint 4 documentation](https://github.com/Aiiii-den/ml_pm10/blob/main/sprint_4/04_in_depth_data_exploration_1.md) 
file.

###### Sprint 5: Data Exploration and Feature Engineering (Phase 2 & 3)
During sprint 5 a detailed comparison of New Year's air quality from 2023 to 2024 was performed, 
along with an annual analysis from 2016 to 2024, showing total PM10, average PM10, and PM10 counts. 
Additionally, monthly comparisons of average PM10 were visualized, leading to a deep dive into November 2022 due to 
significant spikes of pm10 in November 2022.
Afterward, null values in the air quality data were analyzed, and the previous mentioned time zone issue was resolved by 
removing time zone information from the datetime field altogether. 
Finally, wind data was explored, and a heatmap was created to show correlations between PM10, wind speed, and wind direction.
<br> For more details please refer to the [sprint 5 documentation](https://github.com/Aiiii-den/ml_pm10/blob/main/sprint_5/05_in_depth_data_exploration_2.md) 
file.

###### Sprint 6: Data Exploration, Feature Engineering, Model Selection (Phase 2 & 3)
The main aspects of sprint 6 were the merging of air quality data and wind data to create heatmap.
This heatmap was utilised to explore correlations between air particles and wind speed.
Furthermore, the decision to switch from time series prediction to regression based models was made.
<br> For more details please refer to the [sprint 6 documentation](https://github.com/Aiiii-den/ml_pm10/blob/main/sprint_6/06_in_depth_data_exploration_3.md) 
file.

###### Sprint 7: Data Exploration & Model Training + Evaluation (Phase 2 & 3)
Sprint 7 was focused on model training and evaluation after 
created a heatmap showing the correlation between the hour of day, month, year, day, weekends and pm10.
During this sprint versions 1.0 and 1.1 of use case 1 for decision tree, random forest, and kNN were trained and evaluated.
<br> For more details and results please refer to the [sprint 7 documentation](https://github.com/Aiiii-den/ml_pm10/blob/main/sprint_7/07_more_heatmaps_and_start_training.md) 
file.

###### Sprint 8: Model Training + Evaluation (Phase 3)
The eights sprint was used to train and evaluate use case 1 V2.0 for decision tree and random forest.
<br> For more details and results please refer to the [sprint 8 documentation](https://github.com/Aiiii-den/ml_pm10/blob/main/sprint_8/08_training.md) 
file.

###### Sprint 9: Model Training + Evaluation (Phase 3)
During sprint 9 V3.0 and V3.1 of use case 1 were trained and evaluated using both decision tree and random forest models. 
Similarly, use V3.0 and V3.1 of use case 2 underwent the same process. 
Finally, use both versions of use case 3 were trained and evaluated using both decision tree and random forest models as well.
The use case and model used for final testing and deployment via the streamlit app is version has been selected based 
on the best performing model.
<br> For more details and results please refer to the [sprint 9 documentation](https://github.com/Aiiii-den/ml_pm10/blob/main/sprint_9/09_training.md) 
file.

###### Sprint 10: Final Testing and Model Comparison (Phase 3)
Sprint 10 main focus was testing and evaluation the performance of the previously selected final model.
The model was tested on four stations: mc124 (the original station), mc190 (in the same category as mc124, traffic),
mc010 (a different category, residential area), and mc032 (a different category, city outskirts). 
The deviation range across these stations was visualized in a bar chart, and the machine learning model was 
exported as both a .pkl and a .joblib file for future use.
<br> For more details and results please refer to the [sprint 10 documentation](https://github.com/Aiiii-den/ml_pm10/blob/main/sprint_10/10_testing.md) 
file.

###### Sprint 11: Streamlit App Development + Deployment (Phase 4)
The sole focus of sprint 11 was the development and deployment of the mandatory streamlit app.
The webapp can be divided into two parts: the prediction of the next pm10 value at a specific weather station, including its
health risk score and the median absolute error of the prediction for the previous hour. The prediction is either for the current
or the next hour, depending on the latest data point published by the station. The pm10 value of the previous hour mark is
usually available after 20 minutes.  This means for the first 20min the model will predict the value of the previous hour. 
Afterward the value for the next hour will be predicted.

The second part of the app is the visualisation of historic data. The user can select between comparing yearly averages, 
monthly averages, daily averages and hourly averages. The available range of data depends on the specific weather station.
For mc124 Tempelhof-Schöneberg, the station used to train the model, data is available from 2016 to now. Whereas for MCSI
the earliest measurement of pm10 occurred in 2020.

The main challenge of the app development was dealing with cached data and storing thousands of data points. The current
solution loads all data from January 1st 2014 to September 20th 2024 on deployment. Afterward, the system checks if new data
is available and adds it to the existing data. Another approach could have been storing historic data in a csv file and updating
it everytime new data is available. Additionally, when the Update Data button is clicked the website sometimes glitches and shows
the second half of the page twice. This is assumed to be caused by the API call responses being processed.

Additionally, the documentation for the project was written in sprint 11 and the repository was restructured and cleaned up.

### 4. Analysis & Discussion

###### Use Case 1
An overview of the results for training and testing Decision Tree Regression, Random Forest Regression and k-Nearest-Neighbor 
can be found in table 1. Each machine learning model is annotated with the version of input features used.
Version 1 focuses on datetime features only. Version 2 adds wind data and version three utilises datetime, fine dust and 
in one sub-version wind data. For a more detailed explanation please refer to the [versioning information](https://github.com/Aiiii-den/ml_pm10/blob/main/sprint_9/uc1_versioning_information_v2.md) file.
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

Following the training and evaluation the best performing model (RandomForestRegressor V3.0) was used to for final testing at 
four station with yet unknown data for the model. The stations include: 
1. mc124 Tempelhof-Schöneberg (original station)
2. mc190 Wedding - same category as mc124 (traffic)
3. mc010 Wedding - different category as mc124 (residential area)
4. mc032 Grunewald - different category as mc124 (city outskirt)

As seen in table 3, the model performs best at mc124 and mc190, both stations of the category traffic. Furthermore, it performed 
the worst at station mc032 with a deviation of around ~10.6%. This does not meet the previously set requirements of median absolute
error < 10%. This is most likely caused by the difference of locations, because mc032 is marked as a forest station and therefore
influences the air particles more strongly than stations in residential areas (like mc010).

| Station | Median pm10 value | Median absolute error | Possible deviation range |
|---------|-------------------|-----------------------|--------------------------|
| mc124   | 18.00             | 1.40                  | 16.60 - 19.40            |
| mc190   | 18.00             | 1.33                  | 16.67 - 19.33            |
| mc010   | 14.00             | 1.23                  | 12.77 - 15.23            |
| mc032   | 11.00             | 1.17                  | 09.83 - 12.17            |

_Table 3: Final results of applying the model to new data from four different stations_

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

_Table 4: Final results after hyperparameter tuning and cross-validation for use case 3_

This shows that the imputation of pm10 based on the previous hour is possible with a with an accuracy that meets the expectations
of test median absolute error < 2μg/m³ and overfitting rate < 0.5μg/m³. Nevertheless, longer periods of missing data are not able
to be predicted by barely using this model. To achieve that goal a model predicting pm2.5 needs to be developed and 
iteratively applied with the model of pm10 imputation. This way the predictions of pm10 and pm2.5 can be used as input for
the prediction of the next hour. 

### 5. Conclusion 
As stated in the analysis and discussion section, use case 1 was not successful,
as none of the models met the acceptance criteria. This indicates that while PM10 shows significant correlations with 
other air particles, it is insufficient to predict PM10 based solely on these other particles.


In contrast, use case 2 met both acceptance criteria for stations categorized as traffic and residential areas (background). 
Although the station in the city outskirts (suburbs) slightly missed the acceptance criteria, 
it is not possible to generalize these results, as mc032 is a specialized weather station located directly in a forest. 
Further testing with additional weather stations is needed to make a final decision regarding the model's applicability 
in suburban areas.


Finally, use case 3 demonstrated partial success, as it effectively imputed data for a single missing hour. 
However, to handle longer periods of missing data, an additional PM2.5 model is required, 
as both PM10 and PM2.5 are necessary for accurate predictions. 
With both models, longer gaps in data could be filled using an iterative approach, 
where the prediction from the previous hour serves as input for the next.


### 6. Limitations & Future Possibilities 
###### _Data Limitations_
One of the main issue for utilising the trained model is the different data availability at each weather station in Berlin. 
For example mc282 - Karlshorst does not measure pm10 nor pm2.5 and is therefore not included in the stations the model can be applied to. 
In addition, multiple null values left gaps in the training data since data imputation was not feasible in the beginning and all null data was dropped. 
Finally, the utilised API only publishes the data for the previous hour around 20 minutes after the hour has passed; however, this is not always exactly timed. This leads to problems when real time data is needed at an exact time.

###### _Model Constraints_
While Random Forest Regression had the best result for most use cases and versions, it is computationally more expensive and takes longer to hyper-validate and train than the slightly weaker performing Decision Tree Regression model.
<br> Additionally, the current model has been trained on data until Mai 2024 and is not being automatically retrained on new data.
This retraining would be necessary in the long run to take current pm10 developments into account for future predictions.

###### _Future Possibilities_
To improve use case 1, the particle O₃ could be added to the training features due to its strong correlation with PM10. 
This was not done initially because the chosen weather station for training the model does not measure O₃.


Furthermore, incorporating additional data points for use case 2, such as traffic data near the weather stations and 
more detailed wind and weather data (e.g., humidity, rainfall, etc.), could be beneficial. 
Additionally, the model could be trained to predict PM10 values further into the future by using various increments 
of past data points. For example, training on h-2 to predict values two hours ahead.


Regarding use case 3, an iterative approach seems appropriate, as currently, only the first missing hour is predictable. 
To completely fill all missing values, including longer time periods, the trained model could be utilised to 
incrementally predict each value one by one, using the predicted value as input for the next prediction. 
Moreover, additional functionality could be added to the Streamlit app, such as displaying the thresholds for pm10 
measurements according to the EU and/or WHO within the line graphs.


Finally, the repository could be restructured and organized to ensure that the data files are not scattered across multiple directories. 
This would enhance navigation and efficient use of the data.


----

### Sources
[^1]: https://www.health.nsw.gov.au/environment/air/Pages/particulate-matter.aspx
[^2]: https://towardsdatascience.com/comparative-study-on-classic-machine-learning-algorithms-24f9ff6ab222
[^3]: https://learn.microsoft.com/en-us/azure/architecture/data-science-process/overview
