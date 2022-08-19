version=\
(
    'v3.82'
)

requires=\
(
    'nasm/host-atom'
    'python_host/host-atom'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/atom-syslinux-$version-host.tar.gz"
)

md5=\
(
    '7b7cb2afb9f0f3ba830c68903fa18a0a'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}


