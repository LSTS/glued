version=\
(
    "1.17"
)

url=\
(
    "http://ftp.de.debian.org/debian/pool/contrib/m/microcode.ctl/microcode.ctl_$version.orig.tar.gz"
)

md5=\
(
    "d27e3294938d9951b25308fd68732e62"
)

post_unpack()
{
    sed \
        's,/dev/cpu/microcode,/dev/microcode,g' \
        "../microcode.ctl-$version/microcode_ctl.c" -i &&

    sed \
        's,/etc/microcode.dat,/lib/firmware/intel-microcode.dat,g' \
        "../microcode.ctl-$version/microcode_ctl.c" -i
}

build()
{
    $cmd_make \
        CC="$cmd_target_cc" \
        -C "../microcode.ctl-$version"
}

target_install()
{
    $cmd_target_strip \
        "../microcode.ctl-$version/microcode_ctl" \
        -o "$cfg_dir_rootfs/sbin/microcode_ctl"
}
