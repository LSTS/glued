source $PKG_COMMON

build()
{
    export CFLAGS="${CFLAGS} -fPIC"
# Static library.
    $cmd_make \
        bzip2 &&

# Shared library.
    $cmd_make \
        -f Makefile-libbz2_so &&
	ln -fs libbz2.so.$version libbz2.so.1
}

host_install()
{
    $cmd_mkdir "${cfg_dir_toolchain}/include"
    $cmd_mkdir "${cfg_dir_toolchain}/lib"
    $cmd_cp libbz2.a "${cfg_dir_toolchain}/lib" 
    $cmd_cp libbz2.so* "${cfg_dir_toolchain}/lib"
    $cmd_cp bzlib.h "${cfg_dir_toolchain}/include"
}
