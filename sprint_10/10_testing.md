### Sprint 10: 02.09. - 15.09.2024

#### Phase Four - Final Testing
- tested the final model on four stations with data from June 1st to August 31st 2024:
  1. mc124 Tempelhof-Schöneberg (original station)
  2. mc190 Wedding - same category as mc124 (traffic)
  3. mc010 Wedding - different category as mc124 (residential area)
  4. mc032 Grunewald - different category as mc124 (city outskirt)

#### RESULTS:
| Station | Median pm10 value | Median absolute error | Possible deviation range |
|---------|-------------------|-----------------------|--------------------------|
| mc124   | 18.00             | 1.40 (7.8%)           | 16.60 - 19.40            |
| mc190   | 18.00             | 1.33 (7.4%)           | 16.67 - 19.33            |
| mc010   | 14.00             | 1.23 (8.8%)           | 12.77 - 15.23            |
| mc032   | 11.00             | 1.17 (10.6%)          | 09.83 - 12.17            |


#### TODO:
- clean up repository
- develop Streamlit app