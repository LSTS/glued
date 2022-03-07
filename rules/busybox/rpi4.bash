# To activate the ftp for logs use the configuration 
# var $cfg_lsts_ftp_logs_path. Otherwise will be disabled.
# To activate the ftp for logs use the service "lsts_ftp_logs".

version=\
(
    '1.34.1'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4/busybox-$version.tar.gz"
)

md5=\
(
    '408b6da634ea4fb0fad2abb1508ac275'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}

