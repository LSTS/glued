version=\
(
    "1.0.26"
)

url=\
(
  "http://alsa.cybermirror.org/utils/alsa-utils-${version}.tar.bz2"
)

md5=\
(
   "4dcf1017fafc91603af96705c073eca9"
)

requires=\
(
    'ncurses/default'
    'alsa-lib/default'
)

configure()
{
  CC="$cmd_target_cc" ./configure \
   --prefix="/usr" \
   --build="${cfg_host_canonical}" \
   --host="${cfg_target_canonical}" \
   --disable-alsatest \
   --disable-alsamixer \
   --disable-xmlto
}

build()
{
  $cmd_make
}

host_install()
{
  $cmd_make DESTDIR="$cfg_dir_toolchain_sysroot" install
}

target_install()
{
  cp -avr "${cfg_dir_toolchain_sysroot}/usr/share/alsa/init" "${cfg_dir_rootfs}/usr/share/alsa"

  mkdir -p "${cfg_dir_rootfs}/lib/udev/"
  cp -avr "${cfg_dir_toolchain_sysroot}/lib/udev/rules.d" "${cfg_dir_rootfs}/lib/udev/rules.d"

  cp -av "${cfg_dir_toolchain_sysroot}/usr/sbin/alsactl"     "${cfg_dir_rootfs}/usr/sbin/"
  cp -av "${cfg_dir_toolchain_sysroot}/usr/bin/alsaloop"     "${cfg_dir_rootfs}/usr/bin/"
  cp -av "${cfg_dir_toolchain_sysroot}/usr/bin/amidi"        "${cfg_dir_rootfs}/usr/bin/"
  cp -av "${cfg_dir_toolchain_sysroot}/usr/bin/amixer"       "${cfg_dir_rootfs}/usr/bin/"
  cp -av "${cfg_dir_toolchain_sysroot}/usr/bin/aplay"        "${cfg_dir_rootfs}/usr/bin/"
  cp -av "${cfg_dir_toolchain_sysroot}/usr/bin/speaker-test" "${cfg_dir_rootfs}/usr/bin/"
  cp -av "${cfg_dir_toolchain_sysroot}/usr/bin/alsaconf"     "${cfg_dir_rootfs}/usr/bin/"
  cp -av "${cfg_dir_toolchain_sysroot}/usr/bin/alsaucm"      "${cfg_dir_rootfs}/usr/bin/"
  cp -av "${cfg_dir_toolchain_sysroot}/usr/bin/aconnect"     "${cfg_dir_rootfs}/usr/bin/"
  cp -av "${cfg_dir_toolchain_sysroot}/usr/bin/aplaymidi"    "${cfg_dir_rootfs}/usr/bin/"
  cp -av "${cfg_dir_toolchain_sysroot}/usr/bin/aseqdump"     "${cfg_dir_rootfs}/usr/bin/"
  cp -av "${cfg_dir_toolchain_sysroot}/usr/bin/aseqnet"      "${cfg_dir_rootfs}/usr/bin/"
}

