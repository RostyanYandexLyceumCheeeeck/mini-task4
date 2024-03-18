#!/bin/bash
exec 2>/dev/null
exec 1>/dev/null

cd $1
git commit --allow-empty -m "Test $2"

for i in $(seq 0 $(($3 -1)));
do
	sh create_script.sh ./ "Good $i" 0
	git add script.sh
	git commit -m "Good $i"
done

for i in $(seq 0 $(($4 -1)));
do
        sh create_script.sh ./ "Bad $i" 1
        git add script.sh
        git commit -m "Bad $i"
done

