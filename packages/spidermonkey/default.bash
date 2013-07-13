version=\
(
    "1.8.5"
)

url=\
(
    "ftp://ftp.mozilla.org/pub/mozilla.org/js/js185-1.0.0.tar.gz"
)

md5=\
(
    "a4574365938222adca0a6bd33329cb32"
)

configure()
{
    echo "$PATH"

    cd "../js-$version/js/src" &&
    ./configure \
        --target="$cfg_target_canonical" \
        --host="$cfg_host_canonical" \
        --build="$cfg_host_canonical" \
        --enable-application=standalone \
        --disable-mailnews \
        --disable-ldap \
        --disable-gnomevfs \
        --disable-gnomeui \
        --disable-jsd \
        --disable-plugins \
        --disable-oji \
        --disable-view-source \
        --disable-accessibility \
        --disable-jsloader \
        --disable-composer \
        --disable-postscript \
        --disable-xtf \
        --disable-xpfe-components \
        --disable-xpinstall \
        --disable-xprint \
        --disable-xpcom-obsolete \
        --disable-mathml \
        --disable-installer \
        --disable-updater \
        --disable-activex \
        --disable-activex-scripting \
        --disable-xul \
        --disable-profilesharing \
        --disable-profilelocking \
        --disable-necko-disk-cache \
        --disable-cookies \
        --disable-v1-string-abi \
        --disable-shared \
        --enable-static
}

build()
{
    cd ../js-$version/js/src &&
    $cmd_make
}

host_install()
{
    cd ../js-$version/js/src &&
    $cmd_make \
        DESTDIR="$cfg_dir_toolchain_sysroot" \
        install

    cp -a *.h "${cfg_dir_toolchain_sysroot}/usr/include"
}

target_install()
{
    echo ""
}
