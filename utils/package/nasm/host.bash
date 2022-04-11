version=\
(
    "2.07"
)

url=\
(
    "http://www.nasm.us/pub/nasm/releasebuilds/$version/nasm-$version.tar.bz2"
)

md5=\
(
    "d8934231e81874c29374ddef1fbdb1ed"
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    mkdir -p $cfg_dir_builds/$pkg/toolchain
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain
    ./configure \
        --prefix="$cfg_dir_output_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
    tar -czf ../nasm-v$version-host.tar.gz ../toolchain
}
