version=\
(
    "2.5.2"
)

url=\
(
    "http://sourceforge.net/projects/freetype/files/ftjam/$version/ftjam-$version.tar.bz2"
)

md5=\
(
    "e61304b370ba06f68082f0219a196576"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

requires=\
(
    'bison/rpi4-host'
)

build()
{
    $cmd_make CC="$cmd_target_cc"
}

configure()
{

    mkdir $cfg_dir_builds/$pkg/toolchain
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain

    ../ftjam-$version/configure \
        --prefix="$cfg_dir_output_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install

    tar -czf ../ftjam-v$version.tar.gz ../toolchain
}
