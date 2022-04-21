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
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/busybox-$version.tar.gz"
)

md5=\
(
    'b03151d4a51913344ce361b5326414d0'
)

post_unpack()
{
    $cmd_cp ../rootfs/* $cfg_dir_rootfs
}

