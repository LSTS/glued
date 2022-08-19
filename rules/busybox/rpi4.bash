# To activate the ftp for logs use the configuration 
# var $cfg_lsts_ftp_logs_path. Otherwise will be disabled.
# To activate the ftp for logs use the service "lsts_ftp_logs".

version=\
(
    'v1.34.1'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/gcc-5.4/rpi4-busybox-$version.tar.gz"
)

md5=\
(
    '408b6da634ea4fb0fad2abb1508ac275'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}

configure()
{
    [[ -z "$cfg_lsts_ftp_logs_path" ]] && err 'Missing "$cfg_lsts_ftp_logs_path" var set! Generating disabled one.'

    rm $cfg_dir_rootfs/etc/lsts-ftp-logs.conf
    echo -n "$([[ -z "$cfg_lsts_ftp_logs_path" ]] && echo '# ')" > $cfg_dir_rootfs/etc/lsts-ftp-logs.conf
    echo -n "30021 stream  tcp     nowait  root    /usr/sbin/ftpd /usr/sbin/ftpd -a root -w " >> $cfg_dir_rootfs/etc/lsts-ftp-logs.conf
    echo -n "$([[ ! -z "$cfg_lsts_ftp_logs_path" ]] && echo "$cfg_lsts_ftp_logs_path" || echo "/opt/lsts/dune/log/$cfg_hostname")" >> $cfg_dir_rootfs/etc/lsts-ftp-logs.conf
}
