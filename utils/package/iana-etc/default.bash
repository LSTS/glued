version=\
(
    '2.30'
)

url=\
(
    "http://sethwklein.net/iana-etc-$version.tar.bz2"
)

md5=\
(
    '3ba3afb1d1b261383d247f46cb135ee8'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    $cmd_make STRIP=yes
}

target_install()
{
    $cmd_make DESTDIR="$cfg_dir_rootfs" install
}
