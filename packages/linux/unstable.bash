source "$PKG_COMMON"

version=\
(
    '3.13-rc7'
)

url=\
(
    "https://www.kernel.org/pub/linux/kernel/v3.x/testing/linux-$version.tar.xz"
)

md5=\
(
    'a9de953c724974f8842328c4f41ec255'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'u-boot'
    'kmod/host'
)
