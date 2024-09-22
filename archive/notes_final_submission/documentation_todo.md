[http://localhost:8888/edit/project/Abgabe_Info.txt]

*Configs*
- export environment config file from conda

*Introduction* (Motivation & Background)
- explain pm10
- add EU regulation and WHO regulation information
- add study of Hamburg due to Easter
- add website of Berlin which predicts fine dust value
- personal experience with air pollution abroad

*Data*
- add weather station description (map?)
- add wind station description (map?)
- explain how data was optained
- explain features of data

*Modelling*
- explain reasoning for regression
- explain pro and cons of different models used
- explain hyperparameter used to train on
- explain evaluation criteria (median absolute error due to extensive outliers and special events)

*Sprint description*
- versioning structure
- add table with timeframe, sprint nr, phase ml dev cycle, achievements
- give detailed explanation of results of each sprint in text format below (add pictures of heatmaps, tables of comparing result from different ml models)

*Analysis & Discussion*
- deciding on the best model & hyperparameter
- discussing why it was chosen

*Limitations & Future possibilities*
- time constraints
- not trained on weather station with ozone as measured particle
- partly clumsy code -> could be solved in a more efficient and elegant way
- basic train/validate split -> knew values from the future, not perfect --> would need to split the test and validation data based on time
- not retrained based on new data? maybe maybe not, need to manipulate it again anyways tho..
  ____
- get wind data from a different source with more information
- add traffic information to features
- add event api to get information of potentially impactful events around the area
- final model for use case 3 could be used to fill up missing value and retrain final model from use case 2 -> compare accuracy afterwards

*Streamlit app*
- focus on visualisation of data (yearly, monthly, daily) show comparison to EU/WHO regulations
- prep whole pipeline (how did I get the datetime features extracted, add API call and data prep for the app --> that's gonna be annoying af)
      - use existing df, get new data via API call, run data engineering pipeling, add new df to existing df
      - add everything before until september to exisiting df
      - 3-4 days of work?!
      - call the API and get the fine dust data from the last hour
      - add both to the trained model
      - retrain model daily at 02:00 based on new data incoming
      - get date and time by a local feature --> manipulate
      - WAIT: I only need to get the current hour - 1 from the api!! now further data manipulation neccessary
- add one Use Case 2 model --> add score (which one tho?)
