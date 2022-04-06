version=\
(
    'master'
)

requires=\
(
    'cmake/host'
)

download()
{
    git clone "git@github.com:LSTS/dune.git" dune &&
        cd dune && git checkout "$version" && cd - &&
        git clone "git@git.lsts.pt:dune-private.git" dune/private &&
        cd dune/private && git checkout "$version" && cd -
}

configure()
{
    $cmd_mkdir build &&
        cd build &&
        cmake \
            -DCMAKE_INSTALL_PREFIX="$cfg_dir_toolchain_sysroot/usr" \
            -DCROSS="$cmd_target_cc" \
            ../dune
}

build()
{
    $cmd_make -C build
}

host_install()
{
    $cmd_make -C build install
}
