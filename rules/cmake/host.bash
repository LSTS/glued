version=\
(
    "3.11.1"
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
   "12a3177477e4e2c7bc514193d421dafe"
)

configure()
{
    mkdir -p $cfg_dir_toolchain/usr/local/bin
    ./configure \
        --prefix="$cfg_dir_toolchain" \
        --bindir="/usr/local/bin"
}

build()
{
    # Remove the trailling 'ncurses' folder from the CURSES_INCLUDE_PATH
    cat CMakeCache.txt | sed  '/^CURSES_INCLUDE_PATH/s/\/ncurses$/\//g' > CMakeCache.txt  &&
    $cmd_make
}

host_install()
{
    $cmd_make DESTDIR="$cfg_dir_toolchain" install
}
