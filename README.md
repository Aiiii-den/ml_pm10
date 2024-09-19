##### 1. Introduction (0.5 pages)
_Context and Motivation_ #TODO what is pm10, which health issues does it cause, 

_Problem Statements_ This project focusses on three different use cases. The first two focus on predicting pm10 values of the future whereas the third use cas has the goal of imputating missing historic data.

**Use Case 1:** Predicting the pm10 value of the next hour without historic pm10 and pm2.5 data outcomes without historic data, exclusively based on correlating measured data points

**Use Case 2:** Predicting the pm10 value of the next hour by including historic pm10 and pm2.5 as well as correlating data points.

**Use Case 3:** Imputing missing pm10 values based on historic pm10 and correlating data points

_Objective_ #TODO State the objectives of your project in the context of these three cases:
    "The goal is to develop predictive models for each use case, evaluate their performance, and identify the best strategy for handling data with varying levels of completeness."

_Applied Technologies_ The models were developed in Jupyter Notebook using Python 3.11.8. Additionally, to organise the virtual environments Anaconda was used. All required dependencies for the project can be found in the following file: anaconda_dependencies.yaml
##### 2. Methodology (1.5-2 pages)

###### _Data Acquisition & Description_
**Air particle data** #TODO add location and category etc of the mc124 station
The data was acquired through an open-data API provided by the city of Berlin. An overview of the API can be found under the following link: https://luftdaten.berlin.de/api/doc.
The model was trained on data from the station with the station code mc124. This weather station is categorised as a traffic station type and is located at Mariendorfer Damm 148, Tempelhof-Schöneberg, 12099 Berlin.
More information about the weather station can be found here: https://luftdaten.berlin.de/station/mc124#station-info
Mc124 in Tempelhof-Schöneberg provides the following data points:
- datetime
- station
- core
- component
- period
- value

Core contains the different air particles which are measured. Moreover, component contains the core and its period. For more details please refer to the official documentation or use the following API call:

``` curl
https://luftdaten.berlin.de/api/stations/mc124/data
```

Key features for the model development are the datetime and every value associated with the period of "1h". These include pm10, pm2 (short for pm2.5), no2 (nitrogen dioxide), no (nitrogen monoxide) and nox (nitrogen oxide).

To efficiently request the data from 2016 to 2024 a script 
```
(.scripts_data_acquision\Hourly_script_mc124_tempelhof-schöneberg.ipynb")
```
was deployed to iterate through each month.

**Wind data** #TODO add location of the weather station and figure out who provides it
The wind data is provided as open-data by the 'Deutscher Wetterdienst' (German weather service)
The data was initially downloaded manually as a zip file named 'stundenwerte_wind_399_akt' from the following website: https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate_urban/hourly/wind/recent/.
However, later on the data was acquired using an automated script 
```
".scripts_data_acquision\download_and_process_recent_wind.sh"
```
The file ''stundenwerte_wind_399_akt' includes the wind information for the at Berlin Alexanderplatz at a height of 37 meter.
The data includes the following columns: 
- STATIONS_ID - engl.: station_id
- MESS_DATUM - engl.: date of measurement
- QUALITAETS_NIVEAU - engl.: quality of measurement
- STRUKTUR_VERSION - engl.: version of structure
- WINDGESCHWINDIGKEIT - engl.: wind speed
- WINDRICHTUNG - engl.: wind direction
- eor - engl.: eor
Out of those the date of measurement, wind speed and wind direction were used as input features for training the model by being merged with the air particle data based on the date of measurement/datetime.

###### _Data Preprocessing and Engineering_
**Air particle data** #TODO
Data Cleaning: Explain the steps you took to clean the data.
Feature Engineering: Discuss any features you created or modified.
Train-Test Splitting: Detail how the data was split into training and test sets
Sprint Tie-In: Mention that Sprints 2 and 3 were dedicated to data cleaning and feature engineering. These sprints addressed handling missing values, outliers, and creating new features to improve model performance.

