version=\
(
    "1.0.6"
)

url=\
(
    "https://sourceforge.net/projects/bzip2/files/bzip2-$version.tar.gz"
)

md5=\
(
    "00b516f4704d4a7cb50a1d97e6e8e15b"
)

post_unpack()
{
        sed -i 's/CFLAGS=/CFLAGS+=/;' Makefile Makefile-libbz2_so
}


maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)
