#!/bin/bash
#Create by xiaoyang
src_path=/home/welend/benson/data/config
work_path=/home/welend/xiaoayang/xyfile
#work_path=/tmp/applied/xyfile
data_path=$work_path/data_files
tar_path=$work_path/tar_files
filename=data.csv
dataname=data`date +%F%H`.csv
logtime="`date +%F%H%M`"


echo '############DATA Diractory List######################'
ls -al $data_path

echo '############DATA Files HASH######################'
cat $data_path/hash.d

echo '############COPY Files Logs######################'
tail $work_path/cp_logs/impdatalog

echo '############TAR Files List######################'
ls -al $tar_path

echo '############TAR Files log######################'
tail $tar_path/tarlogs.log

echo 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY'
echo 'Y         #Sucessful import log#               Y'
echo 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY'
cat $work_path/cp_logs/impdatalog | grep "starting to import datafile"

echo 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
echo 'X         #Check Error log#                    X'
echo 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
cat $tar_path/tarlogs.log | grep "error"
cat $work_path/cp_logs/impdatalog | grep "sync datafile no found"
cat $work_path/cp_logs/impdatalog | grep "DataFile updated,data sync failed"

echo '##################################################'
