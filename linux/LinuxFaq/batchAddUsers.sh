#!/bin/sh
#author:cuzv	email:cuzval@gmail.com
#this script use to add users

#/etc/passwd info
echo "please input username:"
read name
echo "Please input hou many users you want to add? like:10"
read num
n=1
while [ $n -le $num ]
do
	/usr/sbin/useradd $name$n
	n=`expr $n + 1`	
done

# /etc/shadow info
echo "Please input the password:"
read passwd
m=1
while [ $m -le $num ]
do
	echo $passwd | /usr/bin/passwd --stdin $name$m
	m=`expr $m + 1`
done
