version=\
(
    "6.2"
)

url=\
(
    "http://ftp.gnu.org/pub/gnu/ncurses/ncurses-${version}.tar.gz"
)

md5=\
(
    "e812da327b1c2214ac1aed440ea3ae8d"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

post_unpack()
{
    patches=$(ls "$pkg_dir"/patches/*.patch)

    cd "../$pkg-$version"
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}
