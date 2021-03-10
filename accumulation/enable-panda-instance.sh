#! /bin/bash
## author:licong
## 用于部署api实例
healthCheckMaxLimit=10

# mac pc: /usr/local/Cellar/nginx/1.19.0/bin/nginx
jarFile=$1
ports=$2
nginxPath=$3
nginxConfigFile=$4
heapSize=$5

echo "------input params start----------------"
echo "running shell name : $0"
echo "jarFile : $jarFile"
echo "kill app with ports : $ports"
echo "nginxPath : $nginxPath"
echo "nginx config file : $nginxConfigFile"
echo "heapSize : $heapSize"
echo "------input params end----------------"

function checkInputParams(){
#   if [ -r "$nginxConfigFile" ] && [ -w "$nginxConfigFile" ]; then
   if [ -r "$nginxConfigFile" ]; then
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

   if [ -r "$jarFile" ] ; then
       printf "jarFile is ok \n"
   else
     printf "!! %s is not exists in cur dir, pls check \n" "$jarFile"
     exit
   fi

}

function enablePortInNginx(){
  port=$1
  #enable  port config in nginx
  sudo sed -i  "s/#.*$port.*/server 127.0.0.1:$port weight=20;/g" "$nginxConfigFile"
# MacOs: sudo sed -i "" "s/#.*$port.*/server 127.0.0.1:$port weight=20;/g" "$nginxConfigFile"
}

function startAppWithPort(){
  port=$1
# 先判断 app版本和端口是否已经启动，如果已经启动，则忽略
# sudo启动会有两个进程 kill掉第一个即可
  pid=$(ps -ef |grep "$port.*$jarFile" | grep -v grep |awk '{print $2}'|head -1)
  if [ -z "$pid" ]; then
     sudo nohup java -server -Dserver.tomcat.basedir=. -Dserver.port="$port" -jar "$jarFile" --spring.config.name=common,environment --logging.config=config/logback.xml -Xverify:none -Xms"$heapSize" -Xmx"$heapSize" >> /dev/null 2>&1 &
  else
     printf "!! not start , because process with port:%s is running" "$port"
  fi
}

function checkHealthAndReloadNginx(){
  port=$1
  result=''
  healthCheckCount=1
  # -z 字符串的长度为零则为真
  while [ -z "$result" ]
  do
    printf "checking health of port: %s try times : %d \n"  "$port" "$healthCheckCount"
    sleep 10
    response=$(curl localhost:"$port"/health)
    result=$(echo "$response" | grep UP )
    printf "health of port: %s response : %s \n" "$port" "$response"
    ((healthCheckCount++))
    if [ "$healthCheckCount" -gt "$healthCheckMaxLimit" ]; then
      exit
    fi
  done
  if res=$(sudo "$nginxPath" reload) ;then
    printf "nginx of port:%s  reload successfully \n" "$port"
  else
    printf "nginx of port:%s reload failed \n" "$port"
    exit
  fi
  printf " ---------------------------------  \n"
}

#cd "$(dirname "$jarFile")" || exit

checkInputParams "$ports"

all_port=(${ports//,/ })
for port in "${all_port[@]}"
do
  printf "start app with %s \n" "${port}"
  startAppWithPort "${port}"
  printf "\n"
  printf "enable port: %s  in nginx config \n" "${port}"
  enablePortInNginx "${port}"
  printf "\n"
  checkHealthAndReloadNginx "${port}"
done
