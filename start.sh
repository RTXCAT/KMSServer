#!/bin/bash

set_tuna_mirrorslist()
{
        sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-*.repo
         yum makecache
         yum install -y vim wget net-tools
}

update_system()
{
        yum clean all
        yum makecache
        yum update -y
}

prepare_Env()
{
        yum install -y net-tools wget git vim
}

get_vlmcsd()
{
        wget https://github.com/Wind4/vlmcsd/releases/download/svn1113/binaries.tar.gz
}

uzip_vlmcsd()
{
        tar -zxvf binaries.tar.gz
        mkdir /etc/KMSServer
        mv binaries/Linux/intel/static/vlmcsdmulti-x64-musl-static /etc/KMSServer/
}
edit_profile()
{
        echo -e >> /etc/profile \
        firewall-cmd --zone=public --add-port=1688/tcp --permanent \n
        firewall-cmd --reload \n
        /etc/KMSServer/vlmcsdmulti-x64-musl-static vlmcsd
}
start_vlmcsd()
{
        /etc/KMSServer/vlmcsdmulti-x64-musl-static vlmcsd
}
set_tuna_mirrorslist
update_system
prepare_Env
get_vlmcsd
unzip_vlmcsd
edit_profile
start_vlmcsd
