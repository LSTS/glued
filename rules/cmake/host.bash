version=\
(
    "2.8.9"
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
    "801f4c87f8b604f727df5bf1f05a59e7"
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
