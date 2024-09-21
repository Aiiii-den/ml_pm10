### Sprint 1: 08.04. - 21.04.2024

#### Phase One - Business Understanding:
- Understanding Business (Personal) Value and creating a Use Case based on necessity
- Research on pm10 since it seemed interesting to me due to its various health implications

#### Phase Two - Data acquisition and exploration:
__Part 1:__ 
- Data acquisition -> searched for appropriate datasets
- first air_hour from a korean api; however, dropped due to inadequate documentation of the api and language barriers
- found air quality measurements https://daten.berlin.de/datensaetze/luftg%C3%BCtemessdaten (website does not exist anymore - date: 21.09.2024)
on Open Data Berlin https://daten.berlin.de/
- requested first sample data from the api manually via postman https://luftdaten.berlin.de/api/doc
    
#### Decisions:
- using https://luftdaten.berlin.de/api/doc as my dataset
- to be predicted feature: pm10

#### Next steps:
- first analysis of berlin data
- decide on model family