#!/bin/bash

src_path=/home/welend/benson/data/config
work_path=/home/welend/xiaoayang/xyfile
#work_path=/tmp/applied/xyfile
data_path=$work_path/data_files
tar_path=$work_path/tar_files
dataname=$1

scp $work_path/$dataname fs-node3:$work_path/
if [ $? -ne 0 ];then
 　echo "$logtime ->send data file to gfs3 failed!"
   exit 1
else
   echo "$logtime ->send data file to gfs3 OK!"
fi
 
#Send data file to gfs3 server
scp $work_path/$dataname fs-node5:$work_path/
if [ $? -ne 0 ];then
 　echo "$logtime ->send data file to gfs5 failed!"
   exit 1
else
   echo "$logtime ->get data file to gfs5 OK!"
fi
