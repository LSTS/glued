. "$cfg_dir_rules/$pkg/default.bash"

version=\
(
    '3.18_2015-06-03'
)

url=\
(
    "https://github.com/rasmartins/rpi-linux/archive/rpi-linux-$version.tar.gz"
)

md5=\
(
    '0b0255e50ca358b619bb78653ac2db2e'
)

post_unpack()
{
    rmdir "../linux-$version" &&
        mv "../rpi-linux-rpi-linux-$version" "../linux-$version"
}
