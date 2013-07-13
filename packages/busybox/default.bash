version=\
(
    "1.20.2"
)

url=\
(
    "http://busybox.net/downloads/busybox-$version.tar.bz2"
)

md5=\
(
    "e025414bc6cd79579cc7a32a45d3ae1c"
)

post_unpack()
{
    patches=$(ls "$cfg_package_spec_dir"/patches/*.patch)

    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    cp "$cfg_package_spec_dir"/config .config &&
    yes '' | $cmd_make CROSS_COMPILE="$cfg_target_canonical"- oldconfig
}

build()
{
    $cmd_make CROSS_COMPILE="$cfg_target_canonical"-
}

target_install()
{
    $cmd_make CROSS_COMPILE="$cfg_target_canonical"- CONFIG_PREFIX=$cfg_dir_rootfs install &&
    tar -C "$cfg_package_spec_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
