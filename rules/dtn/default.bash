version=\
(
    '2.9.0'
)

url=\
(
    "http://downloads.sourceforge.net/dtn/dtn-$version.tgz"
)

md5=\
(
    'adfc25b561c1eeda30d9b68a6b088bd8'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

requires=\
(
    'db/default'
    'tcl/default'
    'xerces-c/default'
    'oasys/default'
)

configure()
{
    "../dtn-$version/configure" \
        --prefix="/usr" \
        --sysconfdir="/etc/dtn" \
        --target="$cfg_target_canonical" \
        --host="$cfg_target_canonical" \
        --build="$cfg_host_canonical" \
        --with-oasys="$cfg_dir_toolchain_sysroot/usr" \
        --enable-ecl \
        --without-python \
        --disable-python
}

build()
{
    $cmd_make -j1 -C servlib &&
    $cmd_make -j1 -C applib libdtnapi.a &&
    $cmd_make -j1 -C applib libdtnapi++.a &&
    $cmd_make -j1 -C applib libdtnapisrv.a &&
    $cmd_make -j1 -C daemon &&
    $cmd_make -j1 -C apps
}

host_install()
{
    cp -a servlib/libdtnserv.a "$cfg_dir_toolchain_sysroot/usr/lib" &&
    cp -a applib/libdtnapi++.a "$cfg_dir_toolchain_sysroot/usr/lib" &&
    cp -a applib/libdtnapi++-$version.a "$cfg_dir_toolchain_sysroot/usr/lib" &&
    cp -a applib/libdtnapi-$version.a "$cfg_dir_toolchain_sysroot/usr/lib" &&
    cp -a applib/libdtnapi.a "$cfg_dir_toolchain_sysroot/usr/lib" &&
    cp -a applib/libdtnapisrv.a "$cfg_dir_toolchain_sysroot/usr/lib" &&

    mkdir -p "$cfg_dir_toolchain_sysroot/usr/include/dtn" &&
    cp -a applib/dtn_ipc.h "$cfg_dir_toolchain_sysroot/usr/include/dtn" &&
    cp -a applib/dtn_errno.h "$cfg_dir_toolchain_sysroot/usr/include/dtn" &&
    cp -a applib/sdnv-c.h "$cfg_dir_toolchain_sysroot/usr/include/dtn" &&
    cp -a applib/dtn_api.h "$cfg_dir_toolchain_sysroot/usr/include/dtn" &&
    cp -a applib/dtn_types.h "$cfg_dir_toolchain_sysroot/usr/include/dtn"
}

target_install()
{
    $cmd_target_strip apps/dtnsend/dtnsend -o "$cfg_dir_rootfs/usr/bin/dtnsend" &&
    $cmd_target_strip apps/dtnrecv/dtnrecv -o "$cfg_dir_rootfs/usr/bin/dtnrecv" &&
    $cmd_target_strip apps/dtncp/dtncp -o "$cfg_dir_rootfs/usr/bin/dtncp" &&
    $cmd_target_strip apps/dtnping/dtnping -o "$cfg_dir_rootfs/usr/bin/dtnping" &&
    $cmd_target_strip daemon/dtnd -o "$cfg_dir_rootfs/usr/bin/dtnd" &&
    $cmd_mkdir "$cfg_dir_rootfs/etc/dtn" "$cfg_dir_rootfs/usr/share/dtn" &&
    cp servlib/conv_layers/clevent.xsd "$cfg_dir_rootfs/usr/share/dtn" &&
    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
}
