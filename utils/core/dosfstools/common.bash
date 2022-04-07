version=\
(
    '3.0.28'
)

url=\
(
    "https://github.com/dosfstools/dosfstools/releases/download/v$version/dosfstools-$version.tar.xz"
)

md5=\
(
    '6a047a6c65186b9ebb1853709adb36db'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    $cmd_make distclean
}
