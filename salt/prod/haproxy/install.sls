include:
  # 源码安装，依赖gcc。。。
  - pkg.pkg-init

# 源码安装
## ID。需要name声明的。
haproxy-install:
  file.managed:
    - name: /usr/local/src/haproxy-1.6.2.tar.gz
    - source: salt://haproxy/files/haproxy-1.6.2.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf haproxy-1.6.2.tar.gz && cd haproxy-1.6.2 && make TARGET=linux26 PREFIX=/usr/local/haproxy && make install PREFIX=/usr/local/haproxy

    # 状态间关系检查。如果目录存在，就不执行。
    - unless: test -d /usr/local/haproxy

    # 依赖条件
    - require:
      ## 依赖于pkg初始化模块。如果该模块没有正确执行，就不必往下走了。
      - pkg: pkg-init
      ## 依赖文件模块。依赖于haproxy-install下的文件模块
      - file: haproxy-install

# 启动
## 这里是name声明。不是ID，就是name声明
## name声明就不需要“ - name: ”了。
# /etc/init.d/haproxy:
#   file.managed:
#     - source: salt://haproxy/files/haproxy.init
#     - user: root
#     - group: root
#     - mode: 755
#     - require:
#       - cmd: haproxy-install



# ID声明，有name
## 创建目录，存放配置文件
haproxy-config-dir:
  file.directory:
    - name: /etc/haproxy
    - user: root
    - group: root
    - mode: 755

# 修改内核参数
net.ipv4.ip_nonlocal_bind:
  sysctl.present:
    - value: 1

# 开机自启动
haproxy-init:
  # 文件管理
  file.managed:
    - name: /etc/init.d/haproxy
    - source: salt://haproxy/files/haproxy.init
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: haproxy-install
  cmd.run:
    - name: chkconfig --add haproxy
    - unless: chkconfig --list|grep haproxy
    - require:
      - file: haproxy-init
