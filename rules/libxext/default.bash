version=\
(
    '1.2.0'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/libXext-$version.tar.bz2"
)

md5=\
(
    '9bb236ff0193e9fc1c1fb504dd840331'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    "../libXext-$version/configure" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain_sysroot/usr"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
