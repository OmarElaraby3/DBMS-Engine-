#!/bin/bash
Tab=`ls -F | grep -v / | grep -v !*.Meta`

    if [[ "$Tab" == "" ]]
        then
        echo "There is NO Tables to list"
    else
        echo "$Tab"
    fi