version=\
(
    '1.2.3'
)

revision=\
(
    '1'
)

url=\
(
    "http://nginx.org/download/nginx-$version.tar.gz"
)

md5=\
(
    '0a986e60826d9e3b453dbefc36bf8f6c'
)

maintainer=\
(
    'Ricardo Martins <rasm@fe.up.pt>'
)

description=\
(
    'An HTTP and reverse proxy server, as well as a mail proxy'
    'server.'
)

configure()
{
    "../nginx-$version/configure" \
        --prefix="/usr" \
        --with-cc="$cmd_target_cc" \
        --with-cpp="$cmd_target_cpp" \
        --conf-path='/etc' \
        --pid-path='/var/run/nginx.pid' \
        --lock-path='/var/lock/nginx.lock' \
        --http-log-path='/var/log/nginx.log' \
        --error-log-path='/var/log/nginx_error.log'
}

build()
{
    $cmd_make
}

target_install()
{
    return 1
}
