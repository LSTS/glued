version=\
(
    "3.0.0"
)

url=\
(
    "http://downloads.sourceforge.net/infozip/Zip%203.x%20%28latest%29/3.0/zip30.tar.gz"
)

md5=\
(
    "7b74551e63f8ee6aab6fbc86676c0d37"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

build()
{
    cd ../zip30 &&
    $cmd_make -f unix/Makefile generic
}

host_install()
{
    cd ../zip30 &&
    $cmd_make prefix="$cfg_dir_toolchain" -f unix/Makefile install
}
