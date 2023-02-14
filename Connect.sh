#!/bin/bash
#connect to the desired database -----> Check
#check if its not found --true---> there is no such database --false---> connect
#upon connection ------> list the data (files) manipulation menu
echo "enter database name to connect"
read ConName
if [  ! -d ./DataBase ] 
then
   echo "the main database does not exist"
fi
  if [ -d ./DataBase/$ConName ] 
    then
        cd ./DataBase/$ConName
        ../../Menu2.sh
        
    else
       echo "this database does not exist" $ConName
    fi
