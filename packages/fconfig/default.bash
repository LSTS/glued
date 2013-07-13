version=\
(
    "20080329"
)

url=\
(
    "http://andrzejekiert.ovh.org/software/fconfig/fconfig-$version.tar.gz"
)

md5=\
(
    "dac355e9f2a0f48c414c52e2034b6346"
)

post_unpack()
{
    patch -d ../fconfig -p1 < "$cfg_package_spec_dir"/patches/limits.patch
}

build()
{
    $cmd_make -C ../fconfig CC=$cmd_target_cc
}

target_install()
{
    cp -a ../fconfig/fconfig $cfg_dir_rootfs/usr/sbin
    $cmd_target_strip $cfg_dir_rootfs/usr/sbin/fconfig
}
