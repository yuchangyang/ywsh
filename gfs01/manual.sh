#!/bin/bash

logtime=`date +%F%H%M`
work_path=/tmp/applied/xyfile
#复制文件
while read LINE
do

 #统计复制文件数
 n_INDEX=$(($n_INDEX+1))
 echo "##Copying file numer:$n_INDEX"

 m_gfs_src=$LINE
 m_local_src=`echo $LINE|sed "s/mnt\/gluster/data\/brick/"`
 m_nas_dst=`echo $LINE|sed "s/mnt\/gluster/mnt\/nasdata/"`
 
 
 mkdir -p $m_nas_dst 
  
echo "$logtime->Copy $m_local_src to $m_nas_dst"

# m_PATH_Dest=`echo $LINE|sed "s/data\/brick/mnt\/nasdata/" | cut -d"/" -f1-11`
# echo "cp -npR $m_PATH_Source $m_PATH_Dest >>cp.log 2>&1" >>$work_path/cp.out


cp -npR $m_local_src/*.* $m_nas_dst/ >>$work_path/manual.log 2>&1

echo '############GFS files and dircatory list:############'
ls -al $m_local_src/
echo '############NAS files and dircatory list:############'
ls -al $m_nas_dst/

done < $work_path/pdf
