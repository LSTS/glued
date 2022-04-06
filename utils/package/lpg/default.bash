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
    "d71e2f282372a5cb1021d9e457a3d53f"
)

requires=\
(
    'bison/host'
    'flex/host'
)

configure()
{
    ./configure "$cfg_target_canonical-gcc"
}

build()
{
    $cmd_make \
	BISON="$cfg_dir_toolchain/bin/bison" \
	FLEX="$cfg_dir_toolchain/bin/flex"
    
}

target_install()
{
    $cmd_cp "lpg" "$cfg_dir_rootfs/usr/bin"
}
