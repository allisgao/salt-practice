# 文件名
/etc/resolv.conf:
  # 状态和方法的声明
  file.managed:
    # 这里，位置是相对的。salt:// 在本环境默认的是/srv/salt/base
    - source: salt://init/files/resolv.conf
    - user: root
    - group: root
    - mode: 644
