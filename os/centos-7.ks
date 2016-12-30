# Based on CentOS's instructions for creating a Docker image.
# https://github.com/CentOS/sig-cloud-instance-build/tree/c8e7802e29fc836f900541b58d4d5bc5880abc01/docker

# Basic setup information.
url --url="http://mirrors.kernel.org/centos/7/os/x86_64/"
install
keyboard us
rootpw --lock --iscrypted locked
timezone --isUtc --nontp UTC
selinux --enforcing
firewall --disabled
network --bootproto=dhcp --device=link --activate --onboot=on
reboot
bootloader --disable
lang en_US

# Repositories to use
repo --name="CentOS" --baseurl=http://mirror.centos.org/centos/7/os/x86_64/ --cost=100
repo --name="Updates" --baseurl=http://mirror.centos.org/centos/7/updates/x86_64/ --cost=100

# Disk setup.
zerombr
clearpart --all
part / --size 3000 --fstype ext4

# Install base packages.
# Leading dash excludes installation.
# Trailing star is a wildcard.
%packages --excludedocs --instLangs=en --nocore
-*firmware
-bind-license
-freetype
-gettext*
-kernel*
-libteam
-os-prober
-teamd
bash
bind-utils
bzip2
ca-certificates
centos-release
coreutils
cronie
curl
diffutils
expat
findutils
gnupg2
iproute
iputils
less
libcurl
libevent
libgcc
libicu
ncurses-libs
net-tools
openssh-clients
openssl-libs
passwd
pcre
procps-ng
readline
rootfiles
systemd
tar
tzdata
unzip
vim-minimal
wget
which
yum
yum-plugin-ovl
yum-utils
zlib
%end

# Post configure tasks.
%post --log=/anaconda-post.log
# Remove stuff we don't need that Anaconda insists on.
# Kernel needs to be removed by rpm, because of grubby.
rpm -e kernel

yum -y remove bind-libs bind-libs-lite dhclient dhcp-common dhcp-libs \
  dracut-network e2fsprogs e2fsprogs-libs ebtables ethtool \
  firewalld freetype gettext gettext-libs grub2 grub2-tools \
  grubby initscripts iproute kexec-tools libcroco libgomp \
  libmnl libnetfilter_conntrack libnfnetlink libselinux-python lzo \
  libunistring os-prober python-decorator python-slip python-slip-dbus \
  snappy sysvinit-tools linux-firmware

yum clean all

# Clean up unused directories.
rm -rf /boot
rm -rf /etc/firewalld

# Randomize root's password.
dd if=/dev/urandom count=50 | md5sum | passwd --stdin root

awk '(NF==0&&!done){print "override_install_langs='$LANG'\ntsflags=nodocs";done=1}{print}' \
    < /etc/yum.conf > /etc/yum.conf.new
mv /etc/yum.conf.new /etc/yum.conf
echo 'container' > /etc/yum/vars/infra

# Setup locale properly.
rm -f /usr/lib/locale/locale-archive
localedef -v -c -i en_US -f UTF-8 en_US.UTF-8

rm -rf /var/cache/yum/*
rm -f /tmp/ks-script*
rm -rf /var/log/*
rm -rf /tmp/*
rm -rf /etc/sysconfig/network-scripts/ifcfg-*
rm -f /root/*

# Fix /run/lock breakage since it's not tmpfs in Docker.
umount /run
systemd-tmpfiles --create --boot

# Make sure login works.
rm /var/run/nologin

/bin/date +%Y%m%d_%H%M > /etc/BUILDTIME

"" > /etc/machine-id
%end
