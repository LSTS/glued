version=\
(
    "5.31b"
)

url=\
(
    "http://memtest.org/download/5.31b/memtest86+-$version.tar.gz"
)

md5=\
(
    "948c4fc5afd117b996eaa1ebd8e0e0f5"
)

maintainer=\
(
    'Tiago Sá Marques <tsmarques@fe.up.pt>'
)

build()
{
    $cmd_make \
        CC=$cmd_target_cc \
        CXX=$cmd_target_cxx
}

target_install()
{
    $cmd_cp ./memtest.bin $cfg_dir_rootfs/boot/
    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
