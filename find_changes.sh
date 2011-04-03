#!/bin/sh

clear
for FILE in `ls -A `; 
do echo $FILE; 
diff $FILE ~/$FILE; 
echo '==========================='
done
