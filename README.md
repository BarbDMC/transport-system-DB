# transport-system-DB

This project is a database for a transport system made on PostgreSQL.

It's conformed by six tables and two triggers:

- stations: stores all stations data with the fields:
 -- idStation: saves the unique id for each station, the type of data is an integer.
 -- name: saves the station name, the type of data is character varying.
 -- address: saves the station address, the type of data is character varying.

-trains: contains the trains information of the transport system with the fields:
 -- idTrain: saves the unique id for each train, the type of data is an integer.
 -- model: saves the model name of the train, the type of data is character varying. 
 -- capacity: saves the number of passengers that can hold a train, the type of data is an integer.
 
 - passengers: stores the personal information from the passengers that use the transport system. It has the fields:
 -- idPassenger: saves the unique id for each passenger, the type of data is an integer.
 -- name: stores the passenger name, the type of data is character varying.
 -- homeAddress: stores the passenger home address, the type of data is character varying.
 -- birthDate: saves the passenger birth date. The type of data is date.
- routes: saves the information on the train routes, relating the station to the trains with the fields:
 -- idRoute: saves the unique id for each route of the system, the type of data is an integer.
 -- idStation: stores the id of the station that is related to the route. The type of data is an integer.
 -- idTrain: stores the id of the train that makes the route. The type of data is an integer.
 -- name: saves the route name, the type of data is character varying.

- travels:  stores the information about the trips made by the passengers, relating the routes with the passengers. It has the fields:
 -- idTravel: saves the unique id for each travel, the type of data is an integer.
 -- idPassenger: stores the id of the passenger that is traveling. The type of data is an integer.
 -- idRoute: saves the id of the route in which the passenger is. The type of data is an integer.
 -- start: stores the start time of travel, the type of data is time without time zone.
 -- end: stores the end time of travel, the type of data is time without time zone.
 
-count_passengers: It counts the passenger's amount every time that it's changed at the passenger's table. 
 -- idCount: saves the unique id for each row, the type of data is an integer.
 -- amount: stores the current amount of passengers. The type of data is an integer.
 -- time: saves the time where the update was made. The type of data is timestamp.

-Triggers:
-- count_update and count_delete: Make an insert every time that is inserting or deleting a row in the passenger's table.
