#!/bin/bash
read -p "Enter Table name you want to drop: " DelTabnam 
if [ -f  ./$DelTabnam ]
    then
        rm -r ./$DelTabnam
        rm -r ./$DelTabnam.Meta
        echo "-----------*****--------------"
        echo "$DelTabnam dropped Sucessfully"
        echo "-----------*****--------------"

    else
        echo "Not a Valid Table Name"
fi