# -*- coding: utf-8 -*-
############################################################################
# Copyright (C) 2007-2012 Laboratório de Sistemas e Tecnologia Subaquática #
# Departamento de Engenharia Electrotécnica e de Computadores              #
# Rua Dr. Roberto Frias, 4200-465 Porto, Portugal                          #
############################################################################
# Author: Ricardo Martins                                                  #
############################################################################
# $Id:: download-peers.py 1349 2012-12-06 01:38:21Z rasm                 $:#
############################################################################

import os
import sys
import socket

URL = 'https://docs.google.com/spreadsheet/pub?key=0Aj00gvm9SJiUdDBXU2hpN09uZEpjM1hJanZxWU1aY0E&single=true&gid=4&output=csv'
DOMAIN = '.fe.up.pt'

ADDR = 0
EMAC = 1
WMAC = 2
NAME = 3
DESC = 4

def get_name(line):
    s = line[NAME].strip().lower()
    s = s.replace(' ', '')
    return s

def write_addr(stream, line):
    d = {}
    d['addr'] = line[ADDR].strip()
    d['emac'] = line[EMAC].strip()
    d['wmac'] = line[WMAC].strip()
    d['name'] = get_name(line)

    if d['name'] == '' or d['addr'] == '':
        return

    d['macs'] = ','.join([d['emac'], d['wmac']]).strip(',')
    if d['macs'] == '':
        return

    stream.write('dhcp-host=%(macs)s,id:*,%(addr)s,%(name)s\n' % d)

def write_host(stream, line):
    addr = line[ADDR].strip()
    name = get_name(line)
    fqdn = name + DOMAIN
    desc = line[DESC].strip()
    if addr == '' or name == '':
        return
    stream.write('%-18s %-35s %-35s # %s\n' % (addr, fqdn, name, desc))

def update_file(old, new):
    old_text = ''
    try:
        old_text = open(old).read()
    except:
        pass

    new_text = open(new).read()
    if old_text == new_text:
        os.remove(new)
        return False

    print('Renaming "%s" to "%s"' % (new, old))
    os.rename(new, old)
    return True

import urllib
req = urllib.urlopen(URL)

import csv
lines = req.read().splitlines()
reader = csv.reader(lines)
next(reader)

# Validate list.
lines = []
hosts = {}
count = 0
for line in reader:
    name = get_name(line)
    addr = line[ADDR].strip()
    if name in hosts and name != '':
        print('Duplicated hostname "%s".' % name)
        continue

    try:
        socket.inet_pton(socket.AF_INET, addr)
    except:
        continue

    count = count + 1
    lines.append(line)
    hosts[name] = True

if count == 0:
    print("Refusing to write configuration files without valid addresses.")
    sys.exit(0)

wd = '.'
if len(sys.argv) == 2:
    wd = sys.argv[1]

host_file = os.path.join(wd, 'hosts.txt')
addr_file = os.path.join(wd, 'addrs.conf')
host = open(host_file + '.new', 'w')
addr = open(addr_file + '.new', 'w')
for line in lines:
    write_host(host, line)
    write_addr(addr, line)
host.close();
addr.close();

updated = False
update_file(host_file, host_file + '.new')
update_file(addr_file, addr_file + '.new')
print('Processed %d addresses.' % count)
