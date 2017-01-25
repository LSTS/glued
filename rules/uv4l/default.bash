version=\
(
  "1.0.0"
)

url=\
(
  "http://lsts.pt/glued/uv4l.$version.tar.bz2"
)

md5=\
(
  "869e884accbfa9c2356e2fd9307dd71c"
)

maintainer=\
(
    'Pedro Gonçalves <pedro@lsts.pt>'
)

post_unpack()
{
    mv "../etc" "../uv4l-$version/"
    mv "../usr" "../uv4l-$version/"
    touch startStreamRaspiCam.sh
    echo "#!/bin/sh" >> startStreamRaspiCam.sh
    echo "pkill uv4l" >> startStreamRaspiCam.sh
    echo "modprobe cuse" >> startStreamRaspiCam.sh
    echo "uv4l -nopreview --auto-video_nr --driver raspicam --encoding h264 --width 1080 --height 720 --framerate 20 --quality 10 --server-option '--port=9090' --server-option '--max-queued-connections=30' --server-option '--max-streams=25' --server-option '--max-threads=29'" >> startStreamRaspiCam.sh
}

host_install()
{
  $cmd_cp -r "usr/lib/"*    "$cfg_dir_toolchain_sysroot/usr/lib/"
  $cmd_cp -r "usr/include/"* "$cfg_dir_toolchain_sysroot/usr/include/"
}

target_install()
{
    $cmd_cp -r "usr/lib/"* "$cfg_dir_rootfs/usr/lib/"
    $cmd_cp -r "usr/bin/"* "$cfg_dir_rootfs/usr/bin/"
    $cmd_cp -r "startStreamRaspiCam.sh" "$cfg_dir_rootfs/usr/bin/"
}


