---
title: Centos6.5升级openSSH7.8版本
date: 2019-06-17 13:15:33
tags: [linux,openssh,openssl,telnet]
categories:
    - linux - openSSH
---


-----

## 准备工作


### 查看是否安装telnet
```
rpm -qa |grep telnet
```

### 安装telnet
```
1. yum install xinetd

2. yum install telnet

3. yum install telnet-server
```

>如果安装时报错,说明yum的源不对,可设置本地挂载,从官网下载yum的源文件,上传至服务器,修改/etc/yum.repos.d/rhel-source.repo 文件,具体的自行百度


### 修改disable yes为no
```
vi /etc/xinetd.d/telnet
```

### 重新启动
```
service xinetd restart
```

### 防火墙增加23端口

```
vi /etc/sysconfig/iptables

-A INPUT -p tcp -m tcp --dport 23 -j ACCEPT
```

### 重启防火墙
```
service iptables restart
```
### 查看防火墙规则

```
 iptables --list -n
```

### 安装依赖包
>先执行`whereis zlib` 如果有输出文件目录就不用执行下面的安装
```
yum -y install gcc pam-devel zlib-devel
```
<!-- more -->
### 查看是否成功

```
 whereis zlib
```

## 安装openssl

### 备份openssl
```
mv /usr/bin/openssl /usr/bin/openssl.old

mv /usr/include/openssl/ /usr/include/openssl.old
```
### 解压源码并安装openssl
```
1. tar xf openssl-1.0.2h.tar.gz 
2. cd openssl-1.0.2h/
3. ./config --shared zlib //必须加上--shared,否则编译时会找不到新安装的openssl的库而报错,默认安装目录为/usr/local/ssl/
4. make
5. make test //这一步结果必须为pass才能继续
6. make install
7. ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl 
8. ln -s /usr/local/ssl/include/openssl /usr/include/openssl
9. echo "/usr/local/ssl/lib"> /etc/ld.so.conf.d/openssl.conf
10. ldconfig
11. openssl version -a
```

## 安装openssh

### 备份openssh

```
1. mv /etc/init.d/sshd /etc/init.d/sshd.old
2. mv /etc/ssh /etc/ssh.old
3. mv /usr/sbin/sshd /usr/sbin/sshd.old
4. mv /usr/bin/ssh /usr/bin/ssh.old
```

### 解压并安装openssh

```
1. tar xf openssh-7.8p1.tar.gz
2. cd openssh-7.8p1
3. ./configure --prefix=/usr/local/openssh --sysconfdir=/etc/ssh --with-pam --with-ssl-dir=/usr/local/ssl --with-md5-passwords -mandir=/usr/share/man --with-zlib 
4. make && make install
5. cp contrib/redhat/sshd.init /etc/init.d/sshd
6. chmod +x /etc/init.d/sshd
7. cp /usr/local/openssh/sbin/sshd /usr/sbin/sshd
8. cp /usr/local/openssh/bin/ssh /usr/bin/
9. ssh -V #查看版本
10. /etc/init.d/sshd restart 或 service sshd restart
```


### 测试是否可以连接
```
ssh sdwz@10.72.11.124

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the RSA key sent by the remote host is
SHA256:SfqGfJPlzcmIvgC+9sSyGKM5EULvrvRrXcU9Zjctvy4.
Please contact your system administrator.
Add correct host key in C:\\Users\\li_lfang/.ssh/known_hosts to get rid of this message.
Offending RSA key in C:\\Users\\li_lfang/.ssh/known_hosts:3
RSA host key for 10.72.11.124 has changed and you have requested strict checking.
Host key verification failed.

```
> 出现这些信息 把用户的.ssh文件夹下的known_hosts改名或删除即可

连接成功后,执行
```
1. service xinetd stop # 停止telnet
2. vi /etc/sysconfig/iptables #删除23的规则
3. service xinetd stop #重启防火墙
5. iptables --list -n #查看是否有23的规则
6. vi /etc/xinetd.d/telnet # 修改telnet配置中的disable为no
```
关闭telnet服务即可 `如果担心ssh不可用,可先不关闭,等待几天再关`
