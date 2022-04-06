# Channels:
# * 0: Honeywell HG1700

# Create channels.
/usr/bin/setescc 0 0x200 5 0 0 0

# Set clocks (Hz).
"$cmd_escc_set_clock" 0 1000000

# Set registers.
/usr/bin/esccsettings 0 /etc/escc/hg1700.cfg
