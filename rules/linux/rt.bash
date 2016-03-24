. "$cfg_dir_rules/$pkg/default.bash"

version=\
(
    '3.14.64-rt67'
)

url=\
(
    "https://www.kernel.org/pub/linux/kernel/v3.x/linux-$(linux_mmp_version).tar.xz"
    "https://www.kernel.org/pub/linux/kernel/projects/rt/$(linux_mm_version)/patch-$version.patch.gz"
)

md5=\
(
    'd68173a31fb60e2195a4015fe1f83e97'
    '03be9388659d844c362e507ddba2d777'
)

maintainer=\
(
    'Ricardo Martins <rasm@oceanscan-mst.com>'
)

patches=("$cfg_dir_downloads/patch-$version.patch.gz" "${patches[@]}")

build_dir="linux-$(linux_mmp_version)"
