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

refresh()
{
    for rule in target_install; do
        if [ -f "$cfg_dir_rootfs/etc/lsts-ftp-logs.conf"  ]; then
            grep -l "$cfg_lsts_ftp_logs_path$" "$cfg_dir_rootfs/etc/lsts-ftp-logs.conf"
            retVal=$?
            if [ $retVal -ne 0 ]; then
                rm -f "$cfg_dir_builds/$pkg/$pkg_var/.$rule"
            fi
        fi
    done
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
    [[ -z "$cfg_lsts_ftp_logs_path" ]] && err 'Missing "$cfg_lsts_ftp_logs_path" var set!' && return 1

    rm -Rf .tmpftp && mkdir -p .tmpftp/etc && [[ ! -z "$cfg_lsts_ftp_logs_path" ]] \
        && echo "30021 stream  tcp     nowait  root    /usr/sbin/ftpd /usr/sbin/ftpd -a root -w $cfg_lsts_ftp_logs_path" > .tmpftp/etc/lsts-ftp-logs.conf

    $cmd_make CROSS_COMPILE="$cfg_target_canonical"- CONFIG_PREFIX=$cfg_dir_rootfs install &&
    tar -C "$pkg_dir/fs" --exclude .svn -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f - &&
    tar -C ".tmpftp" -c -f - . | tar -C "$cfg_dir_rootfs" -x -v -f -
    
    rm -Rf .tmpftp
}
