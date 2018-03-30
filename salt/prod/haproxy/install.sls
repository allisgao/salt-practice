include:
  # 源码安装，依赖gcc。。。
  - pkg.pkg-init

# 源码安装
haproxy-install:
  file.managed:
    - name: /usr/local/src/haproxy-1.6.2.tar.gz
    - source: salt://haproxy/files/haproxy-1.6.2.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf haproxy-1.6.2.tar.gz && cd haproxy-1.6.2 && make TARGET=linux26 PREFIX=/usr/local/haproxy && make install PREFIX=/usr/local/haproxy
