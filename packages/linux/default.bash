source "$pkg_common"

version=\
(
    '3.13.1'
)

url=\
(
    "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$version.tar.xz"
)

md5=\
(
    '18f528e5632f0096e642c511722630dc'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'kmod/host'
    'lz4/host'
)
