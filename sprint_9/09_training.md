### Sprint 9: 19.08. - 01.09.2024

#### Phase Three - Training and validating:
__Part 3:__
##### UC1 V3.0 prediction based on all datetime features, all other fine dust measurements
- regression models trained and hyperparameter tuned on all datetime features and fine dust(h-1) 
  - **Decision Tree:** 
      - best results: DecisionTreeRegressor(max_depth=15, max_features='sqrt', min_samples_leaf=50, random_state=123)
      - test_median_absolute_error: 6.40 (+/- 0.48)
      - train_median_absolute_error: 5.34 (+/- 0.11)
      - overfitting: yes (difference of 1.06)
- comparison to other model: nr 1 due to less overfitting
  - **Random Forest:** 
      - best results: RandomForestRegressor(max_depth=25, max_features='sqrt', min_samples_leaf=5, random_state=123)
      - test_median_absolute_error: 6.03 (+/- 0.50)
      - train_median_absolute_error: 3.24 (+/- 0.03)
      - overfitting: strong overfitting (difference of 2.79)
      - comparison to other model: nr 2 due to strong overfitting
   
##### UC1 V3.1 prediction based on all datetime features, wind data, all other fine dust measurements
- regression models trained and hyperparameter tuned on all datetime features, wind data(h-1) and fine dust(h-1) 
  - **Decision Tree:** 
      - best results: DecisionTreeRegressor(max_depth=10, max_features='sqrt', min_samples_leaf=40, random_state=123)
      - test_median_absolute_error: 5.94 (+/- 0.49)
      - train_median_absolute_error: 5.24 (+/- 0.13)
      - overfitting: slightly (difference of 0.70)
      - comparison to other model: nr 1 because of less overfitting
  - **Random Forest:** 
      - best results: RandomForestRegressor(max_depth=35, max_features='sqrt', min_samples_leaf=5, random_state=123)
      - test_median_absolute_error: 5.51 (+/- 0.38)
      - train_median_absolute_error: 2.92 (+/- 0.05)
      - overfitting: strong (difference of 2.59)
      - comparison to other model: ne 2 because of strong overfitting

----------------------------------------------------------------
_comment:_ Use Case two has been trained by using all available data at the weather station (including pm10, pm2.5)
           The versioning numbers have been kept the same as for use case 1 to avoid further confusion

##### UC2 V3.0 prediction based on all datetime features, all other fine dust measurements (h-1)
- regression models trained and hyperparameter tuned on all datetime features and fine dust(h-1) 
  - **Decision Tree:** 
      - best results: DecisionTreeRegressor(max_depth=20, max_features='sqrt', min_samples_leaf=25, random_state=123)
      - test_median_absolute_error: 1.89 (+/- 0.14)
      - train_median_absolute_error: 1.67 (+/- 0.06)
      - overfitting: barely any (difference of 0.29)
      - comparison to other models: minimally worse results -> nr. 2
  - **Random Forest:** 
      - best results: RandomForestRegressor(max_depth=15, max_features='sqrt', min_samples_leaf=5, random_state=123)
      - test_median_absolute_error: 1.56 (+/- 0.10)
      - train_median_absolute_error: 1.24 (+/- 0.01) 
      - overfitting: barely any (difference of 0.32)
      - comparison to other models: better test and train results -> nr. 1
   
##### UC2 V3.1 prediction based on all datetime features, wind data, all other fine dust measurements (h-1)
- regression models trained and hyperparameter tuned on all datetime features, wind data(h-1) and fine dust(h-1) 
  - **Decision Tree:** 
      - best results: DecisionTreeRegressor(max_depth=20, max_features='sqrt', min_samples_leaf=25, random_state=123)
      - test_median_absolute_error: 2.23 (+/- 0.14)
      - train_median_absolute_error: 1.89 (+/- 0.03)
      - overfitting: barely any (difference of 0.34)
      - comparison to other models: minimally worse results -> nr. 2
  - **Random Forest:** 
      - best results: RandomForestRegressor(max_depth=15, max_features='sqrt', min_samples_leaf=5, random_state=123)
      - test_median_absolute_error: 1.61 (+/- 0.09)
      - train_median_absolute_error: 1.24 (+/- 0.01)
      - overfitting: barely any (difference of 0.37)
      - comparison to other models: better test and train results -> nr. 1

