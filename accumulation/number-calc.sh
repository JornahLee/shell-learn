#! /bin/bash

var="get the length of me"
echo ${var:0:3}
echo ${var:(-2)}   # 方向相反呢

echo $(expr substr $var 5 3) #记得把$var引起来，否则expr会因为空格而解析错误

#for i in {1..5};
#do
#  echo $i;
#done;
#
#echo "参数个数：$#"
#i=$((i+1))
#echo "$i"
#((i++))
#echo "$i"
#((i=i+12))
#echo "$i"
#((i=i**2)) #平方 2
#echo "$i"
#((i=i%10)) #取模
#echo "--- $i ---"
#((i=i/4))
#echo "$i"
#
#
#echo "---antiquated----"
## antiquated 过时的，但是可以了解下
#let i++
## antiquated 过时的
#expr "$i" + 1
#echo $i