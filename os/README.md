# Operating Systems

Under the `os` directory are the package configurations for various
distributions and versions.

## Notes

Many of the operating systems that are provided are broken up into two packages:
a base which provides the root filesystem, and a build-essential which provides
development headers for the libraries available in the base.

## Versions

* Ubuntu 14.04 (built using 13.10 instead of Buildroot)

## Buildroot / Busybox

The pre-generated image can be downloaded from:

* [rootfs.tar.gz](http://apcera-sources.s3.amazonaws.com/os/rootfs.tar.gz) (14mb, SHA256: b9a77bdb246efadb285baf713626a83db3b71c11bc472d145228c98ca698daf1)

It can be loaded into the cluster using APC:

```
apc package from file rootfs.tar.gz "Buildroot Linux" --provides="os=buildroot" --environment="PATH=\$PATH:/bin:/sbin:/usr/bin:/usr/sbin" --batch
```

## Common Libraries

These are some of the libraries that we expect to be installed in an OS.

Files:

* `/bin/sh`
* `/etc/resolv.conf`

Utilities:

* `bzip2`
* `ca-certificates`
* `curl`
* `less`
* `mawk`
* `openssh-client`
* `screen`
* `sudo`
* `wget`
* `zip / unzip`

Libraries:

* `libadns`
* `libbz2`
* `libcurl`
* `libevent`
* `libexpat`
* `libicu`
* `libmysqlclient`
* `libncurses5`
* `libpcre3`
* `libpq5`
* `libreadline6`
* `libtinfo`
* `libxml2`
* `libxslt1.1`
* `openssl`
* `sqlite3`
* `zlib`

## Devices

Devices that typically exist within the base image include the following:

* `console`
* `null`
* `ptmx`
* `ram0`
* `random`
* `tty`
* `tty0`
* `tty1`
* `tty5`
* `urandom`
* `zero`
* `fd` (symlinks to `/proc/self/fd`)
* `stdin` (symlinks to `fd/0`)
* `stdout` (symlinks to `fd/1`)
* `stderr` (symlinks to `fd/2`)

The devices can be generated with the following script:

```shell
cd /dev
mknod -m 600 console c 5 1
mknod -m 666 tty c 5 0
mknod -m 666 random c 1 8
mknod -m 666 urandom c 1 9
mknod -m 666 null c 1 3
mknod -m 666 zero c 1 5
mknod -m 666 tty0 c 4 0
mknod -m 666 tty1 c 4 0
mknod -m 666 tty5 c 4 0
mknod -m 600 ram0 b 1 0
mknod -m 666 ptmx c 5 2

mkdir -m 755 pts

chown root:tty  console tty*
chown root:disk ram0

ln -s /proc/self/fd
ln -s fd/0 stdin
ln -s fd/1 stdout
ln -s fd/2 stderr
```
