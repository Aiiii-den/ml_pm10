### Sprint 6: 17.06. - 30.06.2024

#### Phase Two - Data aquistion and exploration:
__Part 6:__ 
- change idea to classification based on weekday and hour of the week
- Continue wind data merged exploration with ALL fine dust data -> done no correlation between them

#### Decisions:
- Categorization based on pm10 and wind speed + wind direction (see IDEA + KEEP IN MIND)

#### Next step:
- create a heatmap showing the correlation between the weekday and pm10
- create a heatmap showing the correlation between the hour of the day and pm, comparing weekdays and weekends


#### IDEA:
- train a classification model based on data at one station to predict the value at a station which doesn't measure it
    - categories: no problem, light health effect, medium health effect, severe health effect
    - filter based on time of day and day of the week
    - split datetime into year, month, day, hour
 
#### KEEP IN MIND:
- when pm10 is not measured pm2 is also not measured
    - remove it from the features when training
- TODO: andere Feinstaubstationen hinzufügen (später) (durchschnitt), h-1 - h - h+1
- Datensatz mit Bike Rentals (aus den Folien) als Beispielt


### REGRESSION
- nur die Zeitdaten und damit Vorhersagen
- danach mehr features -> anderer Use Case - Value Imputation
- Train with random train-validate && train with time snippets

1. Nur Zeit - Vorhersage, gleiche Station
2. Zeit + Wetter - Vorhersage
3. Zeit + Wetter - Vorhersage, anderer Station für die Station (Modell nehmen und auf andere Station testen)
4. Anderen Wert, den ich messen kann + evtl andere feature - Inferenz - ein Sensor ausgefallen


VARIANTEN, WAS MODELLIEREN, VOR UND NACHTEIL IN DIE DOKU