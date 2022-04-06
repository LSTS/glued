version=\
(
    '1.16'
)
url=\
(
    "http://ftp.gnu.org/gnu/automake/automake-$version.tar.gz"
)

md5=\
(
    '7fb7155e553dc559ac39cf525f0bb5de'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'autoconf/rpi4-host'
)

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain

    "../automake-$version/configure" \
        --prefix="$cfg_dir_output_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install

    tar -czf ../automake-v$version..tar.gz ../toolchain
}
