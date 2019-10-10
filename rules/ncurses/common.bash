version=\
(
    "6.1"
)

url=\
(
    "http://ftp.gnu.org/pub/gnu/ncurses/ncurses-${version}.tar.gz"
)

md5=\
(
    "98c889aaf8d23910d2b92d65be2e737a"
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
