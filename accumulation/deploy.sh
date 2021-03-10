#! /bin/bash
## author:licong
## 用于部署api实例，指定雪花算法的machineId

function enablePortInNginx(){
  port=$1
  #enable  port config in nginx
  sed -i "" "s/#.*$port.*/server 127.0.0.1:$port weight=20;/g" "$nginxConfigFile"
}

function disablePortInNginx(){
  port=$1
  #disable  port config in nginx
  sed -i "" "s/server.*$port.*/#&/g" "$nginxConfigFile"
}

function killAppWithPort(){
  port=$1
  ps -ef |grep "$appName.*$port" | grep -v grep |awk '{print $2}'|xargs kill -15
}

function killAppWithPort(){
  appName=$1
  port=$2
  sudo java -jar
}


jarPath=$1
ports=$2
appName=$3
nginxConfigFile=$4

echo "running shell name : $0"
echo "deploy path : $1"
echo "deploy ports : $2"

#cd deployPath || exit;

all_port=(${ports//,/ })
for port in "${all_port[@]}"
do
  printf "kill with %s \n" "${port}"
#  killAppWithPort "${port}"
  printf "disable  %s config in nginx \n" "${port}"
  disablePortInNginx "${port}"
done

#xargs 将上一条命令的结果，作为下一条命令的参数

#ps -ef |grep "jornah.+ $port" | grep -v grep |awk '{print $2}'|xargs kill -15 | xargs echo
ps -ef |grep "redis" | grep -v grep |awk '{print $2}'|xargs kill -15
ps -ef|grep redis

##过滤掉grep搜索进程
#1.grep 是查找含有指定文本行的意思，比如grep test 就是查找含有test的文本的行
#2.grep -v 是反向查找的意思，比如 grep -v grep 就是查找不含有 grep 字段的行
ps aux | grep init | grep -v grep


#pgrep相当于 ps –eo pid,cmd | awk ‘{print $1,$2}’ | grep KeyWord
#pgrep查找的是程序名，不包括其参数, 所以还是grep好使

