#!/bin/bash

[ -n "$DEBUG" ] && set -o xtrace
set -o nounset
set -o errexit
shopt -s nullglob
shopt -s globstar

base_dir=`pwd`

# install some required dependencies
sudo apt-get install -y build-essential bc libncurses-dev unzip

# download and extract buildroot
wget http://apcera-sources.s3.amazonaws.com/os/buildroot-2013.08.1.tar.gz
tar xzvf buildroot-2013.08.1.tar.gz
cd buildroot-2013.08.1

# copy in the configuration
cp $(dirname $0)/buildroot.config .config

# build it
make
cp output/images/rootfs.tar $base_dir/
gzip $base_dir/rootfs.tar
make clean

# add the #99 runner user to the sudoers
tmpspace=`mktemp -d`
chmod 755 $tmpspace
sudo chown root:root $tmpspace
cd $tmpspace
sudo tar xzf $base_dir/rootfs.tar.gz
sudo bash -c 'echo "#99 ALL=(ALL:ALL) NOPASSWD: ALL" >> etc/sudoers'
sudo tar czf $base_dir/rootfs.tar.gz .
cd $base_dir
sudo rm -rf $tmpspace
