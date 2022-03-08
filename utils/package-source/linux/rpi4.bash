. "$cfg_dir_rules/$pkg/default.bash"

version=\
(
    '4.19_2020-07-16'
)

url=\
(
    "http://lsts.pt/glued/rpi-linux-$version.zip"
)

md5=\
(
    '264ed341a303a95b2a8a9dbefb988551'
)

requires=\
(
    'lz4/host'
)

build_dir="rpi-linux-rpi-linux-$version"

find_patches
