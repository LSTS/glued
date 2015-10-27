version=\
(
    "2.4.2"
)

git=\
(
    #"git://github.com/tomojitakasu/RTKLIB#master"
    "git://github.com/krisklau/RTKLIB#fix/iss99"
)

git_hash=\
(
    c07cc29932b453544a46cd5efae4f815a93c2b35
)

maintainer=\
(
    'Kristian Klausen <kristian.klausen@itk.ntnu.no>'
)


post_unpack()
{    
    echo "Checking out correct version"
    cd "${cfg_dir_builds}/$pkg/RTKLIB-git"
    git reset --hard ${git_hash}
}

build_dir="RTKLIB-git"

build()
{
    cd app/str2str/gcc
    $cmd_make \
	CC=$cmd_target_cc \
	CTARGET="$cfg_target_gcc_flags" \
	BINDIR="${cfg_dir_toolchain_sysroot}/usr/bin" 
	
    cd ../../rtkrcv/gcc
    $cmd_make \
	CC=$cmd_target_cc \
	CTARGET="$cfg_target_gcc_flags" \
	BINDIR="${cfg_dir_toolchain_sysroot}/usr/bin" 
}

host_install()
{
    cd app/str2str/gcc
    $cmd_make \
	CC=$cmd_target_cc \
	CTARGET="$cfg_target_gcc_flags " \
	BINDIR="${cfg_dir_toolchain_sysroot}/usr/bin" \
	install
	
	cd ../../rtkrcv/gcc
    $cmd_make \
	CC=$cmd_target_cc \
	CTARGET="$cfg_target_gcc_flags " \
	BINDIR="${cfg_dir_toolchain_sysroot}/usr/bin" \
	install
}

target_install()
{
    cp -a "${cfg_dir_toolchain_sysroot}/usr/bin/str2str" "${cfg_dir_rootfs}/usr/bin/" &&
    $cmd_target_strip "${cfg_dir_rootfs}/usr/bin/str2str" 
    
    cp -a "${cfg_dir_toolchain_sysroot}/usr/bin/rtkrcv" "${cfg_dir_rootfs}/usr/bin/" &&
    $cmd_target_strip "${cfg_dir_rootfs}/usr/bin/rtkrcv" 
    
    # Copy configurations and run-time commands
    $cmd_mkdir "${cfg_dir_rootfs}/opt/lsts/rtklib/conf" &&
    cp -a $cfg_dir_builds/rtklib/$build_dir/data ${cfg_dir_rootfs}/opt/lsts/rtklib 
}

