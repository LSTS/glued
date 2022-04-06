. "$cfg_dir_rules/$pkg/default.bash"

version=\
(
    '4.9.y'
)

url=\
(
    "http://lsts.pt/glued/rpi-linux-$version.zip"
)

md5=\
(
    '4dab2f5b0d0daf940d94d6fe41da223c'
)

requires=\
(
    'lz4/host'
)

build_dir="rpi-linux-rpi-linux-$version"

find_patches
