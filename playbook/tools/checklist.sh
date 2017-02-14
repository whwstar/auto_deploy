#!/bin/bash -xv

#var def
DEST_USER=omm
PASSWORD=omm123


#check user exists
function adduser {
egrep "^$DEST_USER" /etc/group >& /dev/null
if [ "$?" -eq 0 ];then
    echo "group $DEST_USER have been exists !!!"
    egrep "^$DEST_USER" /etc/passwd >& /dev/null
    if [ "$?" -ne 0 ];then
    	useradd -g $DEST_USER $DEST_USER
    	echo $PASSWORD |passwd --stdin $DEST_USER
    	if [ "$?" -eq 0 ];then
    		echo "set password successful !!!"
    	else
    		echo "set password fail ,please check the err reason;"
    	fi
    else
    	
    	echo "$DEST_USER not exists"
    	return 10
    fi
else
    echo "not exist group $DEST_USER,please add user and group"
    egrep "^$DEST_USER" /etc/passwd >& /dev/null
    if [ "$?" -ne 0 ];then
        useradd $DEST_USER
        echo $PASSWORD |passwd --stdin $DEST_USER
        if [ "$?" -eq 0 ];then
                echo "set password successful !!!"
        else
                echo "set password fail ,please check the err reason;"
        fi
    else
        
        echo "$DEST_USER not exists"
        return 11
    fi

fi
}

function modify_os {
echo 0 > /proc/sys/vm/swappiness
echo "vm.swappiness=0" >> /etc/sysctl.conf
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/redhat_transparent_hugepage/defrag
echo "vm.overcommit_memory=1" >> /etc/sysctl.conf
echo "vm.overcommit_ratio=50" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range=1024 65535" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_recycle=1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_reuse=1" >> /etc/sysctl.conf
echo "net.core.rmem_max=16777216" >> /etc/sysctl.conf
echo "net.core.wmem_max=16777216" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog=4096" >> /etc/sysctl.conf
echo "net.ipv4.tcp_syncookies=1" >> /etc/sysctl.conf
echo "net.core.somaxconn=32768" >> /etc/sysctl.conf
echo "fs.file-max=8192000" >> /etc/sysctl.conf
echo "* soft nproc 32768" >> /etc/security/limits.d/90-nproc.conf
echo "* soft nofile 102400" >> /etc/security/limits.conf
echo "* hard nofile 102400" >> /etc/security/limits.conf
echo "* soft nproc 32768" >> /etc/security/limits.conf
echo "* hard nproc 32768" >> /etc/security/limits.conf
sysctl -p
}

function disable_server {
sed -i 's@SELINUX=.*@SELINUX=disabled@g' /etc/selinux/config
setenforce 0
chmod 777 /tmp
}
function yum_install {
yum install -y  autoconf automake cloog-ppl cpp createrepo curl cyrus-sasl cyrus-sasl-lib db4 db4-cxx db4-devel db4-utils deltarpm dracut dracut-kernel e2fsprogs e2fsprogs-libs expat-devel expect gcc gcc-c++ gdbm- gdbm-devel glibc glibc-common glibc-devel glibc-headers gpm-libs iproute jemalloc kernel kernel-firmware kernel-headers keyutils-libs keyutils-libs-devel krb5-devel krb5-libs krb5-workstation libaio libcom_err libcom_err-devel libcurl libcurl-devel libgcc libgomp libidn-devel libselinux libselinux-devel libselinux-utils libsepol-devel libss libssh2 libstdc++ libstdc++ libxml2-python libyaml m4 make man mpfr nc ncurses-base ncurses-libs nspr nss nss-softokn nss-softokn-freebl nss-sysinit nss-tools nss-util openldap openssl openssl-devel perl perl-devel perl-ExtUtils-MakeMaker perl-ExtUtils-ParseXS perl-libs perl-Module-Pluggable perl-Pod-Escapes perl-Pod-Simple perl-Test-Harness perl-version pkgconfig ppl procps python python-argparse python-backports python-backports-ssl_match_hostname python-chardet python-deltarpm python-iniparse python-libs python-requests python-six python-urllib3 PyYAML repodata rsync sqlite sqlite sudo tcl vim-common vim-enhanced vim-filesystem vim-minimal wget xz xz-libs xz-lzma-compat yum yum-metadata-parser yum-plugin-fastestmirror zlib zlib-devel
}
#This function used to check system whether exist $DEST_USER
adduser
#yum_install
#disable_server
