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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi2.3/gcc-5.4/busybox-$version.tar.gz"
)

md5=\
(
    'f8dd7d5a41499b221f324b50f1f77b00'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}

