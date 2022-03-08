version=\
(
    '5.2.1'
)

revision=\
(
    '1'
)

url=\
(
    "http://www.lua.org/ftp/lua-$version.tar.gz"
)

md5=\
(
    'ae08f641b45d737d12d30291a5e5f6e3'
)

requires=\
(
  "readline/default"
  "ncurses/default"
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

build()
{
    $cmd_make \
        CC="$cmd_target_cc" \
        linux
}

host_install()
{
    $cmd_make \
        CC="$cmd_target_cc" \
        INSTALL_TOP="$cfg_dir_toolchain_sysroot/usr" \
        install
}
