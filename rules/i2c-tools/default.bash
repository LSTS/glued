version=\
(
    '3.0.2'
)

url=\
(
    "http://www.lsts.pt/glued/i2c-tools-$version.tar.bz2"
)

md5=\
(
    'b546345ac19db56719dea6b8199f11e0'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    $cmd_make CC="$cmd_target_cc"
}

target_install()
{
    $cmd_target_strip tools/i2cdetect -o "$cfg_dir_rootfs/usr/bin/i2cdetect" &&
    $cmd_target_strip tools/i2cget -o "$cfg_dir_rootfs/usr/bin/i2cget" &&
    $cmd_target_strip tools/i2cset -o "$cfg_dir_rootfs/usr/bin/i2cset"
}
