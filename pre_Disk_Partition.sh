#!/bin/sh
CreatePartFile(){
	get_disktype=$1
	get_disknu=$2
	if [ $get_disknu -gt 1 ];then
		echo "#Disk partitioning information,datapool in ${get_disktype}b" >>/tmp/part-file
		echo "clearpart --all --initlabel" >>/tmp/part-file
		echo "part swap --fstype=\"swap\" --size=8192 --ondisk=${get_disktype}a">>/tmp/part-file
		echo "part / --fstype=\"ext4\" --grow --size=1 --ondisk=${get_disktype}a">>/tmp/part-file
		echo "part /boot --fstype="ext4" --size=100 --ondisk=${get_disktype}a">>/tmp/part-file
		echo "part /datapool --fstype="ext4" --grow --size=1  --ondisk=${get_disktype}b">>/tmp/part-file

	else
		echo "#Disk partitioning information,datapool in ${get_disktype}a" >>/tmp/part-file
		echo "clearpart --all --initlabel" >>/tmp/part-file
		echo "part swap --fstype=\"swap\" --size=8192  --ondisk=${get_disktype}a">>/tmp/part-file
		echo "part / --fstype=\"ext4\" --size=20480 --ondisk=${get_disktype}a">>/tmp/part-file
		echo "part /boot --fstype="ext4" --size=100 --ondisk=${get_disktype}a">>/tmp/part-file
		echo "part /datapool --fstype="ext4" --grow --size=1  --ondisk=${get_disktype}a">>/tmp/part-file
	fi
}

CheckDiskType(){
       disktype="default"
	disknu=0
	for t in "vd" "sd" "hd";do
		fdisk -l|grep -E "/dev/${t}[a-z]:" >>/dev/null
		if [ $? -eq 0 ];then
			if [ `fdisk -l|grep -E "/dev/${t}[a-z]:"|wc -l` -gt 1 ];then
				disknu=`fdisk -l|grep -E "/dev/${t}[a-z]:"|wc -l`
			else
				disknu=1
			fi
			disktype="$t"
		fi
	done
	CreatePartFile $disktype $disknu
	
}
CheckDiskType
