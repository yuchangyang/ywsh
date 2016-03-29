#!/bin/bash

src_path=/home/welend/benson/data/config
work_path=/home/welend/xiaoayang/xyfile
#work_path=/tmp/applied/xyfile
data_path=$work_path/data_files
tar_path=$work_path/tar_files
filename=data.csv
dataname=data`date +%F%H`.csv
logtime="`date +%F%H%M`"

if [ -e $data_path/$dataname ];then
   echo "$logtime ->datafile found ! starting to checking file is update..."
else
   echo "$logtime ->sync datafile no found!"
   exit 1   
fi

ofile_hash=`cat $data_path/hash.d|awk '{print $1}'`
nfile_hash=`md5sum $data_path/$dataname |awk '{print $1}'`

echo $ofile_hash
echo $nfile_hash
#检测与文件是否更新
if [ "$ofile_hash" != "$nfile_hash" ];then
   echo "$logtime ->DataFile was not update,data sync failed!" >> $work_path/cp_logs/error.log
#   exit 1
else
   echo $nfile_hash > $data_path/hash.d
   echo "$logtime ->starting to import datafile!"
fi

#检测文件内容
ls $data_path/$dataname;cat -nA $data_path/$dataname >> $work_path/cp_logs/checklogs.log

#执行同步文件脚本

sh $work_path/copy_image.sh $data_path/$dataname

#打包与清除
tar -cvf $tar_path/`date +%F%H%M`.tar $data_path/*.csv  $work_path/*.out  $work_path/cp_logs/*.log 
rm $data_path/*.csv  $work_path/*.out  $work_path/cp_logs/*.log
tar -tvf $tar_path/`date +%F%H%M`.tar  >> $tar_path/tarlogs.log
