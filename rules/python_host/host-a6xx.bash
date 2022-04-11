version=\
(
  "v2.7.2"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

url=\
(
    "https://www.lsts.pt/glued/cloud/package/lctr-a6xx/gcc-5.4/python-$version-host.tar.gz"
)

md5=\
(
    'bb08a569dd90702a9659d9d8ba353638'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
