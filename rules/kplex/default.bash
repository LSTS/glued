version=\
(
    '1.4'
)

url=\
(
    "https://github.com/stripydog/kplex/archive/v$version.tar.gz"
)

md5=\
(
    'df198384d2d7dee4b802136f4f9e9d44'
)

build()
{
    cd ../kplex-$version && $cmd_make VERBOSE=1 CC="$cmd_target_cc"
}

target_install()
{
    $cmd_cp ../kplex-$version/kplex "$cfg_dir_rootfs/usr/bin/kplex"
}

