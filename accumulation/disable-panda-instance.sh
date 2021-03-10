#! /bin/bash
## author:licong
## 用于停止api实例，并修改nginx路由配置
jarFile=$1
ports=$2
nginxPath=$3
nginxConfigFile=$4

echo "------input params start----------------"
echo "running shell name : $0"
echo "jarFile : $jarFile"
echo "kill app with ports : $ports"
echo "nginxPath : $nginxPath"
echo "nginx config file : $nginxConfigFile"
echo "------input params end----------------"

function checkInputParams(){
#   if [ -r "$nginxConfigFile" ] && [ -w "$nginxConfigFile" ]; then
   if [ -r "$nginxConfigFile" ] ; then
       printf "nginxConfigFile is ok to read or write \n"
   else
     printf "!! %s is not ready, pls check \n" "$nginxConfigFile"
     exit
   fi

   if [ -x "$nginxPath" ] ; then
       printf "nginx is ok \n"
   else
     printf "!! %s is not ready, pls check \n" "$nginxPath"
     exit
   fi

#   if [ -r "$jarFile" ] ; then
#       printf "jarFile is ok \n"
#   else
#     printf !! "%s is not exists, pls check \n" "$jarFile"
#     exit
#   fi

}

function disablePortInNginx(){
  port=$1
  #disable  port config in nginx
  sudo sed -i "s/server.*$port.*/#&/g" "$nginxConfigFile"
# MacOs: sudo sed -i "" "s/server.*$port.*/#&/g" "$nginxConfigFile"
}

function killAppWithPort(){
  port=$1
  pid=$(ps -ef |grep "$port.*$jarFile" | grep -v grep |awk '{print $2}'|head -1)
#  [ -n "$pid" ] 字符串不为空
  if [ -n "$pid" ];then
    sudo kill -15 "$pid" || (printf "!! kill with pid:%s failed \n" "$pid" ;exit)
  else
      printf "!! not kill , because process with port:%s is not running" "$port"
  fi

}


#cd deployPath || exit;
checkInputParams "$ports"

all_port=("${ports//,/ }")

for port in ${all_port[*]}
do
  printf "disable port %s  in nginx config\n" "$port"
  disablePortInNginx "$port"
  printf "\n"
done
sudo "$nginxPath" reload || (printf "!! nginx config reload failed \n";exit)

for port in ${all_port[*]}
do
  printf "kill with %s \n" "$port"
  killAppWithPort "$port"
  printf "\n"
done