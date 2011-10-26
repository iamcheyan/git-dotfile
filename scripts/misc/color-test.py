#!/usr/bin/env python3
# fileencoding=utf-8
'''测试终端对色彩的支持'''

for i in range(30, 38):
  for j in range(40, 48):
    print('\x1b[0;%dm\x1b[%dm%d %d |\x1b[m' % ((i, j)*2), end='')
  print()

print()

for i in range(30, 38):
  for j in range(40, 48):
    print('\x1b[1;%dm\x1b[%dm%d %d |\x1b[m' % ((i, j)*2), end='')
  print()

print()

for i in range(30, 38):
  for j in range(40, 48):
    print('\x1b[%dm\x1b[5;%dm%d %d |\x1b[m' % ((i, j)*2), end='')
  print()

print()

print('\x1b[0m 0m|\x1b[mnone')
print('\x1b[1m 1m|\x1b[mnone')
print('\x1b[2m 2m|\x1b[mnone')
print('\x1b[3m 3m|\x1b[mnone')
print('\x1b[4m 4m|\x1b[mnone')
print('\x1b[5m 5m|\x1b[mnone')
print('\x1b[6m 6m|\x1b[mnone')
print('\x1b[7m 7m|\x1b[mnone')
print('\x1b[8m 8m|\x1b[mnone')
print('\x1b[9m 9m|\x1b[mnone')
