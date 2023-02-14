#!/bin/bash


function ValInt()
{
    local re='^([0-9]+)*$'
    [[ "$1" =~ $Valu ]]
    
}

function ValStr()
{
    local Valu='^([A-Za-z]+)*$'
    [[ "$1" =~ $Valu ]]
    
}
function ValPK()
{
    local exist=$(awk -F: -v pk="$1" '{if(pk == $1)print $0}' ./$InsTab | wc -l)
    if [ $exist -eq 0 ]; then
        return 0
    else
        return 1
    fi
}



echo "Enter table name to insert row into this table: "
read InsTab
if [ -f "./$InsTab" -a -f "./$InsTab.Meta" ]
then 
    #NumRows=($(awk 'BEGIN{FS=":";}{}END{print NR}' ./$InTable.Mdata))
    NumRows=($(awk 'END{print NR}' ./$InsTab.Meta))
    echo "$NumRows"

    ColsName=($(awk 'BEGIN{FS=":";} {print $1}' ./$InsTab.Meta))
    ColsDataTypes=($(awk 'BEGIN{FS=":";} {print $2}' ./$InsTab.Meta))
    output=""
    for i in $(seq 1 $NumRows);
    do 
    echo "please,Enter" ${ColsName[i-1]}":"
    
            if [[ ${ColsDataTypes[i-1]} == "int" ]]
            then 
                        while [ true ]
                        do  
                            
                                    read inputInt
                                    ValInt "$inputInt"
                                     if [ $? -eq 0 ]
                            then 
                                ValPK "$inputInt"
                                if [ $? -eq 0 ]; then
                                    output+=$inputInt
                                else
                                    echo "duplicate Primary key"
                                    continue
                                fi
                            if [ $i -ne $NumRows ]
                             then
                                 output+=:
                            fi

                                            break
                                    else 
                                            echo "you must enter an integer datatype in this "${ColsName[i-1]}
                                            echo "Please, Enter another once "${ColsName[i-1]}
                            
                                    fi
                        done
            else 
                        while [ true ]
                        do
                                    read inputStr
                                    ValStr "$inputStr"
                                        if [ $? -eq 0 ]
                                        then 
                                        #unique id
                                            if (( $i == 0 )) ;then
                                            while (( `cut -d":" -f1 "./$InsTab" | grep -x $inputStr |wc -w` > 0 ))
                                            do 
                                                read -p "${ColsName[i]} should be unique, please enter another value: " inputStr
                                            done
                                            fi    

                                        output+=$inputStr
                                            if [ $i -ne $NumRows ]
                                            then
                                            output+=:
                                            fi
                                        break
                                        else 
                                        echo "you must enter String datatype in this "${ColsName[i-1]}
                                        echo "Please, Enter another once "${ColsName[i-1]}
                                        fi
                        done
                        

            fi
        
    done
    echo $output >> ./$InsTab
    echo "Insert Sucessfully"
    else 
echo "You Must Enter a Valid Table Name to Insert"
fi