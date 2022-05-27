version=\
(
    '1.1'
)

url=\
(
    "http://www.lsts.pt/glued/gnu-config-$version.tar.bz2"
)

md5=\
(
    '32246c804f0bcfcc53626833b73f1e0e'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

host_install()
{
    dir="$cfg_dir_toolchain/share/gnu-config"
    $cmd_mkdir "$dir" &&
    cp -v "../gnu-config-$version/config.sub" "$dir" &&
    cp -v "../gnu-config-$version/config.guess" "$dir"
}
