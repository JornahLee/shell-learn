#! /bin/bash


#i=$(ls)
## i=$(ls) 取到的是命令的标准输出，即输出到屏幕的内容保存到i
#而 if后的 ls ， 是执行ls命令输出到显示器，然后将命令执行结果 true or false返回。

if ls -1123f ;then
  echo "666"
  else echo "111"
fi

#echo $i
##i=$(ps)
#if ls ;then
#  echo "success"
#fi
#
##echo "$i"
#echo "-----"
#echo "-----"
#echo "123-$(true)"
#
#echo "------"
##if test 5 -ne 4 && test 4 -ne 5;then echo "YES"; else echo "NO"; fi
#
#if   [ ! 5 -eq 5 ];then echo "YES"; else echo "NO"; fi

#
#if true; then
#  echo "YES";
#else echo "NO";
#fi
#
#if false && true; then
#  echo "YES";
#else echo "NO";
#fi
#
#if false || true; then
#  echo "YES";
#else echo "NO";
#fi
#
#if ! false; then
#  echo "YES"
#fi