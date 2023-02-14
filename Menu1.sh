#!/bin/bash
#menu contains create DataBase , List , Drop and Connect
#validate the options selected
select option in CreateDataBase ListDataBase ConnectDataBase DropDataBase Exit
do 
case $option in
 "CreateDataBase")
 ./CreateDataBase.sh
 ;; 
 "ListDataBase")
 ./ListDataBase.sh
 ;;
  "ConnectDataBase")
  ./Connect.sh
  ;; 
  "DropDataBase") 
  ./DropDataBase.sh
  ;;
  "Exit")
   break
  ;;
  esac
  done 