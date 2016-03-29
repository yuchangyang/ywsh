#!/bin/bash

src_path=/home/welend/benson/data/config
work_path=/home/welend/xiaoayang/xyfile
#work_path=/tmp/applied/xyfile
data_path=$work_path/data_files
tar_path=$work_path/tar_files
filename=data.csv
dataname=data`date +%F%H`.csv
logtime="`date +%F%H%M`"


echo '########### DATA Diractory List ########'
ls -al $data_path | grep csv
echo '########### DATA Files HASH ############'
cat $data_path/hash.d

echo '########### COPY Files Logs ############'
tail $work_path/cp_logs/impdatalog | grep "Copying file numer" | tail -1

echo 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY'
echo 'Y         #Sucessful import log#         Y'
echo 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY'
cat $work_path/cp_logs/impdatalog | grep "starting to import datafile" |tail -1

echo 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
echo 'X         #Check Error log#              X'
echo 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
cat $tar_path/tarlogs.log | grep "error"
cat $work_path/cp_logs/impdatalog | grep "sync datafile no found"
cat $work_path/cp_logs/impdatalog | grep "DataFile updated,data sync failed"
echo '########### TAR Files List ##############'
ls -al $tar_path/*.tar | tail -1

echo '########### TAR Files log ###############'
tail -6 $tar_path/tarlogs.log
echo '########################################'
