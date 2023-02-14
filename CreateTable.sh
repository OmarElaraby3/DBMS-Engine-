#!/bin/bash

function ValidTab() {
 
  local Val='^([A-Za-z]+)*$'
  [[ "$1" =~ $Val ]]
} 

function ValidTable() {
  if ValidTab "$1"; then
    return 0
  else
     return 1
  fi
}


read -p "Enter The Table Name Please: " Tname 
ValidTable "$Tname"
if [ $? -eq 0 ] 
then
      if [ ! -f ./$Tname  -a  ! -f "./${Tname}.Meta" ]
      then
           touch ./$Tname
           touch "./${Tname}.Meta"

          typeset -i Numcol  
          read -p "Enter the number of Columns and at least Enter 2 Columns" Numcol 
          
          if [[ $Ncolumns -gt 1 ]] #if not zero and string 
          then 
                  for i in $(eval echo "{1..$Ncolumns}")
                  do
                    read -p "Enter The Column name please: " ColName
                    echo "choose the Datatypes(Int or String) for Columns ?"
                    select DatypeCol in int string
                    do 
                        case $DatypeCol in 
                        "int")
                          break
                            ;;
                        "string")
                          break
                          ;;
                      
                        *)
                        echo "select a valid datatype for Columns"
                        ;;
                        esac 
                    done   
                    if [ $i -eq 1 ]
                    then 
                                echo "Specify the Primary key"
                                select Pk in YES NO
                                do
                                    case $Pk in
                                    
                                    "YES")
                                    
                                      break
                                        ;;
                                    "NO")
                                      break
                                      ;;
                                    *)
                                          echo "Choose a valid Number for Columns"
                                      ;;
                                    esac

                                    
                                done 
                      else 
                      Pk=NO
                      fi

                    echo $ColName:$DtypeCol:$Pk >>"$Tname.Meta" 
                    
                  done
                echo "Table is Created :)"
          else 
          echo "you must enter at least two columns and Only Numbers"
          rm ./$Tname
          rm "./${Tname}.Meta"
          fi
          
          
     else
        echo "Table is already Exist"
      fi
else 
echo "Please,Enter valid table name"
fi 

