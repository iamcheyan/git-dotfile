#!/usr/bin/env python3
# vim:fileencoding=utf-8
'''
获取路由器上的网速
'''

import time
import urllib.request

from myutils import filesize

STATUS_URL = 'http://192.168.1.1/userRpm/StatusRpm.htm'
INTERNAL = 1

passwordmgr = urllib.request.HTTPPasswordMgrWithDefaultRealm()
passwordmgr.add_password(None, 'http://192.168.1.1/', 'admin', 'admin888')

urlopener = urllib.request.build_opener(
  urllib.request.HTTPBasicAuthHandler(passwordmgr),
)

def getbytes():
  res = urlopener.open(STATUS_URL)
  data = res.read().decode('gb18030')
  it = iter(data.split('\n'))
  while True:
    l = next(it)
    if 'statistList' in l:
      break
  bytes_num = int(next(it).split(',')[0])
  return bytes_num

def getspeed():
  a = getbytes()
  time.sleep(INTERNAL)
  b = getbytes()
  return filesize((b - a) / INTERNAL) + '/s'

if __name__ == '__main__':
  try:
    print(getspeed())
  except KeyboardInterrupt:
    pass
