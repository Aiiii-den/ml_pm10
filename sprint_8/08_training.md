### Sprint 8: 15.07. - 28.07.2024

#### Phase Three - Training and validating:
__Part 3:__
##### 2.0 prediction based on all datetime features and wind data - version 2.0
- regression models trained and hyperparameter tuned on all datetime features and wind data - v (manipulated wind_data to get h-1 as a new feature)
  - **Decision Tree:** 
      - best results: DecisionTreeRegressor(max_depth=10, max_features='log2', min_samples_leaf=10,
                      random_state=123)
      - test_median_absolute_error: 6.34 (+/- 0.17)
      - train_median_absolute_error: 5.12 (+/- 0.09)
      - overfitting: bit of overfitting
      - comparison to other models: slightly less overfitting, therefore nr 1
  - **Random Forest:** 
      - best results: RandomForestRegressor()
      - test_median_absolute_error: 6.27 (+/- 0.35)
      - train_median_absolute_error: 4.23 (+/- 0.03)
      - overfitting: strong overfitting
      - comparison to other models: rank 2 based on strong overfitting

#### Decisions:
- do v3.x with both wind data and no wind data

#### TODO:
- for v3 move options for values in column for each --> pm10_value, no_value, ox_value and use value of the previous hour!!
    - might be easier to just filter everything and merge it later on for the h-1 --> STILL USE CASE 1


### FINAL GOAL: REGRESSION
- nur die Zeitdaten und damit Vorhersagen
- danach mehr features -> anderer Use Case - Value Imputation
- Train with random train-validate && train with time snippets

1. Nur Zeit - Vorhersage, gleiche Station
2. Zeit + Wetter - Vorhersage - Imputation gleiche Station
3. Zeit + Wetter - Vorhersage, anderer Station für die Station (Modell nehmen und auf andere Station testen)
4. Anderen Wert, den ich messen kann + evtl andere feature - Inferenz - ein Sensor ausgefallen

VARIANTEN, WAS MODELLIEREN, VOR UND NACHTEIL IN DIE DOKU

BASELINE MEDIAN TRAININGSDATENSATZ und damit die Modelle vergleichen