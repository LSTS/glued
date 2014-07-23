version=\
(
    "1.6.1"
)

url=\
(
    "http://www.tcpdump.org/release/libpcap-$version.tar.gz"
)

md5=\
(
    "5eb05edf6b6c6e63d536d1c9fbfb2f7c"
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
    if [ -d "$pkg_dir"/patches/${version} ];
    then
	for patch in "$pkg_dir"/patches/${version}/*; do
            patch -p1 < "$patch" || return 1
	done
    fi
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
    $cmd_make install &&
    mv -v \
        "$cfg_dir_toolchain_sysroot/usr/bin/pcap-config" \
        "$cfg_dir_toolchain/bin/$cfg_target_canonical-pcap-config"
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
