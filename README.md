# pre-installation
包括两个脚本：
1.pre_Analyzing_Hardware.sh
先系统安装之前显示当前系统的配置，包括CPU型号，核数；内存大小，容量；网卡型号；硬盘容量。

使用方法：
将脚本中的内容粘贴到Kickstart文件以下标签中间
%pre

%end
2.pre_Disk_Partition.sh
使用方法：

将脚本中的内容粘贴到Kickstart文件以下标签中间,并注释掉原本的关于磁盘分区的相关配置。

%include /tmp/part-file
%pre

%end
