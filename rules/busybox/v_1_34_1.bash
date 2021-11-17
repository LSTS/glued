version=\
(
    '1.34.1'
)

url=\
(
    "https://busybox.net/downloads/busybox-$version.tar.bz2"
)

md5=\
(
    '5ad7368a73d12b8c4f8881bf7afb3d82'
)

post_unpack()
{
    patches=$(ls "$pkg_dir"/patches/*.patch)

    if [ -n "$patches" ]; then
        cat $patches | patch -p1
    fi
}

configure()
{
    cp "$pkg_dir"/config-1.34.1 .config &&
    yes '' | $cmd_make CROSS_COMPILE="$cfg_target_canonical"- oldconfig
}

build()
{
    $cmd_make CROSS_COMPILE="$cfg_target_canonical"-
}

target_install()
{
    rm -Rf .tmpftp && mkdir -p .tmpftp/etc && [[ ! -z "$cfg_lsts_ftp_logs_path" ]] \
        && echo "30021 stream  tcp     nowait  root    /usr/sbin/ftpd /usr/sbin/ftpd -a root -w $cfg_lsts_ftp_logs_path" > .tmpftp/etc/lsts-ftp-logs.conf || echo 'Missing "$cfg_lsts_ftp_logs_path" var set!' && exit 1

    $cmd_make CROSS_COMPILE="$cfg_target_canonical"- CONFIG_PREFIX=$cfg_dir_rootfs install &&
    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f - &&
    tar -C ".tmpftp" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
    
    rm -Rf .tmpftp
}
