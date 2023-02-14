#!/bin/bash
select option in CreateTable ListTable DropTable SelectTable InsertTable UpdateTable DeleteTable  Exit
do 
case $option in
 "CreateTable")
  ../../createtable1.sh
   ;; 
 "ListTable")
  ../../ListTable.sh
;;
  "DropTable")
  ../../DropTable.sh
  ;; 
  "SelectTable") 
    ../../selectTable.sh
  ;;
  "InsertTable")
  ../../insert2.sh
  ;;
  "UpdateTable")
    ../../UpdateTable.sh

  ;;
  "DeleteTable")
    ../../DeleteTable.sh

  ;;
  "Exit") 
  exit 0
  ;;
  esac
  done 
