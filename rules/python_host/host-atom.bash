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
    "https://www.lsts.pt/glued/cloud/package/lctr-atom/gcc-5.4/atom-python-$version-host.tar.gz"
)

md5=\
(
    'ec6faeccb68df011dded3fadbee11c6d'
)

post_unpack()
{
    $cmd_cp ../toolchain/* $cfg_dir_toolchain
}
