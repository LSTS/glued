source $pkg_common

configure()
{
    cd "$pkg_build_dir" &&
    tar -C "../ncurses-$version" -c -f - . | tar -x -f - &&
    ./configure \
        --prefix="$cfg_dir_toolchain" \
	--disable-nls \
        --with-shared
}

build()
{
    $cmd_make -C "$pkg_build_dir"
}

host_install()
{
    $cmd_make -C "$pkg_build_dir" install
}
