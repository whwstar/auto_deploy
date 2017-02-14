#!/bin/bash
. ../conf/parameter.conf
user=${DEST_USER[0]}
password=${DEST_USER[1]}
path=`pwd`
IPFILE=../conf/slave.conf

function scpfile {
./rsh $password scp $path/checklist.sh $user@$ip:/root/
}

function exec_check {
./rsh $password ssh -p 22 root@$ip "cd /root && chmod +x checklist.sh && ./checklist.sh"
}

for ip in $( cat $IPFILE)
do
	
	if [ "x$ip" != "x" ];then
		val=`ssh-keyscan $ip 2>/dev/null`
		if [ "x$val" == "x" ];then
			echo "ssh-keyscan $ip failed,please input IP...."
			echo $val>>$SSH_DIR/known_hosts
			scpfile $ip
			exec_check $ip
		else
			scpfile $ip
			exec_check $ip
		fi
	fi
done

