#!/bin/bash
function ValInt()
{
    local Val='^([0-9]+)*$'
    [[ "$1" =~ $Val ]]
    
}


ValidInt() {
  if ValInt "$1"; then 
    return 0
  else
     return 1 
  fi
}



read -p "Please Enter the table Name to select it: " seleTab
if [ ! ${#seleTab} -eq 0 ] #----> #[[ seleTab == " "]]
then
if [ -f ./$seleTab ]
then 
echo "Please,choose what do you want to select from the menu? "
select option in "Select all" "Select From Column" "Select From Row" "Exit"
do 
     NumTcol=($(awk 'BEGIN{FS=":";} END{print NR}' ./$seleTab.Meta)) 
     NumTrows=($(awk 'BEGIN{FS=":";} END{print NR}' ./$seleTab)) 
     case $option in 
       "Select all") 
           echo "Selected Table"
           echo "--------------*****--------------------"
           cat $seleTab
           echo "--------------*****-----------------"

        ;;
       
       "Select From Column")
    
       read -p "Enter Column Number: " Colnum
       ValidInt "$Colnum"
       if [ $? -eq 0  ]
       then
       if [[ $Colnum -le $NumTcol ]]
       then
       echo "-------------------------------------"
       cat $seleTab | cut -d: -f$Colnum # -f field 
       echo "-------------------------------------"
       else 
       echo "Doesn't Exist $Colnum Numbers Columns"
       fi
       else 
       echo "You Must enter the column number only"
       fi
       ;;
       "Select From Row")
       read -p "Enter Row Number: " Numrow
      testValidInt "$Numrow"
       if [ $? -eq 0 ]
       then
       if [ $Numrow -le $NumTrows ]
       then
       echo "-------------------------------------"
       sed -n "$Numrow p" ./$seleTab  # -n  for number of row (-n) ---> print and new line
       echo "-------------------------------------"
       else 
       echo "Doesn't Exist $NumTrow Numbers Rows"
       fi
       else 
       echo "You Must enter the row number only"
       fi
       ;;
       "Exit")
         break
         ;;
       *)
       echo "You must choose correct number in this menu"
       ;;
     esac
done
fi
else 
echo "You can not enter an empty column"
fi