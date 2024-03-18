#!/bin/bash

exec 2>/dev/null
exec 1>/dev/null

cd "$1"
mas=( $(git log --pretty=format:"%H" "$2".."$3") )

l=0
r=${#mas[*]}
k=$(($(($r+$l))/2))

while [[ $l < $k && $k < $r ]]; do
	git checkout ${mas[$k]}
	sh $4
	
	if [[ $? != 0 ]];
       	then
		l=$k
	else
		r=$k
	fi
	k=$(($(($r+$l))/2))
done

git checkout "${mas[$l]}"
sh $4
if [[ $? != 0 ]];
then
	git checkout ${mas[$r]}
	sh $4
	exec 1>&0
	if [[ $? != 0 ]];
	then 
		echo ${mas[$r]}
	else
		echo ${mas[$l]}
	fi
else
	exec 1>&0
	echo -1
fi
	
