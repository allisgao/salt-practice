# 尽量不使用交换分区
vm.swappiness:
  sysctl.present:
    - value: 0

# [root@salt1 init]# cat /proc/sys/net/ipv4/ip_local_port_range
# 32768   60999
net.ipv4.ip_local_port_range:
  sysctl.present:
    - value: 10000 65000

# 最大打开文件数
fs.file-max:
  sysctl.present:
    - value: 100000
