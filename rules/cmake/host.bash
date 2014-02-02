version=\
(
    "2.8.8"
)

version_major=\
(
    "$(echo $version | cut -d. -f1-2)"
)

url=\
(
    "http://www.cmake.org/files/v$version_major/cmake-$version.tar.gz"
)

md5=\
(
    "ba74b22c788a0c8547976b880cd02b17"
)

configure()
{
    ./configure \
        --prefix="$cfg_dir_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
