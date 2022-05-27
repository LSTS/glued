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
    "https://www.lsts.pt/glued/cloud/package/lctr-rpi4x64/gcc-5.4/busybox-$version.tar.gz"
)

md5=\
(
    '1cc43e17ab20a02b85c9108d35434834'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}

