version=\
(
    "0.28"
)

url=\
(
    "http://pkgconfig.freedesktop.org/releases/pkg-config-$version.tar.gz"
)

md5=\
(
    "aa3c86e67551adc3ac865160e34a2a0d"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain

    ./configure \
        --prefix="${cfg_dir_output_toolchain}" \
        --disable-shared \
        --enable-static \
        --with-internal-glib
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install

    tar -czf ../pkg-config-v$version.tar.gz ../toolchain
}
