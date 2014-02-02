version=\
(
    '0.11.1'
)

url=\
(
    "http://www.x.org/releases/X11R7.6/src/everything/renderproto-$version.tar.bz2"
)

md5=\
(
    'a914ccc1de66ddeb4b611c6b0686e274'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

# requires=\
# (
#     'xorg-libx11/default'
#     'renderproto/default'
# )

configure()
{
    "../renderproto-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --disable-static \
        --enable-shared
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make PREFIX="$cfg_dir_toolchain_sysroot/usr" install
}
