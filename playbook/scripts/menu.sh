#!/bin/bash  
    
# simple script menu  
function check {  
        clear  
        cd ../tools && ./scp_script.sh  
}  
function whoseon {  
    clear  
    who  
}  
function memusage {  
    clear  
    cat /proc/meminfo  
}  


function menu {  
    clear  
    echo  
    echo -e "\t\t\tDEPLOY PROPHET MENU\n"  
    echo -e "\t1. Check all slave server() "  
    echo -e "\t2. Install HADOOP"  
    echo -e "\t3. Install SPARK"  
    echo -e "\t4. Install HIVE"  
    echo -e "\t5. Install PROHET"  
    echo -e "\t0. Exit program\n\n"  
    echo -en "\t\tEnter option: "  
    read -n 1 option  
}  


while [ 1 ]  
do  
    menu  
    case $option in  
        0)  
        break ;;  
        1)  
        check ;;  
        2)  
        ./menu_hadoop.sh ;;  
        3)  
        memusage ;;  
        *)  
        clear  
        echo "Sorry, wrong selection";;  
    esac  
    echo -en "\n\n\t\t\tHit any key to continue"  
    read -n 1 line  
done  
clear  
