version=\
(
    'v3.82'
)

requires=\
(
    'nasm/host-a6xx'
    'python_host/host-a6xx'
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/syslinux-$version-host.tar.gz"
)

md5=\
(
    '30ea48f06b24e44844d14d1f961172d5'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
