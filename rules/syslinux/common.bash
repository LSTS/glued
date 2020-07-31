version=\
(
    '6.04'
)

url=\
(
    "https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/Testing/$version/syslinux-$version-pre1.tar.gz"
)

md5=\
(
    'fefbc39becb619339fc22c91ec7112ab'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'nasm/host'
    'python_host/host'
    'uuid/default'
)

post_unpack()
{
  cd ..
  $cmd_cp syslinux-$version-pre1/* syslinux-$version/
}
