version=\
(
    '2.4.6'
)

url=\
(
    "http://ftpmirror.gnu.org/libtool/libtool-$version.tar.gz"
)

md5=\
(
    'addf44b646ddb4e3919805aa88fa7c5e'
)

maintainer=\
(
    "Ricardo Martins <rasm@oceanscan-mst.com>"
)

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain

    "../libtool-$version/configure" \
        --prefix="$cfg_dir_output_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install

    tar -czf ../libtool-v$version.tar.gz ../toolchain
}
