version=\
(
    '1.4.2'
)

url=\
(
    "https://github.com/zerotier/ZeroTierOne/archive/$version.tar.gz"
)

md5=\
(
    'c173f8b61bcdb23844a2669ff0d7bdf0'
)

build()
{
    cd ../ZeroTierOne-$version && $cmd_make \
                VERBOSE=1 \
                CC="$cmd_target_cc" \
                CXX="$cmd_target_cxx" \
		        LD="$cmd_target_ld" \
                STRIP="$cmd_target_strip" \
                CC_FLAGS="$cfg_target_gcc_flags"

}

target_install()
{
    $cmd_cp "../ZeroTierOne-$version/zerotier-one" "$cfg_dir_rootfs/usr/bin/zerotier-one"
    ln -sf "$cfg_dir_rootfs/usr/bin/zerotier-one" "$cfg_dir_rootfs/usr/bin/zerotier-cli"
    ln -sf "$cfg_dir_rootfs/usr/bin/zerotier-one" "$cfg_dir_rootfs/usr/bin/zerotier-idtool"
}

