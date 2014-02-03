version=\
(
    '0.9.18'
)

url=\
(
    "http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-$version.tar.bz2"
)

md5=\
(
    '0bff05fafef4894031b2b64a65ac1899'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'glib/default'
    'icu4c/default'
    'freetype2/default'
)

configure()
{
    "../harfbuzz-$version/configure" \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
