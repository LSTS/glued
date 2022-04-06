version=\
(
    '3.0.4'
)
url=\
(
    "http://ftp.gnu.org/pub/gnu/gperf/gperf-$version.tar.gz"
)

md5=\
(
    'c1f1db32fb6598d6a93e6e88796a8632'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

configure()
{
    "../gperf-$version/configure" \
        --prefix="$cfg_dir_toolchain"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}
