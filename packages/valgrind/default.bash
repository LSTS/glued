version=\
(
    "3.8.1"
)

url=\
(
    "http://valgrind.org/downloads/valgrind-$version.tar.bz2"
)

md5=\
(
    "288758010b271119a0ffc0183f1d6e38"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

# post_unpack()
# {
#     patches=$(ls "$cfg_package_spec_dir"/patches/*.patch)
#     if [ -n "$patches" ]; then
#         cat $patches | patch -p1
#     fi

#     cd "../valgrind-$version" && autoreconf
# }

configure()
{
    "../valgrind-$version/configure" \
        --prefix="/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --enable-tls
}

build()
{
    $cmd_make
}

target_install()
{
    $cmd_make DESTDIR="$cfg_dir_rootfs" install
}
