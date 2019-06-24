---
title: mysql主从配置
comments: true
date: 2019-06-24 13:17:48
categories: mysql
tags:
    - mysql
    - slave
    - 主从复制
---

# mysql主从配置
` 主IP 10.72.45.63 从IP 192.168.10.128`
## 找到windows下的my.ini文件,增加log-bin以及服务id
``` shell
log-bin=mysql-bin   #[必须]启用二进制日志
server-id=63      #[必须]服务器唯一ID，默认是1，一般取IP最后一段;
```

## 找到LINUX下的my.cnf文件增加log-bin以及服务id
```
log-bin=mysql-bin   #[必须]启用二进制日志
server-id=128      #[必须]服务器唯一ID，默认是1，一般取IP最后一段;
```
<!-- more -->
## 复制完成后重启mysql,windows下不做阐述,linux下
```
/etc/init.d/mysqld restart
```

## 设置主库slave
一般不用root帐号，`“%”`表示所有客户端都可能连，只要帐号，密码正确，
此处可用具体客户端IP代替，如`192.168.10.128`，加强安全。 `mysync`代表用户名`q123456`代表连接的密码
```
GRANT REPLICATION SLAVE ON *.* to 'mysync'@'%' identified by 'q123456';
```

## 查看数据库状态
查询主服务器的mysql，master的状态,会有俩参数`file`和`position`有值就行。
```
show master status;
```

## 配置从库slave
>注意不要断开，`325`数字前后无单引号.
`master_host`为主库IP,`master_user`为主库账号,`master_password`为主库密码.
`master_log_file`为执行完show master status;后展示的`file`的值,`master_log_pos`为`position`的值。
```
change master to master_host='10.72.45.63',master_user='mysync',master_password='q123456',master_log_file='mysql-bin.000001',master_log_pos=325;
```

## 启动从服务器复制功能
```
start slave;

#检查从服务器复制状态

show slave status;

Slave_IO_State: Waiting for master to send event
Master_Host: 192.168.2.222  //主服务器地址
Master_User: mysync   //授权帐户名，尽量避免使用root
Master_Port: 3306    //数据库端口，部分版本没有此行
Connect_Retry: 60
Master_Log_File: mysql-bin.000004
Read_Master_Log_Pos: 600     //#同步读取二进制日志的位置，大于等于Exec_Master_Log_Pos
Relay_Log_File: ddte-relay-bin.000003
Relay_Log_Pos: 251
Relay_Master_Log_File: mysql-bin.000004
Slave_IO_Running: Yes    //此状态必须YES
Slave_SQL_Running: Yes     //此状态必须YES
```
## 主从配置出错,重启主从
如果配置从库的时候出错
    1. 用`stop slave`先关闭从库复制功能,
    2. 然后用`show masterstatus;`查询主库状态(因为在关闭从库复制后主库position会`发生变化`),
    3. 最后chanage master命令重新配置从库