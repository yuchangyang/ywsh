#!/bin/bash
m_infile=$1
#work_path=/tmp/applied/xyfile
work_path=/home/welend/xiaoayang/xyfile
m_outfile=list.out
n_INDEX=0

#编码路径列表
cat $m_infile | awk -vFS=''  '{printf"%s%s/%s%s/%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$40}'| xargs -i printf "%s%s\n" /data/brick/production/api/rocket2/public/system/documents/ {} >$work_path/$m_outfile

#创建目标目录
cat $work_path/$m_outfile | sed "s/data\/brick/mnt\/nasdata/" | xargs -i mkdir -p {}

#复制文件
while read LINE
do
n_INDEX=$(($n_INDEX+1))
echo "##Copying file numer:$n_INDEX"
m_PATH_Source=$LINE
m_PATH_Dest=`echo $LINE|sed "s/data\/brick/mnt\/nasdata/" | cut -d"/" -f1-11`

echo "cp -npR $m_PATH_Source $m_PATH_Dest >>cp.log 2>&1" >>$work_path/cp.out
cp -npR $m_PATH_Source $m_PATH_Dest >>$work_path/cp_logs/cp_out.log 2>&1

done < $work_path/$m_outfile
