#!/bin/bash -xv

user=root
password=123456
IPFILE=ip.txt

mkdir $SSH_DIR
chmod 700 $SSH_DIR

for ip in $( cat $IPFILE)
do
	if [ "x$ip" != "x" ];then
		val=`ssh-keyscan $ip 2>/dev/null`
		if [ "x$val" == "x" ];then
			echo "ssh-keyscan $ip failed,please input IP...."
			echo $val>>$SSH_DIR/known_hosts
			./rsh $password ssh $user@$ip df -h 
		else
			 ./rsh $password ssh $user@$ip df -h
		fi
	fi
done

