version=\
(
    '1.42.13'
)

url=\
(
    "http://downloads.sourceforge.net/e2fsprogs/e2fsprogs-$version.tar.gz"
)

md5=\
(
    'bc759fc62666786f5436e2075beb3265'
)

post_unpack()
{
    patches=$(ls "$pkg_dir"/patches/*.patch)

    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}
