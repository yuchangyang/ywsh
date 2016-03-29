#!/bin/bash

src_path=/home/welend/benson/data/config
work_path=/home/welend/xiaoayang/xyfile
#work_path=/tmp/applied/xyfile
data_path=$work_path/data_files
tar_path=$work_path/tar_files
filename=data.csv
dataname=data`date +%F%H`.csv
logtime=`date +%F%H%M`

#Download files from pjr11 
scp pjr11:$src_path/$filename $data_path/$dataname
if [ $? -ne 0 ];then
 　echo "$logtime ->get data file failed!"
   exit 1
else
   echo "$logtime ->======================"
   echo "$logtime ->get data file OK!"
fi

ofile_hash=`cat $data_path/hash.d|awk '{print $1}'`
nfile_hash=`md5sum $data_path/$dataname |awk '{print $1}'`

#检测与文件是否更新
if [ "$ofile_hash" = "$nfile_hash" ];then
   echo "$logtime ->Push DataFile no update,waiting for next update time!" >> $work_path/cp_logs/error.d
   exit 1
else
   echo $nfile_hash > $data_path/hash.d
fi

#Download files from pjr11 
#scp pjr11:$src_path/$filename $data_path/$dataname 
#if [[ $? > 0 ]];then
# 　echo "##get data file failed!"
#   exit 1 
#else
#   echo "##get data file OK!"
#fi

#Send data file to gfs3 server
scp $data_path/$dataname fs-node3:$data_path/
if [ $? -ne 0 ];then
 　echo "$logtime ->send data file to gfs3 failed!"
   exit 1
else
   echo "$logtime ->send data file to gfs3 OK!"
fi
 
#Send data file to gfs5 server
scp $data_path/$dataname fs-node5:$data_path/
if [ $? -ne 0 ];then
 　echo "$logtime ->send data file to gfs5 failed!"
   exit 1
else
   echo "$logtime ->send data file to gfs5 OK!"
fi

