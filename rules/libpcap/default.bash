version=\
(
    "1.1.1"
)

url=\
(
    "http://www.tcpdump.org/release/libpcap-$version.tar.gz"
)

md5=\
(
    "1bca27d206970badae248cfa471bbb47"
)

maintainer=\
(
    "Ricardo Martins <rasm@fe.up.pt>"
)

requires=\
(
    'flex/host'
    'bison/host'
)

post_unpack()
{
    for patch in "$cfg_package_spec_dir"/patches/*; do
        patch -p1 < "$patch" || return 1
    done
}

configure()
{
    echo 'ac_cv_linux_vers=${ac_cv_linux_vers=2}' > config.cache
    ../libpcap-$version/configure \
        --config-cache \
        --prefix="$cfg_dir_toolchain_sysroot/usr" \
        --target=$cfg_target_canonical \
        --host=$cfg_target_canonical \
        --build=$cfg_host_canonical \
	--enable-shared \
	--enable-static \
	--disable-yydebug \
	--enable-ipv6 \
	--with-pcap=linux \
	--without-septel \
	--without-dag
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}

target_install()
{
    for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libpcap.so*; do
        if [ -L "$f" ]; then
            cp -av "$f" "$cfg_dir_rootfs/lib"
        else
            $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/lib/$(basename "$f")"
        fi
    done
}
