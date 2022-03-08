version=\
(
    "1.2.0"
)

url=\
(
    "ftp://ftp.infradead.org/pub/mtd-utils/mtd-utils-$version.tar.bz2"
)

md5=\
(
    "ca41f1fbaa056e8b8d71e8d52c0b1bad"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

build()
{
    $cmd_make mkfs.jffs2
}

target_install()
{
    cp -a mkfs.jffs2 ${cfg_dir_toolchain}/bin
}
