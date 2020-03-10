# Microsoft's KMS server

[![Build Status](https://img.shields.io/travis/com/alvisisme/docker-vlmcsd?style=flat-square)](https://travis-ci.com/alvisisme/docker-vlmcsd)
![Docker Pulls](https://img.shields.io/docker/pulls/alvisisme/vlmcsd?style=flat-square)

Windows KMS 激活服务器，用于激活windows和office套件等。

## 目录

- [背景](#背景)
- [安装](#安装)
- [用法](#用法)
- [维护人员](#维护人员)
- [贡献参与](#贡献参与)
- [许可](#许可)
- [参考引用](#参考引用)

## 背景

KMS（Key Management Service） 是微软为了方便在企业内部批量激活windows系统等推出的服务，通过设定指定的激活服务器并执行特定脚本来进行批量激活和管理。

vlmcsd 是一个KMS服务端模拟程序，能够利用KMS激活原理实现 Windows, Office, Visio等激活，源码公开并能在PC机，路由器，树莓派等各种设备上运行，非常方便。

本工程仅说明如何在通用linux服务器上配置该服务，如需要运行在其它设备上（Android手机等）请自行参考相关资料。需要注意的是，从 windwos 8/8.1 之后，无法使用localhost本地服务地址进行KMS激活(见[vlmcsd issues 6](https://github.com/Wind4/vlmcsd/issues/6#issuecomment-302896783))。

如果需要通过KMS服务激活，需要下载windows/office的大客户（VOL）版本，家庭版是无法通过这种方式激活的，请确保版本对应，windows系统和office软件推荐从 [MSDN I Tell You](https://msdn.itellyou.cn/) 网站上下载。

## 安装

找一个linux服务器执行如下语句启动服务端程序，请自行安装docker

```bash
docker run -d -p 1688:1688 --restart=always --name kms-server alvisisme/vlmcsd
```

或者利用 docker-compose 自行编译并运行

```bash
git clone https://github.com/alvisisme/docker-vlmcsd.git
cd docker-vlmcsd
docker-compose up --build -d
```

记下服务器对外可访问的IP地址 **DOCKER_IP**，客户端配置需要该地址，见 [用法](#用法) 一节

## 用法

客户端安装好windows系统和Office软件后，以**管理员权限**打开终端下执行如下语句，根据需要激活的系统/软件选择对应命令

### Windows
```
slmgr.vbs -upk
slmgr.vbs -ipk XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
slmgr.vbs -skms DOCKER_IP
slmgr.vbs -ato
slmgr.vbs -dlv 
```

### Office x86
```
cd \Program Files (x86)\Microsoft Office\Office16
cscript ospp.vbs /sethst:DOCKER_IP
cscript ospp.vbs /inpkey:xxxxx-xxxxx-xxxxx-xxxxx-xxxxx
cscript ospp.vbs /act
cscript ospp.vbs /dstatusall
```

### Office x86_64
```
cd \Program Files\Microsoft Office\Office16 
cscript ospp.vbs /sethst:DOCKER_IP
cscript ospp.vbs /inpkey:xxxxx-xxxxx-xxxxx-xxxxx-xxxxx
cscript ospp.vbs /act
cscript ospp.vbs /dstatusall
```

其中,

**DOCKER_IP** 是部署服务端程序的服务器地址

**xxxxx-xxxxx-xxxxx-xxxxx-xxxxx** 表示需要激活的系统/软件的 GVLK keys，可以从微软的官方文档上找到。

Office不同版本路径不同，根据自身情况修改目录地址。

## 维护人员

[@Alvis Zhao](https://github.com/alvisisme)

## 贡献参与

欢迎提交PR。

## 许可

本工程仅供本人学习测试使用，请支持正版。

© 2019-2020 Alvis Zhao

## 参考引用

* [Wind4/vlmcsd](https://github.com/Wind4/vlmcsd)
* [mikolatero/docker-vlmcsd](https://github.com/mikolatero/docker-vlmcsd)
* [Emulated KMS Servers on non-Windows platforms](https://forums.mydigitallife.info/threads/50234-Emulated-KMS-Servers-on-non-Windows-platforms)
* [Windows GVLK keys](https://technet.microsoft.com/en-us/library/jj612867(v=ws.11).aspx)
* [Office 2013 GVLK keys](https://technet.microsoft.com/en-us/library/dn385360.aspx)
* [Office 2016 GVLK keys](https://technet.microsoft.com/en-us/library/dn385360(v=office.16).aspx)
