version=\
(
    "20111110"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

target_install()
{
    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
