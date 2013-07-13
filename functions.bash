nfo1()
{
    echo -e "[$(date +"%Y-%m-%d %H:%M:%S")] \033[0m\033[1;34m* $*\033[0m"
}

nfo2()
{
    echo -e "[$(date +"%Y-%m-%d %H:%M:%S")] \033[0m\033[0;35m** $*\033[0m"
}

ok()
{
    echo -e "[$(date +"%Y-%m-%d %H:%M:%S")] \033[0m\033[0;32m** $*\033[0m"
}

err()
{
    echo -e "[$(date +"%Y-%m-%d %H:%M:%S")] \033[0m\033[1;31mERROR: $*\033[0m"
}
