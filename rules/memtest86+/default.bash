version=\
(
    "5.01"
)

url=\
(
    "http://www.lsts.pt/glued/memtest86+-$version.tar.gz"
)

md5=\
(
    "035b85f2edabc9b4a6b0cf6c9c3acf50"
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
