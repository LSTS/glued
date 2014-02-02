# IMU
/usr/bin/setescc 0 0x200 5 0 0 0
/usr/bin/esccclock 0 0x5d1460 23
/usr/bin/esccsettings 0 /etc/escc/hg1700.cfg

# PSIMAR
/usr/bin/setescc 1 0x200 5 0 0 1
/usr/bin/esccsettings 1 /etc/escc/psimar.cfg
/usr/bin/esccclock 1 0xc8920 22
