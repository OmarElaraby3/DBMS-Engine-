#!/bin/bash
if [ -d ./DataBase ]
then
   echo "DataBase List"
   ls -F ./DataBase |  grep /  
   if [ $? -ne 0 ]
   then
    echo "This database does not exist"
   fi
else
   echo "The Main Database does not exist"
fi