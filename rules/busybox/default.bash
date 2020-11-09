version=\
(
    '1.30.1'
)

url=\
(
    "http://busybox.net/downloads/busybox-$version.tar.bz2"
)

md5=\
(
    '4f72fc6abd736d5f4741fc4a2485547a'
)

post_unpack()
{
    patches=$(ls "$pkg_dir"/patches/*.patch)

    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    cp "$pkg_dir"/config .config &&
    yes '' | $cmd_make CROSS_COMPILE="$cfg_target_canonical"- oldconfig
}

build()
{
    $cmd_make CROSS_COMPILE="$cfg_target_canonical"-
}

target_install()
{
    $cmd_make CROSS_COMPILE="$cfg_target_canonical"- CONFIG_PREFIX=$cfg_dir_rootfs install &&
    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
