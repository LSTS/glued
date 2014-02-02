version=\
(
    "1.13"
)

url=\
(
    "http://ftp.gnu.org/gnu/libiconv/libiconv-$version.tar.gz"
)

md5=\
(
    "048032a3032ebd182150bdee30a5d533"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    ../libiconv-$version/configure \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --disable-static \
        --enable-shared \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
