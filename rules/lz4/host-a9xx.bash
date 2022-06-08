version=\
(
    'v112'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a9xx/gcc-5.4/lz4-$version-host.tar.gz"
)

md5=\
(
    '07e2688f99351bb7c3b4ce061a73adb2'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
