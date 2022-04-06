version=\
(
    "3.5.2"
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
    "701386a1b5ec95f8d1075ecf96383e02"
)

configure()
{
    ./configure \
        --prefix="$cfg_dir_toolchain"
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
