version=\
(
    '2.69'
)

url=\
(
    "http://ftp.gnu.org/gnu/autoconf/autoconf-$version.tar.gz"
)

md5=\
(
    "82d05e03b93e45f5a39b828dc9c6c29b"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

requires=\
(
    'm4/rpi4-host'
)

configure()
{
    mkdir $cfg_dir_builds/$pkg/toolchain
    export cfg_dir_output_toolchain=$cfg_dir_builds/$pkg/toolchain

    "../autoconf-$version/configure" \
        --prefix="$cfg_dir_output_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install

    tar -czf ../autoconf-v$version..tar.gz ../toolchain
}
