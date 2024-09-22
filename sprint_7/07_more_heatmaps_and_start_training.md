### Sprint 7: 01.07. - 14.07.2024

#### Phase Two - Data acquisition and exploration:
__Part 7:__ 
- created a heatmap showing the correlation between the hour of day, month, year, day, weekends and pm10
    - year huge negative correlation -> pm10 has decreased over the years
    - the latter in the week the less pm10 as well
    - on weekends less pm10 than on weekdays

#### Decisions:
- train the model Vx.1 with the datetime information of 'hour', 'day of the week', 'year' and 'is_weekend'

#### Next step:
- Start training and validating regression models 

#### Phase Three - Training and validating:
__Part 1:__
##### 1.0 prediction based on all datetime data (hour, day of week, month, year, is_weekend) - version 1.0
- regression models trained and hyperparameter tuned on all datetime features
  - **Decision Tree:** decent accuracy, no underfitting or overfitting
      - best results: DecisionTreeRegressor(max_depth=5, max_features='sqrt', min_samples_leaf=5,
                      random_state=123)
      - test_median_absolute_error: 6.93 (+/- 0.34)
      - train_median_absolute_error: 6.49 (+/- 0.15)
      - overfitting: no (very little difference between train and test median absolute error)
      - comparison to other models: similar result for test data like decision tree
  - **Random Forest:** takes forever to train (laptop is struggling) ~50min
      - best results: RandomForestRegressor(max_depth=10, max_features='sqrt', min_samples_leaf=50,
                      random_state=123) 
      - test_median_absolute_error: 6.83 (+/- 0.42)
      - train_median_absolute_error: 5.64 (+/- 0.09)
      - overfitting: slight overfitting
      - comparison to other models: best test_median_absolute_error
  - **kNN:** worst test_median_absolute_error, 
      - best results: KNeighborsRegressor(leaf_size=15, n_neighbors=15, weights='uniform')
      - test_median_absolute_error: 7.04 (+/- 0.37)
      - train_median_absolute_error: 4.72 (+/- 0.14)
      - overfitting: strong overfitting,
      - comparison to other models: worst result for test data --> dropped from now on
        
##### 1.1 prediction based on specific datetime data (hour, day of week, month, year, is_weekend) - version 1.1
- regression models trained and hyperparameter tuned on datetime features which show correlation to pm10 (>0.1) to show if all datetime data are necessary
    - http://localhost:8888/notebooks/project/sprint_7/heatmap_plotting_datetime_pm10/all_datetime_features_comparison.ipynb
  - **Decision Tree:** 
      - best results: DecisionTreeRegressor(max_depth=10, max_features='sqrt', min_samples_leaf=40,
                      random_state=123)
      - test_median_absolute_error: 7.41 (+/- 0.43)
      - train_median_absolute_error: 6.73 (+/- 0.14)
      - overfitting: little overfitting
      - comparison to other models: similar results to kNN for test and random forest for train, worse than v1.1
  - **Random Forest:** 
      - best results: RandomForestRegressor(max_depth=5, max_features='sqrt', min_samples_leaf=50,
                      random_state=123)
      - test_median_absolute_error: 7.11 (+/- 0.44)
      - train_median_absolute_error: 6.86 (+/- 0.14)
      - overfitting: minimal overfitting 
      - comparison to other models: best model for v1.1 but still worse than v1.0
  - **kNN:**  
      - best results: KNeighborsRegressor(leaf_size=5, n_neighbors=5, weights='uniform')
      - test_median_absolute_error: 7.44 (+/- 0.39)
      - train_median_absolute_error: 7.44 (+/- 0.32)
      - overfitting: none
      - comparison to other models: worst results of them all 

#### Decisions:
- data cleaning: drop all null values
- use "median absolute error" as main evaluation value between models -> not so much influence of new year, easter, etc.
    - goal: median_absolute_error below 5.0 
- **train & validate v.1:**
    - drop kNN for future versions of model training - from v2.0 onwards (worst test median absolute error, biggest overfitting)
    - use all datetime features since all models of v1.1 performed worse than the v1.0 equivalent

#### TODO for v.2.x:
- Windgeschwindigkeit
- Richtungskategorie eigenes features (siehe lineare Regression) (is_ea, is_ew, ...)
- Datenaufbereitung: neues Feature von der Zeile/Stunde davor bzw aggregieren (ist aber schwieriger) -- USE CASE 1 mit Winddaten

#### KEEP IN MIND:
- potential regression models: 
    - Decision Tree
    - Random Forest
    - Knn
    - Lineare Regression

- categorisation of weekdays for linear models needs to be a new column for each value
    - is_monday, is_tuesday, is_wednesday, is_thursday, is_friday, is_saturday, is_sunday
