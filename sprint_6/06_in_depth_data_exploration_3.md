### Sprint 6: 17.06. - 30.06.2024

#### Phase Two - Data acquisition and exploration:
__Part 6:__ 
- Changed idea to classification based on weekday and hour of the week
- Continue wind data merged exploration with ALL fine dust data -> done no correlation between them

#### Decisions:
- Categorization based on pm10 and wind speed + wind direction 

#### Next step:
- create a heatmap showing the correlation between the weekday and pm10
- create a heatmap showing the correlation between the hour of the day and pm, comparing weekdays and weekends

#### IDEA:
- train a classification model based on data at one station to predict the value at a station which doesn't measure it
    - categories: no problem, light health effect, medium health effect, severe health effect
    - filter based on time of day and day of the week
    - split datetime into year, month, day, hour
