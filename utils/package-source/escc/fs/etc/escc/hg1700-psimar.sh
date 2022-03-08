# Channels:
# * 0: Honeywell HG1700
# * 1: LSTS PSIMAR

# Create channels.
/usr/bin/setescc 0 0x200 5 0 0 0
/usr/bin/setescc 1 0x200 5 0 0 1

# Set clocks (Hz).
"$cmd_escc_set_clock" 0 1000000
"$cmd_escc_set_clock" 1 25804800

# Set registers.
/usr/bin/esccsettings 0 /etc/escc/hg1700.cfg
/usr/bin/esccsettings 1 /etc/escc/psimar.cfg
