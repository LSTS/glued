version=\
(
    "3.0.0"
)

url=\
(
    "ftp://ftp.info-zip.org/pub/infozip/src/zip30.tgz"
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
