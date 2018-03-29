#base:
#  'web:nginx':
#    - match: grain
#    - apache
#
base:
  '*':
    - dns