**Wind data** #TODO
Data Cleaning: Explain the steps you took to clean the data.
Feature Engineering: Discuss any features you created or modified.
Train-Test Splitting: Detail how the data was split into training and test sets
Sprint Tie-In: Mention that Sprints 2 and 3 were dedicated to data cleaning and feature engineering. These sprints addressed handling missing values, outliers, and creating new features to improve model performance.
###### _Machine Learning Models_ #TODO
Model Selection: Describe the models you chose and why.
Rationale: Explain your reasoning behind choosing these models.
Hyperparameter Tuning: Detail the strategies used to tune the models.
Sprint Tie-In: Sprints 4 to 6 covered model selection, baseline testing, and hyperparameter tuning. You can mention that Sprint 4 focused on trying out different models, Sprint 5 evaluated the models’ baseline performances, and Sprint 6 handled hyperparameter tuning using techniques like grid search and randomized search.

###### _Model Evaluation_ #TODO
Cross-Validation: Detail the cross-validation strategy used.
	Example: “5-fold cross-validation was used to prevent overfitting and ensure the model generalized well.”
Evaluation Metrics: Describe the metrics used to assess model performance.
Sprint Tie-In: Sprints 7 and 8 focused on model evaluation and testing strategies. Sprint 7 implemented cross-validation, while Sprint 8 measured and compared the models using RMSE, MAE, and R-squared values.
##### 3. Sprint Overview (3-5 pages) #TODO
This is the heart of your report. Each sprint should be described in detail, with a focus on specific tasks, challenges, and outcomes. You mentioned that each sprint would be about 5-10 sentences, but feel free to expand where necessary.
Example Breakdown of Sprints:

