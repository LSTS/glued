# Channels:
# * 0: iMAR iFOG-IMU-1-A
# * 1: LSTS PSIMAR

# Create channels.
/usr/bin/setescc 0 0x200 5 0 0 0
/usr/bin/setescc 1 0x200 5 0 0 1

# Set clock.
"$cmd_escc_set_clock" 1 25804800

# Set registers.
/usr/bin/esccsettings 0 /etc/escc/ifog-imu-1-a.cfg
/usr/bin/esccsettings 1 /etc/escc/psimar.cfg
