# Apcera Platform Package Scripts

These are the package config scripts we use to build the runtimes available in the Apcera Platform.

Using these definitions can be done through the use of APC:

```console
$ apc package build runtimes/go-1.5.1.conf --name go-1.5.1
```

This will use the package definition to generate a build script, upload that to
the Apcera Platform, and have it generate the package and store the results as the
package's data.

## Documentation

Full documentation on the package build process can be found at http://docs.apcera.com/tutorials/create-package/

## How To Contribute

* Fork the `apcera/package-scripts` directory.
* Make your changes. This could be creating new conf files, or editing existing confs.
* Send us a pull request.

## Included Packages

### Operating Systems

Under the `os` directory are the package configurations for various
distributions and versions.

* Busybox (using Buildroot 2013.08.1)
* Ubuntu 12.04
* Ubuntu 13.10
* Ubuntu 14.04
* Ubuntu 14.04.3

### Packages

Under the `packages` directory are the package configurations for various common
packages that can be pulled into the Apcera Platform. Some of them are dependencies of
runtimes within the platform, or become dependencies while staging an
application (ie, might need git to checkout a repository).

* apache-2.2.29
* apache-ant-1.9.4
* apache-tomcat-7.0.62
* apache-tomcat-8.0.30
* apc-0.16.0
* bzr-2.6.0
* git-2.3.1
* imagemagick-6.8.9-6-apc1
* maven-3.2.2
* memcached-1.4.20
* mercurial-3.0.2
* mysql-5.6.25
* newrelic-java-3.20.0
* nginx-1.6.0
* ovftool-4.1.0
* postgres-9.4.4
* rabbitmq-3.5.5
* redis-2.8.13
* rsync-3.1.1
* subversion-1.8.9
* tokumx-2.0.1
* zsh-5.0.5

### Runtimes

Under the `runtimes` directory are the package configurations for various
runtimes that can be pulled into the Apcera Platform.

* clisp-2.49
* erlang-otp1701
* erlang-R16B02
* erlang-R16B03
* go-1.2
* go-1.3
* go-1.4
* go-1.5.1
* java-7
* java-8
* meteor-1.2.0.1
* node-0.6.21
* node-0.8.28
* node-0.10.40
* node-0.12.9
* node-4.2.1
* ocaml-4.01.0
* openjdk-1.6
* openjdk-1.7
* perl-5.14.4
* perl-5.16.3
* perl-5.18.2
* perl-5.20.0
* php-5.4.31-apc1
* php-apache-5.5.15-apc1
* php-fpm-nginx-5.5.15-apc1
* php-apache-5.6.16
* php-fpm-nginx-5.6.16
* python-2.7.9
* python-3.3.6
* python-3.4.3
* ruby-1.8.7-p374
* ruby-1.9.3-p547
* ruby-2.0.0-p643
* ruby-2.1.5-apc1
* ruby-2.2.3

### Patches

Under the `patches` directory are various patches carried locally.
