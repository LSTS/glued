version=\
(
    "v21"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/kmod-$version-host.tar.gz"
)

md5=\
(
    'e19ba36c4cfde15a84da5b780ffb77ff'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
