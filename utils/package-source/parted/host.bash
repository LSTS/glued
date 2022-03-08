version=\
(
    '3.1'
)

url=\
(
    "http://ftp.gnu.org/gnu/parted/parted-$version.tar.xz"
)

md5=\
(
    '5d89d64d94bcfefa9ce8f59f4b81bdcb'
)

configure()
{
    CFLAGS="-I$cfg_dir_toolchain/include" \
	LDFLAGS="-L$cfg_dir_toolchain/lib" \
	./configure \
	--prefix="$cfg_dir_toolchain" \
        --without-readline            \
	--disable-device-mapper       \
	--disable-shared              \
	--enable-static               \
	--disable-nls
}

build()
{
  $cmd_make
}

host_install()
{
  $cmd_make install
}
