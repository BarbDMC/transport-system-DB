# Transport System Database

This project is a database for a transport system made on PostgreSQL. The data entered in the database were generated by mockaroo.

<br>

## Tables

<br>

1. **stations:** stores all stations data with the fields:
    
    1.  idStation: saves the unique id for each station, the type of data is an integer.
    1. name: saves the station name, the type of data is character varying.
    1. address: saves the station address, the type of data is character varying.
   
   <br>

1. **trains:** contains the trains information of the transport system with the fields:
    
    1. idTrain: saves the unique id for each train, the type of data is an integer.
    1. model: saves the model name of the train, the type of data is character varying.
    1. capacity: saves the number of passengers that can hold a train, the type of data is an integer.
   
   <br>

1. **passengers:** stores the personal information from the passengers that use the transport system. It has the fields:
 
   1. idPassenger: saves the unique id for each passenger, the type of data is an integer.
   1. name: stores the passenger name, the type of data is character varying.
   1. homeAddress: stores the passenger home address, the type of data is character varying.
   1. birthDate: saves the passenger birth date. The type of data is date.
   <br>
1. **routes:** saves the information on the train routes, relating the station to the trains with the fields:

   1. idRoute: saves the unique id for each route of the system, the type of data is an integer.
   1. idStation: stores the id of the station that is related to the route. The type of data is an integer.
   1. idTrain: stores the id of the train that makes the route. The type of data is an integer.
   1. name: saves the route name, the type of data is character varying. 
   
   <br>
1. **travels:**  stores the information about the trips made by the passengers, relating the routes with the passengers. It has the fields:
 
    1. idTravel: saves the unique id for each travel, the type of data is an integer.
    1. idPassenger: stores the id of the passenger that is traveling. The type of data is an integer.
    1. idRoute: saves the id of the route in which the passenger is. The type of data is an integer.
    1. start: stores the start time of travel, the type of data is time without time zone.
    1. end: stores the end time of travel, the type of data is time without time zone. 
    <br>
1. **count_passengers:** It counts the passenger's amount every time that it's changed at the passenger's table. 
 
   1. idCount: saves the unique id for each row, the type of data is an integer.
   1. amount: stores the current amount of passengers. The type of data is an integer.
   1. time: saves the time where the update was made. The type of data is timestamp.

<br>

## Triggers:

  * count_update and count_delete: Make an insert every time that is inserting or deleting a row in the passenger's table.
  
 <br>

## Transport System Database ER diagram

![This is a alt text.](https://raw.githubusercontent.com/BarbDMC/transport-system-DB/main/ERD%20transport%20system.png)
