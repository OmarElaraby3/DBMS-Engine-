#!/bin/bash
#------------------------------------------------------------------------------
ValidDB() {
 
  local Val='^([A-Za-z]+)[0-9]*$'
  [[ $1 =~ $Val ]] 
}


ValidDname() {
  if ValidDB "$1"; then 
    return 0
  else
     return 1 
  fi
}

echo "Enter The Database Name Please"
read Dname
ValidDname "$Dname" 
if [ $? -eq 0  -a ! ${#Dname} -eq 0 ]
then 
    if [ ! -d ./DataBase ]
    then
    mkdir ./DataBase
    fi 

    if [ ! -d ./DataBase/$Dname ]  
    then
        mkdir ./DataBase/$Dname 
         echo "DataBase Created Succesfully"       

    else 
    echo "this DataBase already exist"
    fi 
else 
    echo "Enter a Valid DataBase Name Please"
fi