----------------------------------------------------------------
_comment:_ Use Case 3 will be performed with the best feature combination from Use Case 2
           version 1: h-1 values of all fine dust feature
           version 2: h-1 values for pm10 and pm2.5 only
           
##### UC3 V1 prediction based on all datetime features, all fine dust current hour (except pm10 & pm2.5), all other fine dust measurements h-1
- regression models trained and hyperparameter tuned on all datetime features and fine dust(h-1) 
  - **Decision Tree:** 
      - best results: DecisionTreeRegressor(max_depth=15, max_features='sqrt', min_samples_leaf=15, random_state=123)
      - test_median_absolute_error: 1.89 (+/- 0.15)
      - train_median_absolute_error: 1.63 (+/- 0.04)
      - overfitting: barely any (difference of 0.26)
      - comparison to other models: minimally worse results -> nr. 2
  - **Random Forest:** 
      - best results: RandomForestRegressor(max_depth=20, max_features='sqrt', min_samples_leaf=5, random_state=123)
      - test_median_absolute_error: 1.54 (+/- 0.11)
      - train_median_absolute_error: 1.09 (+/- 0.01)
      - overfitting: barely any (difference of 0.45)
      - comparison to other models: even tho it has a slightly higher difference between test and train error it still has better results -> nr. 1
   
##### UC3 V2 prediction based on all datetime features, all fine dust current hour (except pm10 & pm2.5), pm10 & pm2.5 h-1
- regression models trained and hyperparameter tuned on all datetime features, wind data(h-1) and fine dust(h-1) 
  - **Decision Tree:** 
      - best results: DecisionTreeRegressor(max_depth=15, max_features='sqrt', min_samples_leaf=20, random_state=123)
      - test_median_absolute_error: 1.86 (+/- 0.14)
      - train_median_absolute_error: 1.61 (+/- 0.04)
      - overfitting: barely any (difference of 0.25)
      - comparison to other model: 
  - **Random Forest:** 
      - best results: RandomForestRegressor(max_depth=25, max_features='sqrt', min_samples_leaf=10, random_state=123)
      - test_median_absolute_error: 1.55 (+/- 0.12)
      - train_median_absolute_error: 1.28 (+/- 0.01)
      - overfitting: barely any (difference of 0.27)
      - comparison to other model: slightly better than Decision Tree

----------------------------------------------------------------

#### RESULTS:
**Use Case 1:**
- Model: DecisionTreeRegressor(max_depth=10, max_features='sqrt', min_samples_leaf=40, random_state=123)
- Features: 'hour', 'day', 'month', 'year', 'day_of_week', 'is_weekend', 'no2_h-1', 'no_h-1', 'nox_h-1', 'wind_speed_h-1', 'wind_direction_h-1'
- Error values:
    - test_median_absolute_error: 5.94 (+/- 0.49)
    - train_median_absolute_error: 5.24 (+/- 0.13)
**Use Case 2:**
- Model: RandomForestRegressor(max_depth=15, max_features='sqrt', min_samples_leaf=5, random_state=123)
- Features: 'hour', 'day', 'month', 'year', 'day_of_week', 'is_weekend', 'no2_h-1', 'no_h-1', 'nox_h-1', 'pm10_h-1', 'pm2.5_h-1'
- Error values:
    - test_median_absolute_error: 1.56 (+/- 0.10)
    - train_median_absolute_error: 1.24 (+/- 0.01) 
**Use Case 3:**
- Model: RandomForestRegressor(max_depth=25, max_features='sqrt', min_samples_leaf=10, random_state=123)
- Features: 'hour', 'day', 'month', 'year', 'day_of_week', 'is_weekend', 'no2', 'no', 'nox', 'pm10_h-1', 'pm2.5_h-1'
- Error values:
    - test_median_absolute_error: 1.55 (+/- 0.12)
    - train_median_absolute_error: 1.28 (+/- 0.01) 

#### Decisions:
- not doing v3.2 due to time constraints - v3.2 would mean including wind data 
- no training on a station with o3 feature due to time constraint (although it has the highest correlation to pm10 values)
- drop use case 1 for final testing and streamlit app because of its weak performance
- Use Case 3 is interesting and has good results but needs iterative approach to make sense
  -> Use Case 2 will be displayed in Streamlit app

#### TODO:
- test finalised model on current data, other station with same location categorisation, other station with different categorisation for Use Case 2 V3.0
- clean up repository
- develop Streamlit app