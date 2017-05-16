version=\
(
	   "1.2"
)

url=\
(
    "http://lsts.pt/glued/lpg-$version.tar.gz"
)

md5=\
(
    "beb0f3b8be474868b074dca66ced5b48"
)

configure()
{
    ./configure "$cfg_target_canonical-gcc"
}

build()
{
    $cmd_make
}

target_install()
{
    $cmd_cp "lpg" "$cfg_dir_rootfs/usr/bin"
}