**Sprint 1: Data Research & Acquisition (Phase 1)**
    Task: Gathering the data and performing an initial exploratory analysis.
    Outcome: Found several missing values and skewed data distributions in key features like ‘price’ and ‘house size’.
	NOT IN THE FIRST but Erkenntnis, dass Neujahr und Ostern große pm10 Mengen verursachen -- Link zur Studie zu Ostern in Hamburg (https://luft.hamburg.de/resource/blob/774550/528d6ac03e2a09cd495dd8b5c54bec80/bericht-osterfeuer-feinstaub-hamburg-2023-data.pdf)

**Sprint 2: Data Exploration (Phase 2)**
    Task: Removing duplicates and handling missing data.
    Outcome: Imputed missing values for ‘year built’ and removed extreme outliers from the ‘price’ column.

**Sprint 3: Data Exploration & Model Selection (Phase 2)**
    Task: Creating new features and transforming existing ones.
    Outcome: Engineered a ‘price per square foot’ feature and encoded categorical variables like ‘location’ using one-hot encoding.

**Sprint 4: Data Exploration (Phase 2)**
    Task: Selecting candidate models for testing.
    Outcome: Chose Linear Regression, Random Forest, and XGBoost for testing based on their strengths with tabular data.

**Sprint 5: Data Exploration and Feature Engineering (Phase 2)**
    Task: Evaluating baseline performance without tuning.
    Outcome: Random Forest performed better than Linear Regression, with an RMSE of 600 compared to 800.

**Sprint 6: Data Exploration, Feature Engineering, Model Selection (Phase 2)**
    Task: Improving model performance through hyperparameter tuning.
    Outcome: Grid search improved Random Forest's RMSE to 550, and XGBoost’s RMSE dropped to 500.

**Sprint 7: Data Exploration & Model Training + Evaluation (Phase 2 & 3)**
    Task: Applying cross-validation for more robust performance evaluation.
    Outcome: 5-fold cross-validation confirmed that the models were not overfitting and performed consistently across folds.

**Sprint 8: Model Training + Evaluation (Phase 3)**
    Task: Comparing final models using the test set.
    Outcome: XGBoost outperformed Random Forest, with an RMSE of 490 on the test set.

**Sprint 9: Model Training + Evaluation (Phase 3)**
    Task: Analyzing which features were most important to the models.
    Outcome: ‘Location’ and ‘size of the house’ were identified as the top two most predictive features in Random Forest.

**Sprint 10: Final Testing and Model Comparison (Phase 3)**
    Task: Summarizing the results and concluding the model comparison.
    Outcome: XGBoost was identified as the best-performing model, and Random Forest showed strong interpretability with feature importance analysis.
	
**Sprint 11: Streamlit App Development + Deployment (Phase 4)**
- describe what can be done and seen in the app
- explain situation with only getting the data of the past hour 20 min after it's past
- Model currently trained on data until Mai 2024, could be retrained every month to stay up to date
##### 4. Analysis & Discussion (1-2 pages) #TODO

**Use Case 1**
Structure:
    Model Performance:
        Summarize the performance of each model.
        Example: “Random Forest and XGBoost significantly outperformed Linear Regression, with XGBoost achieving the best RMSE of 490.”
    Insights Gained:
        Discuss what you learned from the feature importance analysis.
        Example: “Location had the highest feature importance, confirming that real estate prices are heavily influenced by geographic location.”
    Visuals: Present tables or graphs that show model performance, feature importance, or other key insights.

**Use Case 2**
Structure:
    Model Performance:
        Summarize the performance of each model.
        Example: “Random Forest and XGBoost significantly outperformed Linear Regression, with XGBoost achieving the best RMSE of 490.”
    Insights Gained:
        Discuss what you learned from the feature importance analysis.
        Example: “Location had the highest feature importance, confirming that real estate prices are heavily influenced by geographic location.”
    Visuals: Present tables or graphs that show model performance, feature importance, or other key insights.

**Use Case 3**
Structure:
    Model Performance:
        Summarize the performance of each model.
        Example: “Random Forest and XGBoost significantly outperformed Linear Regression, with XGBoost achieving the best RMSE of 490.”
    Insights Gained:
        Discuss what you learned from the feature importance analysis.
        Example: “Location had the highest feature importance, confirming that real estate prices are heavily influenced by geographic location.”
    Visuals: Present tables or graphs that show model performance, feature importance, or other key insights.

##### 5. Limitations & Future Possibilities (0.5-1 page)
###### _Data Limitations_
One of the main issue for utilising the trained model is the different data availability at each weather station in Berlin. For example mc282 - Karlshorst does not measure pm10 nor pm2.5 and is therefore not included in the stations the model can be applied to. In addition, multiple null values left gaps in the training data since data imputation was not feasable in the beginning and all null data was dropped. Finally, the utilised API only publishes the data for the previous hour around 20 minutes after the hour has passed; however, this is not always exactly timed. This leads to problems when real time data is needed at an exact time.

###### _Model Constraints_
While Random Forest Regression had the best result for most use cases and versions, it is computationally more expensive and takes longer to hypervalidate and train than the slightly weaker performing Decision Tree Regression model.

###### _Future Possibilities_
To improve use case 1 the particle O₃ could be added to the training features, due to its very high correlation to pm10. This was not done intially because the chosen weather station for training the model does not measure O₃.
Furthermore additional data points use case 2, for example traffic data near the weather stations and more detailed wind and weather data (f.e. humidity, rainfall, etc.) could be beneficial. Moreover, the model could be trained to predict pm10 values further in the future by using different increments of data points of the past. For example, training on h-2 to predict values two hours into the future.
In regards to use case 3 an iteratively approach seems appropriate because as of now only the first missing hour is able to be predicted. To completely fill all missing values, including longer time periods, the trained model could be used to incrementally predict each value one by one and utilise the predicted value as input for the following prediction.	Additionally, more functionality could be added to the Streamlit app. For example the treshhold for pm10 measurements according to the EU and/or WHO within the line graphs.
