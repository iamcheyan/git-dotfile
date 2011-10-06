#!/usr/bin/env python3
# vim: set fileencoding=utf-8:

import os
import sys
import math
import subprocess


term = os.getenv('TERM')
if term.find('linux') != -1 or term.find('xterm') != -1:
  fsign = '>'
  esign = '0'
else:
  fsign = '▸'
  esign = '▹'

total_slots, slots = 10, []

p = subprocess.Popen(["acpitool", "-b"], stdout=subprocess.PIPE)
output = p.communicate()[0]
output = output.decode('utf8')

try:
  # XXX: `acpitool -b` has been broken since 10/16/2011
  status = [o.strip() for o in output.split(':', 1)[1].split(',')]
  filled = int(math.ceil(float(status[1][:-1])) * 0.1) * fsign
except IndexError:
  charge_full = int(open('/sys/class/power_supply/BAT0/charge_full').read())
  charge_now = int(open('/sys/class/power_supply/BAT0/charge_now').read())
  filled = math.floor((charge_now / charge_full) * 10) * fsign

empty = (total_slots - len(filled)) * esign
out = filled + empty

color_green = '%{[32m%}'
color_yellow = '%{[1;33m%}'
color_red = '%{[31m%}'
color_reset = '%{[00m%}'
color_out = (
  color_green if len(filled) > 6
  else color_yellow if len(filled) > 4
  else color_red
)

out = color_out + out + color_reset

sys.stdout.write(out)
