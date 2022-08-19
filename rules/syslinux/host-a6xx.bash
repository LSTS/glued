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
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/a6xx-syslinux-$version-host.tar.gz"
)

md5=\
(
    'f53132ae6041b54b79108628b28ed4e8'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
