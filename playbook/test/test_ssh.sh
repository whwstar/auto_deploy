#!/bin/bash -xv
#This is a commen scp script,you can use in every suitable 

#define var
. ../conf/parameter.conf
. ../conf/path.conf
#. ../conf/hosts.conf

DEST_USER=${login[0]}
PASSWORD=${login[1]}
$LOCAL_DIR_SOFT_SOFT
$DIST_DIR_SOFT_SOFT
$SSH_DIR
IPFILE=../conf/hosts.conf


mkdir $SSH_DIR
chmod 700 $SSH_DIR

#check user exists
function addgroup {
    egrep "^$DEST_USER" /etc/group >& /dev/null
    if [ $? -ne 0 ] ; then
            groupadd $GROUP

            echo "group add successful !!!"
    else
            echo "$GROUP have exist"
            exit
    fi
}

function adduser {
egrep "^$DEST_USER" /etc/passwd >& /dev/null
if [ "$?" -ne 0 ];then
        echo "$DEST_USER not exists"
        useradd -g $DEST_USER $DEST_USER
        echo $PASSWORD |passwd --stdin $DEST_USER
        if [ "$?" -ne 0 ];then
                echo "set password successful !!!"
        else
                echo "set password fail ,please check the err reason;"
        fi
fi
}


function fun_ssh {
TMP_SCRIPT=ssh.$ip.sh
echo "#!/usr/bin/expect -f" >>$TMP_SCRIPT
echo "eval spawn $ssh root@$ip">>$TMP_SCRIPT
echo "expect {">>$TMP_SCRIPT
echo "    -re "yes/no" {">>$TMP_SCRIPT
echo "         send "yes\r";">>$TMP_SCRIPT
echo "     } -re "assword:" {">>$TMP_SCRIPT
echo "         send "123456\r";">>$TMP_SCRIPT
echo "     } timeout {">>$TMP_SCRIPT
echo "         exit">>$TMP_SCRIPT
echo "     } eof {">>$TMP_SCRIPT
echo "         exit">>$TMP_SCRIPT
echo "     }">>$TMP_SCRIPT
echo " }">>$TMP_SCRIPT
echo " ">>$TMP_SCRIPT
echo " interact">>$TMP_SCRIPT

cat  $TMP_SCRIPT
chmod +x $TMP_SCRIPT
./$TMP_SCRIPT 123456 root@$ip
addgroup
adduser
exit
rm -rf $TMP_SCRIPT
}

#SCP script
for ip in $(cat $IPFILE)
do
fun_ssh 
done  
