#! /bin/bash

backupsystem="glued"
backupfile=$(date -u "+%F.tar.gz")

if [ ! -d "$1" ]; then
  echo " "$1" does not exist... "
  echo " Usage ./mkbackup.bash \<target folder\>"
  exit 1
fi

if [ ! -e "$1/${backupsystem}_backup" ]; then
  echo " Creating folder... : $1/${backupsystem}_backup "
  mkdir -p "$1/${backupsystem}_backup"
fi

echo " Backup in progress... ($1/${backupsystem}_backup/${backupfile}) "


if [ ! -e "scripts" ]; then
  echo " Creating folder scripts... "
  mkdir "scripts"
fi
cp *.bash scripts

tar czf "$1/${backupsystem}_backup/${backupfile}" \
  architectures \
  scripts \
  product \
  rules \
  systems

echo "Done ... "
