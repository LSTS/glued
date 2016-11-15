. "$cfg_dir_rules/$pkg/default.bash"

version=\
(
    '4.4_2016-05-17'
)

url=\
(
    "https://github.com/rasmartins/rpi-linux/archive/rpi-linux-$version.tar.gz"
)

md5=\
(
    '5bb5ce2b2a7f0943e4efe95badfffad9'
)

build_dir="rpi-linux-rpi-linux-$version"

find_patches
