version=\
(
    '5.10.0'
)

url=\
(
    "http://www.cpan.org/src/5.0/perl-$version.tar.gz"
)

md5=\
(
    'd2c39b002ebfd2c3c5dba589365c5a71'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

post_unpack()
{
    chmod -v 644 Makefile.SH &&
    chmod -v 644 utils/Makefile.SH

    patches=$(ls "$pkg_dir"/patches-${version}/*.patch)
    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi

    sed 's/libs = $perllibs $cryptlib/libs = $perllibs $cryptlib -lm/g' Makefile.SH -i &&
    $cmd_make_single -v Makefile.SH{,.orig} &&
    sed -e "s@pldlflags=''@pldlflags=\"\$cccdlflags\"@g" \
        -e "s@static_target='static'@static_target='static_pic'@g" Makefile.SH.orig > Makefile.SH
}

build()
{
    export CC="$cfg_target_canonical-gcc"
    export CXX="$cfg_target_canonical-g++"
    export AR="$cfg_target_canonical-ar"
    export AS="$cfg_target_canonical-as"
    export RANLIB="$cfg_target_canonical-ranlib"
    export LD="$cfg_target_canonical-ld"
    export STRIP="$cfg_target_canonical-strip"
    export HOSTCC="$cmd_host_cc"


    cd Cross &&
    $cmd_make ARCH=$cfg_target_linux CROSS_COMPILE="$cfg_target_canonical-"
}

target_install()
{
    $cmd_target_strip libperl.so &&
    $cmd_make DESTDIR="$cfg_dir_rootfs" install &&
    sed "s%/usr/lib/perl5/%$cfg_dir_rootfs/usr/lib/perl5/%g" \
        "$cfg_dir_rootfs/usr/lib/perl5/5.10.0/"*-linux-thread-multi/Config.pm -i
}
