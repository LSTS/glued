version=\
(
    "3.0.2"
)

url=\
(
    "https://github.com/zeromq/czmq/archive/v$version.tar.gz"
)

md5=\
(
    "23e9885f7ee3ce88d99d0425f52e9be1"
)

configure()
{
    ./autogen.sh && \
    ./configure \
        --prefix="${cfg_dir_toolchain_sysroot}/usr" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical"
}

build()
{
    $cmd_make
}

host_install()
{
    $cmd_make install
}

requires=\
(
    'libtool/host'
    'zeromq'
)

target_install()
{
  # Libs:
  for f in "$cfg_dir_toolchain_sysroot/usr/lib/"libczmq.*; do
    if [ -L "$f" ]; then
      $cmd_cp "$f" "$cfg_dir_rootfs/usr/lib"
    else
      $cmd_target_strip -v "$f" -o "$cfg_dir_rootfs/usr/lib/$(basename "$f")"
    fi
  done
}
