version=\
(
    '3.0.20'
)

url=\
(
    "http://daniel-baumann.ch/files/software/dosfstools/dosfstools-$version.tar.gz"
)

md5=\
(
    '7f1c1afd4ae4622e07b24ec0ddfc4184'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

configure()
{
    $cmd_make distclean
}
