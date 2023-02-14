#!/bin/bash
#validate the existance of directories-----True----> Delete or -----False-----> nothing
echo "Enter the Database Name you want to Delete " 
read dname 
if [  ${#dname} -ne 0 ]
then
if [  ! -d ./DataBase/$dname ]
then
     echo "cannot delete non existent Database"
    else
   rm -r  ./DataBase/$dname
    echo "$dname successfully deleted"
fi 
else
echo "you cannot enter an empty Database Name"
fi
