version=\
(
    "6.0"
)

url=\
(
    "http://downloads.sourceforge.net/infozip/unzip60.tar.gz"
)

md5=\
(
    "62b490407489521db863b523a7f86375"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

build()
{
    cd ../unzip60 &&
    $cmd_make -f unix/Makefile generic
}

host_install()
{
    cd ../unzip60 &&
    $cmd_make prefix="$cfg_dir_toolchain" -f unix/Makefile install
}
