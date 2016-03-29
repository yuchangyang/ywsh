#!/bin/bash

src_path=/home/welend/benson/data/config
work_path=/home/welend/xiaoayang/xyfile
#work_path=/tmp/applied/xyfile

data_path=$work_path/data_files
tar_path=$work_path/tar_files
filename=data.csv
dataname=data`date +%F%H`.csv

#Download files from pjr11 
scp pjr11:$src_path/$filename $data_path/$dataname
if [ $? -ne 0 ];then
 　echo "get data file failed!"
   exit 1
else
   echo "get data file OK!"
fi
