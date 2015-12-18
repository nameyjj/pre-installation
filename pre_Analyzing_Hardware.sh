  #!/bin/sh
  echo_info() {
    msg=$1
  # Send to console screen
    (echo "") >/dev/tty1
    (echo "$msg") >/dev/tty1
  }
  echo_info "Analyzing Hardware..."

#第一部分，显示cpu型号及核数
  echo_info "1. CPU Detail info:"    
  cat /proc/cpuinfo|grep -i "model name"|head -n 1 > /dev/tty1
  (echo "Core number     : `cat /proc/cpuinfo|grep -i "model name"|wc -l`") >/dev/tty1

#第二部分，显示单根内存大小及总内存容量
  echo_info "2. Memory Detail info:" 
  dmidecode --type memory|grep -i "Size:"|grep -i "MB" > /dev/tty1
  (echo "Totle Size : `dmidecode --type memory|grep -i Size|grep -i MB|awk 'BEGIN{totle=0}{totle+=$2}END{print totle}'` MB") > /dev/tty1

#第三部分，显示网卡品牌及型号
  echo_info "3. Network controller info:"  
  lspci|grep -i "Ethernet"|awk -F ":" '{print $3}' > /dev/tty1

#第四部分，显示硬盘容量
  echo_info "4. Disk Detail info:" 
  fdisk -l|grep -iE "Disk /dev/sd*|Disk /dev/vd*" > /dev/tty1

#该信息停顿20秒，20秒之后，开始自动安装
sleep 20  
