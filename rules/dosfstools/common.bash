version=\
(
    '3.0.20'
)

url=\
(
    "http://www.lsts.pt/glued/dosfstools-$version.tar.gz"
)

md5=\
(
    '4bb205c2908eeb097dc08103a8c1ef37'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    $cmd_make distclean
}
