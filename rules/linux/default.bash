source "$pkg_common"

version=\
(
    '3.13.11'
)

url=\
(
    "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$version.tar.xz"
)

md5=\
(
    'd4e06af8b674ac74ba745d52e4382bd3'
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
