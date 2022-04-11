version=\
(
    '1.06'
)

url=\
(
    "http://ftp.gnu.org/gnu/bc/bc-$version.tar.gz"
)

md5=\
(
    'd44b5dddebd8a7a7309aea6c36fda117'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'flex/a6xx-host'
)

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain
    ./configure \
        --prefix="$cfg_dir_output_toolchain" \
        --disable-shared \
        --enable-static
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
    tar -czf ../bc-v$version-host.tar.gz ../toolchain
}
