#!/bin/bash

function checkInt()
{
    local Exp='^([0-9]+)*$'
    [[ "$1" =~ $Exp ]]
    
}
# local make the scope of variables (re) local variables see only inside the function
#echo "re" -----> variable not defined

function checkStr()
{
    local Expp='^([A-Za-z]+)*$'
    [[ "$1" =~ $Expp ]]
    
}
ValidInt() {
  if checkInt "$1"; then 
    return 0
  else
     return 1 
  fi
}
ValidStr() {
  if checkStr "$1"; then 
    return 0
  else
     return 1 
  fi
}


 
echo "Enter table name to Update row into this table: "
read upTab
if [ ! -z upTab ] #check if he did not enter an empty Value string
then
if [ -f "./$upTab" -a -f "./$upTab.Meta" ] #check if the files exists (2 files) 
then 
         #NumCol=($(awk 'BEGIN{FS=":";} {print NF}' ./$upTab.Meta)) # field Sperator (:) Number of records in this file ($(Command))
         #awk make a for loop to scan the file line by lined
         #echo "NumCol"
         ColsName=($(awk 'BEGIN{FS=":";} {print $1}' ./$upTab.Meta))
         #store an array of the names of the columns in this file id:int:yes
         
       
        echo "Please, Enter your Column Name"
        read ColNam
         ValidStr "$ColNam" 
         if [ $? -eq 0 -a ! ${#ColNam} -eq 0 ]
        #($? ---> return the last input line) (a---> and) $(# length)
         then
           #check exist column name is exist in table or no 
                while (( `cut -d":" -f1 "./$upTab.Meta" | grep -x $ColNam | wc -w` == 0 ))
                #  take the name of column in this file (F1) ---> grep -x line match regex ---> check number of words = 0
                # (()) ---> return true or false and because  of ==  
                        do      
                        while [ true ]
                        do
                        read -p "$ColNam Column should be Exist in $updateTable table, please enter Correct Column: " ColNam
                        # read -p echo 
                        #read
                        ValidStr "$ColNam" 
                        if [ $? -eq 0  -a  ! ${#ColNam} -eq 0  ] 
                        then
                                break #out the while loop
                        else 
                            echo "you must enter String datatype in this "${ColsName[i]}
                        fi
                        done
                done
          else 
               echo "please enter a valid String"${ColsName[i]}
                 while [ true ]
                  do
                   read -p "$ColNam Column should be Exist in $upTab table, please enter Correct Column: " ColNam
                   ValidStr "$ColNam" 
                   if [ $? -eq 0  -a  ! ${#ColNam} -eq 0  ]
                   then
                         break
                   else 
                      echo "you must enter String datatype in this "${ColsName[i]}
                   fi
                  done
          fi
       
           NumsCols=($(awk 'BEGIN{FS=":";} END{print NR}' ./$upTab.Meta))
           #END print the number of rows 
           # -v will make me put a variable inside awk
           numCol=`awk -v Mvar=$ColNam 'BEGIN{FS=":";} {
                       if($1==Mvar)
                       {print NR}
                       }' ./$upTab.Meta`
           
           DatatypeCol=`awk -v Mvar=$ColNam 'BEGIN{FS=":";} {
                       if($1==myvar)
                       {print $2}
                       }' ./$upTab.Meta`
                 
                 echo "Please Enter your old value inside the field "
        read OldVal  
        if [ $? -eq 0 -a ! ${#OldVal} -eq 0 ]
        then
        while (( `cut -d":" -f$numCol "./$upTab" | grep -x $OldVal | wc -w` == 0 ))
        do   
             while [ true ]
             do
                read -p "Sorry $OldVal Doesn't Exist, please enter Exist value to Update : " OldVal
                if [ ! ${#OldVal} -eq 0  ]
                    then
                          break
                    else 
                       echo "Can't input value,you must enter Value datatype in this "${ColsName[i]}
                    fi
            
        
              done
        
        done
        else
          echo "Sorry,Please you must enter $DatatypeCol in this $ColNam column" ####
          echo "Please,Enter another once your value ?"

        fi

  
         echo "Please,Enter the new value to update"
          if [ "$DatatypeCol" == "int" ]
          then
                while [ true ]
                do
                read NewVal
                ValidInt "$NewVal" ## if he enter <---A--->
                         if [ $? -eq 0 -a ! ${#NewVal} -eq 0 ]
                         then
                              
                                   #if Column is PK
                                   if (( $numCol == 1 )) ;
                                   then
                                    while (( `cut -d":" -f1 "./$upTab" | grep -x $NewVal |wc -w` > 0 ))
                                    do   
                                        while [ true ]
                                        do
                                        read -p "${ColsName[i]} the primary key should be unique, please enter another value: " NewVal
                                        ValidInt "$NewVal"
                                         if [ $? -eq 0 -a ! ${#NewVal} -eq 0 ]
                                         then
                                              break
                                         fi
                                         done

                                    done
                                    fi    
                                 
                                #------------Update the Value (Replace)
                                if [ $numCol -eq 1 ]
                                then
                                sed -i "s/$OldVal:/$NewVal:/g" ./$upTab
                                elif [ $numCol  -eq $NumsCols ]
                                then 
                                  sed -i "s/:$OldVal/:$NewVal/g" ./$upTab
                                else
                                sed -i "s/:$OldVal:/:$NewVal:/g" ./$upTab
                                fi
                              break
                         else  
                             echo "Sorry,Please you must enter $DatatypeCol in this $NameCal column"
                             echo "Please,Enter another once your value ?"
                         fi 
                done
          else 
              while [ true ]
                do
                read NewVal
                ValidStr "$NewVal"
                       if [ $? -eq 0 -a ! ${#NewVal} -eq 0 ]
                         then  
                               #if Column is PK
                                   if (( $numCol == 1 )) ;then
                                    while (( `cut -d":" -f1 "./$upTab" | grep -x $NewVal |wc -w` > 0 ))
                                    do 
                                       while [ true ]
                                        do
                                        read -p "${ColsName[i]} should be unique, please enter another value: " NewValue
                                        ValidStr "$NewVal"
                                         if [ $? -eq 0 -a ! ${#NewVal} -eq 0 ]
                                         then
                                              break
                                         fi
                                         done
                                    done
                                    fi    
                            #------------Update the Value (Replace)
                                if [ $numCol -eq 1 ]
                                then
                                sed -i "s/$OldVal:/$NewVal:/g" ./$upTab
                                elif [ $numCol  -eq $NumsCols ]
                                then 
                                  sed -i "s/:$OldVal/:$NewVal/g" ./$upTab
                                else
                                sed -i "s/:$OldVal:/:$NewVal:/g" ./$upTab
                                fi
                               break
                         else  
                             echo "Sorry,Please you must enter $DatatypeCol in this $NameCal column"
                             echo "Please,Enter another once your value ?"
                         fi 

               done
          fi 

    echo "------------*****-----------"
    echo "Update Sucessfully"
    echo "------------*****-----------"
else 
echo "You must enter valid table name to update"
fi
else 
echo "You must enter input,Can't input Empty"
fi