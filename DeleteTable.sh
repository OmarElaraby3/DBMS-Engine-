#!/bin/bash

read -p "Please Enter the table name to Delete it: " deletTab

if [ -f ./$deletTab ]
then 
echo "Please,choose what do you want to select from menu? "
select option in "Delete all" "Delete Row" "Back to Menu"
do   
    case $option in 
       "Delete all")
        sed -i "d" ./$deletTab 
        echo "Deleted Sucessfully"

       ;;
        
        "Delete Row")
               echo "Please Enter your ID to delete row"
               read NumID
               
               
               #NumOfRow=`awk -F: -v Mvar=$NumID '{if ($1 == Mvar){ print NR;} }' ./$deletTab`
               NumOfRow=($(awk -F: -v Mvar=$NumID '{if ($1 == Mvar){ print NR;} }' ./$deletTab))

                echo "$NumOfRow"
                if [[ $NumOfRow == " " ]]
                then
                echo "$NumOfRow Must exist"
                else 
                sed -i "${NumOfRow}d" ./$deletTab
                fi
                ;;
        "Back to Menu")
        break
        ;;
        *)
         echo "You Must correct Choose from this menu"
        ;;
        esac
        done
else 
        echo "Table Does't Exist"
fi