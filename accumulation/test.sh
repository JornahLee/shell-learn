#! /bin/bash
## author:licong

input=$1
skynetApiBetaHost='110.34.166.95'

skynetApiProdHost='3.1.227.95'

targetHost=""
targetPath=""
localJarPath=""


if [ "$input" = 'jornah-api-beta' ]; then
  echo "upload jornah-api jar"
  echo "not support now"
  exit
elif [ "$input" = 'jornah-api-prod' ]; then
    echo ""
    echo "not support now"
elif [ "$input" = 'sky-api-beta' ]; then
    targetHost="$skynetApiBetaHost";
    echo "not support now"
elif [ "$input" = 'sky-api-prod' ]; then
    targetHost="$skynetApiProdHost";
    echo "scp "
    echo ""
    echo "not support now"
elif [ "$input" = '-h' ]; then
    echo ""
else
  echo "invalid param , input -h for help"
  exit
fi

#if ssh $1 test -e $2;then
#echo '0'
#else
#echo '2'
#fi

#awk 'BEGIN{FS=" "} {print $1}' data.txt|awk 'BEGIN{FS="\n"} {print $1}'

#
#jarFile='springmvc-demo-0.0.1-SNAPSHOT.jar'
#input1='8023'
#port='8023'
##cd ~  || printf "kill with pid:%s failed \n" "$port" ; printf "kil";exit
##cd /123  || (printf "kill with pid:%s failed \n" "$port" ;exit)
#pid=$(ps -ef |grep "$port.*$jarFile" | grep -v grep |awk '{print $2}')
#echo " -$pid-"
#res=`ps -ef|grep redis|grep -v grep`

#echo "---- $res"

#port=8083
#shell中的单引号和双引号的区别
#对于常规的字符串定义变量值应添加双引号，并且等号后不能 有空格，需要强引用的，则需要单引号，需要命令引用的使用反引号。
#单引号：所见即所得，即输出时会将单引号内的所有内容都原样输出，或者描述为单引号里面看到的什么就输出什么，这成为强引用。
#双引号：输出双引号的所有内容；如果内容中有命令（要反引）、变量、特殊转义，会先把变量、命令、转义字符解析出结果，然后在输出最终内容，这称为弱引。
#反引号：一般用于命令，执行的时候命令会被执行，相当于$()，赋值和输出都要用反引号引起来。
#sed -i "s/server.*$port/#&/g" input.txt
#
#sed -i "" "s/server.*$port/#&0/g" input.txt

#sed 正则不支持预查 https://blog.csdn.net/u011729865/article/details/78946707
#sed  's/#\(\?=server\)/123/g' input.txt




##enable  port config in nginx
#sed -i "" "s/#.*$port.*/server 127.0.0.1:$port weight=20;/g" input.txt
#
#
##disable  port config in nginx
#sed -i "" "s/server.*$port.*/#&/g" input.txt
#nginxPath=nginx
#port=8083
#if res=$(sudo "$nginxPath" -a reload) ;then
#  printf "res: %d \n" "$res"
#  printf "nginx of port:%s  reload successfully \n" "$port"
#else
#  printf "res: %d \n" "$res"
#   printf "nginx of port:%s reload failed \n" "$port"
#fi
#printf " ---------------------------------  \n"

# 数值计算
#var1=$((port + 4))
#echo $var1

#流程控制 if else
# for、while 循环
# 变量定义
# 变量引用
# 参数输入 $0代表脚本名
#
# 函数定义： function fun() {var1=$1,var2=$2} 不用定义形参，直接在脚本后加参数即可
# 调用  fun 24 51 ,传入的var1=24 , var2=51
#
#
#
#a=(1 2 0 4)
#for i in ${a[*]} ;do
#  echo "$i"
#done

#./enable-jornah-instance.sh springmvc-demo-0.0.1-SNAPSHOT.jar 8023,8022 /usr/local/Cellar/nginx/1.19.0/bin/nginx /usr/local/etc/nginx/nginx.conf
#
#./disable-jornah-instance.sh springmvc-demo-0.0.1-SNAPSHOT.jar 8023,8022 /usr/local/Cellar/nginx/1.19.0/bin/nginx /usr/local/etc/nginx/nginx.conf
#
#cp /Users/licong/gitRepository/other/accumulation/util-kit/src/main/java/com/jornah/enable-jornah-instance.sh /Users/licong/gitRepository/other/accumulation/springmvc-demo/target
#
#cp /Users/licong/gitRepository/other/accumulation/util-kit/src/main/java/com/jornah/disable-jornah-instance.sh /Users/licong/gitRepository/other/accumulation/springmvc-demo/target



