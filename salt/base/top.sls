#base:
#  'web:nginx':
#    - match: grain
#    - apache
#
base:
  '*':
    - init.env_init
