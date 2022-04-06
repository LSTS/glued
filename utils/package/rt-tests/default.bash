version=\
(
    '0.96'
)

url=\
(
    "https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-$version.tar.gz"
)

md5=\
(
    '590b2340f66993a978d9806a734d5ea8'
)

maintainer=\
(
    'Kristian Klausen <kristian.klausen@itk.ntnu.no>'
)

build()
{
    $cmd_make \
	CC=$cmd_target_cc cyclictest \
	CFLAGS="$cfg_target_gcc_flags" 
}

target_install()
{
    cp -a cyclictest "$cfg_dir_rootfs/usr/bin/" &&
    $cmd_target_strip "$cfg_dir_rootfs/usr/bin/cyclictest"
}
