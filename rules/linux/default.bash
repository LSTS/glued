source "$pkg_common"

version=\
(
    '3.14.16'
)

url=\
(
    "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$version.tar.xz"
)

md5=\
(
    '469c879236ed694f60b81122e91ca02e'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'bc/host'
    'kmod/host'
    'lz4/host'
)
