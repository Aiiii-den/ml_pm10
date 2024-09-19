import requests
import json
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta

# Define the API endpoint
api_endpoint = "https://luftdaten.berlin.de/api/stations/mc010/data"  # Change to your actual API endpoint

# Define the start date
start_date = datetime(2020, 1, 1)
end_date = datetime(2020,1,30)
print(start_date, end_date)


# Define the start and end dates for the month in "dd.mm.yyyy HH:MM" format
start_date_formatted = start_date.strftime("%d.%m.%Y 00:00")  # First day of the month
end_date_formatted = end_date.strftime("%d.%m.%Y 23:00")  # Formatted end date
print(start_date_formatted)
print(end_date_formatted)

# Define the parameters for the API request
params = {
     "timespan": "custom",  # Additional parameter for timespan
     "start": start_date_formatted,  # Start of the month in specified format
     "end": end_date_formatted  # End of the month in specified format
  }

req = requests.Request('GET', api_endpoint, params=params)
prepared_req = req.prepare()
print(prepared_req.url)
print(prepared_req.headers)


# Make the API request
response = requests.get(api_endpoint, params=params)
print(response.status_code)
print(response.json())


