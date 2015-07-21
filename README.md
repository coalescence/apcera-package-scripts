# Continuum Package Scripts

These are the package config scripts we use to build the runtimes available in
Continuum.

**NOTE: this repository is deprecated in favor of [continuum-package-scripts](https://github.com/apcera/continuum-package-scripts), which is open source.

Using these definitions can be done through the use of APC:

```console
$ apc package build runtimes/go-1.3.conf
```

This will use the package definition to generate a build script, upload that to
Continuum, and have it generate the package and store the results as the
package's data.

### Operating Systems

Under the `os` directory are the package configurations for various
distributions and versions.

* Busybox (using Buildroot 2013.08.1)
* Ubuntu 12.04
* Ubuntu 13.10
* Ubuntu 14.04

### Packages

Under the `packages` directory are the package configurations for various common
packages that can be pulled into Continuum. Some of them are dependencies of
runtimes within the platform, or become dependencies while staging an
application (ie, might need git to checkout a repository).

* apache-2.2.27
* apache-ant-1.9.4
* apache-tomcat-7.0.55
* bzr-2.6.0
* git-2.0.3
* maven-3.2.2
* memcached-1.4.20
* mercurial-3.0.2
* nginx-1.6.0
* redis-2.8.13
* subversion-1.8.9
* zsh-5.0.5

You can learn how to create packages [here](./doc/packages_creation.md)

### Runtimes

Under the `runtimes` directory are the pacakge configurations for various
runtimes that can be pulled into Continuum.

* clisp-2.49
* erlang-R16B02
* erlang-R16B03
* erlang-otp1701
* go-1.2
* go-1.3
* node-0.10.29
* node-0.6.21
* node-0.8.27
* ocaml-4.01.0
* openjdk-1.6
* openjdk-1.7
* perl-5.14.4
* perl-5.16.3
* perl-5.18.2
* perl-5.20.0
* php-5.4.31
* php-apache-5.5.15
* php-fpm-nginx-5.5.15
* python-2.7.8
* python-3.3.5
* python-3.4.1
* ruby-1.8.7-p373
* ruby-1.9.3-p547
* ruby-2.0.0-p481
* ruby-2.1.2

### Patches

Under the `patches` directory are various patches carried locally.
