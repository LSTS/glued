# IMU
/usr/bin/setescc 0 0x200 5 0 0 0
/usr/bin/esccsettings 0 /etc/escc/ifog-imu-1-a.cfg

# PSIMAR
/usr/bin/setescc 1 0x200 5 0 0 1
/usr/bin/esccsettings 1 /etc/escc/psimar.cfg
/usr/bin/esccclock 1 0xc8920 22
