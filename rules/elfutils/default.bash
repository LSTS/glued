version=\
(
    '0.180'
)

url=\
(
    "ftp://sourceware.org/pub/elfutils/$version/elfutils-$version.tar.bz2"
)

md5=\
(
    '23feddb1b3859b03ffdbaf53ba6bd09b'
)

requires=\
(
    'zlib/host'
    'zlib/default'
)

configure()
{
    MAKEINFO='/bin/true' \
    "./configure" --disable-debuginfod \
        --build="$cfg_host_canonical" \
        --target="$cmd_target_prefix" \
        --host="$cfg_host_canonical" \
        --prefix="$cfg_dir_toolchain" \
        CC="$cmd_target_cc" \
        CXX="$cmd_target_cxx"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
