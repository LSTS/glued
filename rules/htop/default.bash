version=\
(
    '2.2.0'
)

url=\
(
    "https://hisham.hm/htop/releases/$version/htop-$version.tar.gz"
)

md5=\
(
    '0d816b6beed31edc75babcfbf863ffa8'
)

maintainer=\
(
    'Jose Pinto <zepinto@lsts.pt>'
)

requires=\
(
    'ncurses/default'
)

build()
{
    $cmd_make
}

configure()
{
    cd "../htop-$version"
    ./configure --disable-unicode \
    --disable-dependency-tracking \
    --build="$cfg_host_canonical" \
    --host="$cfg_host_canonical" \
    --prefix="$cfg_dir_rootfs" \
    HTOP_NCURSESW_CONFIG_SCRIPT="$cfg_dir_toolchain_sysroot/usr/bin/ncursesw6-config" \
    HTOP_NCURSES_CONFIG_SCRIPT="$cfg_dir_toolchain_sysroot/usr/bin/ncurses6-config" \
    CC="$cmd_target_cc" \
    CXX="$cmd_target_cxx"
}

target_install()
{
    cd "../htop-$version"
    $cmd_make install
}

