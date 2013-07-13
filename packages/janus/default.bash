version=\
(
    'c-3.0.1'
)


md5=\
(
#    '43c7c9363ca7bf93a7bfaffb9b61de6b'
    ''
)

unpack()
{
    cd  ${pkg_build_dir}/..
    unzip ${cfg_dir_downloads}/${PKG}-${version}.zip
}

requires=\
(
    'cmake/host'
    'fftw'
)

configure()
{
    mkdir -p ../build &&
    cd ../build
    cmake \
        -DCROSS="$cmd_target_cc" \
	-DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_FIND_ROOT_PATH="${cfg_dir_toolchain_sysroot}/usr" \
        -DCMAKE_INSTALL_PREFIX="$cfg_dir_toolchain_sysroot/usr" \
	-DCMAKE_C_FLAGS="${cfg_target_gcc_flags}" \
        "../janus-$version"
}

build()
{
    cd  ${pkg_build_dir}/../build &&
    $cmd_make
}

host_install()
{
    cd  ${pkg_build_dir}/../build &&
    $cmd_make install
}

target_install()
{
    cp -a ../janus-$version/etc/parameter_sets.csv "$cfg_dir_rootfs/etc/janus-psets.csv" &&
    cd  ${pkg_build_dir}/../build &&
    $cmd_target_strip janus-tx -o "$cfg_dir_rootfs/usr/bin/janus-tx" &&
    $cmd_target_strip janus-rx -o "$cfg_dir_rootfs/usr/bin/janus-rx" &&
    for plugin in libplugin_???_??.so; do
	$cmd_target_strip ${plugin} -o "$cfg_dir_rootfs/usr/lib/${plugin}";
    done &&
     _test_scripts
}

_test_scripts()
{
echo "#!/bin/sh
# output settings
amixer set -D hw:0 'Headset' 0dB
amixer set -D hw:0 'Headset' 6dB-
amixer set -D hw:0 'HeadsetL Mixer AudioL2' on
amixer set -D hw:0 'HeadsetR Mixer AudioR2' on

# input settings
amixer -c 0 cset numid=29 100%
amixer -c 0 cset numid=26 100%


COMMON_PARAMETERS=\"--verbose 1 --pset-file /etc/janus-psets.csv --pset-id 1\"
# Alsa or wave
STREAM_DRIVER=\"alsa\"
STREAM_DRIVER_ARGUMENTS=\"default\"
STREAM_SAMPLING_FREQUENCY=\"48000\"
STREAM_PARAMETERS=\" --stream-driver \${STREAM_DRIVER} --stream-driver-args \${STREAM_DRIVER_ARGUMENTS} --stream-fs \${STREAM_SAMPLING_FREQUENCY} \"
PAYLOAD=\"HelloU\"
#PAYLOAD=\"The_quick_brown_fox_jumps_over_the_lazy_dog\"

#
PARAMETERS_TX=\"\${COMMON_PARAMETERS} \${STREAM_PARAMETERS} --packet-payload  \${PAYLOAD}\"
echo \"A) janus-tx \${PARAMETERS_TX}\"
janus-tx \${PARAMETERS_TX}

PARAMETERS_RX=\"\${COMMON_PARAMETERS} \${STREAM_PARAMETERS}\"
echo \"B) janus-rx \${PARAMETERS_RX}\"
janus-rx \${PARAMETERS_RX}
" > "$cfg_dir_rootfs/usr/bin/janus_atest.sh"


echo "#!/bin/sh

COMMON_PARAMETERS=\"--verbose 1 --pset-file /etc/janus-psets.csv --pset-id 1\"
# Alsa or wave
STREAM_DRIVER=\"wav\"
STREAM_DRIVER_ARGUMENTS=\"janux.wav\"
STREAM_SAMPLING_FREQUENCY=\"48000\"
STREAM_PARAMETERS=\" --stream-driver \${STREAM_DRIVER} --stream-driver-args \${STREAM_DRIVER_ARGUMENTS} --stream-fs \${STREAM_SAMPLING_FREQUENCY} --stream-channel 1 \"
PAYLOAD=\"HelloU\"
#PAYLOAD=\"The_quick_brown_fox_jumps_over_the_lazy_dog\"

#
PARAMETERS_TX=\"\${COMMON_PARAMETERS} \${STREAM_PARAMETERS} --packet-payload  \${PAYLOAD}\"
echo \"A) janus-tx \${PARAMETERS_TX}\"
janus-tx \${PARAMETERS_TX}

echo \"S) File is\"
ls -al \${STREAM_DRIVER_ARGUMENTS}

PARAMETERS_RX=\"\${COMMON_PARAMETERS} \${STREAM_PARAMETERS}\"
echo \"B) janus-rx \${PARAMETERS_RX}\"
janus-rx \${PARAMETERS_RX}
" > "$cfg_dir_rootfs/usr/bin/janus_wtest.sh"

}

