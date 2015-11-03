version=\
(
    '3.1.0'
)

git_tag="$(echo $version | sed 's/\./-/g')"

url=\
(
    "https://github.com/groeck/i2c-tools/archive/V$git_tag.tar.gz"
)

md5=\
(
    '7ed75853fe3c3dfd2d0d70d5831abfef'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    $cmd_make -C "../i2c-tools-$git_tag" CC="$cmd_target_cc"
}

target_install()
{
    for t in i2cdetect i2cget i2cset; do
        $cmd_target_strip "../i2c-tools-$git_tag/tools/$t" -o "$cfg_dir_rootfs/usr/bin/$t"
    done
}
