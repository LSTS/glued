version=\
(
    '3.0.28'
)

url=\
(
    "https://github.com/dosfstools/dosfstools/releases/download/v$version/dosfstools-$version.tar.gz"
)

md5=\
(
    '64e3b3a59b51d2a97d7ac38b23a124bb'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    CC="$cmd_host_cc" \
        $cmd_make \
        PREFIX="$cfg_dir_toolchain"
}

host_install()
{
    CC="$cmd_host_cc" \
        $cmd_make \
        PREFIX="$cfg_dir_toolchain" install
}
