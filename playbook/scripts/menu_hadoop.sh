#!/bin/bash

#######################Install Hadoop Script Begin#############################
function menu {
clear
    echo  
    echo -e "\t\t\tInstall HADOOP\n"  
    echo -e "\t1. UNTAR HADOOP "  
    echo -e "\t2. INIT CONF FILE"  
    echo -e "\t3. Configuration SSH-key"  
    echo -e "\t4. Source bashrc file"  
    echo -e "\t5. Format HDFS "  
    echo -e "\t6. StartUp HADOOP Cluster"  
    echo -e "\t7. Check HADOOP "  
    echo -e "\t8. Run Test(word count)"  
    echo -e "\t0. Exit program\n\n"  
    echo -en "\t\tEnter option: "  
    read -n 1 option

}

#untar hadoop install package -C /home/work/nmp
function untar_hadoop {
        echo "untar hadoop successful !!!"
}

#init hadoop main config parameter
function init {
	echo "config hive been inited"
}

#Build mutual trust between master and slave
function auto_ssh {
	echo "mutual trust build successful !!!"
}

#
function source_bashrc {
	echo "OK"
}



while [ 1 ]  
do
    menu
    case $option in
        0)
        break ;;
        1)
        untar_hadoop ;;
        2)
        init ;;
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

#######################Install Hadoop Script End#############################

