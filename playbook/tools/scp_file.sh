#!/bin/bash -xv
#This is a commen scp script,you can use in every suitable 

#define var
. ../conf/parameter.conf
. ../conf/path.conf

DEST_USER=${DEST_USER[0]}
PASSWORD=${DEST_USER[1]}
$LOCAL_DIR_SOFT_SOFT
$DIST_DIR_SOFT_SOFT
$SSH_DIR
IPFILE=../conf/slave.conf

mkdir $SSH_DIR
chmod 700 $SSH_DIR

#SCP script
function fun_scp {
 TMP_SCRIPT=scp.$ip.sh
 echo "TMP script name is : $TMP_SCRIPT"
 echo "copy $LOCAL_DIR_SOFT to $ip"
 echo  "#!/usr/bin/expect">$TMP_SCRIPT
 echo  "spawn scp -r  $LOCAL_DIR_SOFT $NEW_USER@$ip:$DIST_DIR_SOFT">>$TMP_SCRIPT
 echo  "expect *assword*">>$TMP_SCRIPT
 echo  "send $PASSWORD\r">>$TMP_SCRIPT
 echo  "interact">>$TMP_SCRIPT
 chmod +x $TMP_SCRIPT
 /usr/bin/expect $TMP_SCRIPT
 rm $TMP_SCRIPT
 echo "copy done."
}

for ip in $( cat $IPFILE)
do
	
	if [ "x$ip" != "x" ];then
		val=`ssh-keyscan $ip 2>/dev/null`
		if [ "x$val" == "x" ];then
			echo "ssh-keyscan $ip failed,please input IP...."
			echo $val>>$SSH_DIR/known_hosts
			fun_scp $ip
		else
			fun_scp $ip
		fi
	fi
done
