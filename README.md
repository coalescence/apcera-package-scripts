# Apcera Platform Package Scripts

These are the package config scripts we use to build the runtimes available in the Apcera Platform.

Using these definitions can be done through the use of APC:

```console
$ apc package build runtimes/go-1.5.3.conf
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
* Ubuntu 14.04.3

### Packages

Under the `packages` directory are the package configurations for various common
packages that can be pulled into the Apcera Platform. Some of them are dependencies of
runtimes within the platform, or become dependencies while staging an
application (ie, might need git to checkout a repository).

* apache-2.2.29
* apache-2.2.31
* apache-2.4.18
* apache-2.4.23
* apache-ant-1.9.4
* apache-tomcat-7.0.62
* apache-tomcat-8.0.30
* apache-tomcat-8.0.33
* apc-0.16.0
* bzr-2.6.0
* chown-chgrp-chmod-0.0.1
* git-2.3.1
* git-2.8.0
* gnatsd-0.7.2
* imagemagick-6.8.9-6-apc2
* iperf-2.0.5
* ltp-2016.05.10
* maven-3.2.2
* memcached-1.4.20
* mercurial-3.0.2
* mysql-5.6.25-apc2
* mysql-5.6.25-apc3
* mysql-5.6.25-apc4
* mysql-5.6.31
* mysql-client-5.6.31
* newrelic-java-3.20.0
* newrelic-java-3.28.0
* nginx-1.11.1
* nginx-1.11.3
* nutch-2.3.1
* ovftool-4.1.0
* postgres-9.4.4-apc1
* postgres-9.4.5
* postgres-9.4.7
* postgres-9.4.8
* postgres-9.5.3
* rabbitmq-3.5.5-apc2
* rabbitmq-3.5.5
* redis-2.8.13
* redis-2.8.24
* rsnapshot-1.4.2
* rsync-3.1.1
* rsync-3.1.2-apc1
* s3cmd-1.6.1
* spark-1.6.1
* spark-2.0.0
* subversion-1.8.9
* subversion-1.9.3
* tokumx-2.0.1
* zsh-5.0.5

### Runtimes

Under the `runtimes` directory are the package configurations for various
runtimes that can be pulled into the Apcera Platform.

* clisp-2.49
* erlang-R16B02
* erlang-R16B03
* erlang-otp-18.3
* erlang-otp1701
* go-1.5.1
* go-1.5.3
* go-1.5.4
* go-1.6.2
* go-1.6.3
* go-1.6
* java-7
* java-8
* meteor-1.2.0.1
* node-0.10.40
* node-0.12.9
* node-4.2.1
* node-4.4.2
* node-4.4.4
* node-4.4.5
* node-4.4.6
* node-5.10.0-apc1
* node-5.10.0
* node-5.10.1
* node-5.11.1
* node-5.12.0
* node-6.1.0
* node-6.2.1
* ocaml-4.01.0
* openjdk-1.6
* openjdk-1.7.0-u101-b00
* openjdk-1.7.0-u60-b30
* openjdk-1.8.0-u60-b23
* perl-5.14.4
* perl-5.16.3
* perl-5.18.2
* perl-5.20.0
* perl-5.22.1
* php-5.4.31-apc3
* php-5.5.33
* php-5.6.19
* php-5.6.24
* php-apache-5.5.15-apc6
* php-apache-5.6.16-apc1
* php-fpm-nginx-5.5.15-apc4
* php-fpm-nginx-5.6.16-apc1
* python-2.7.11
* python-2.7.9
* python-3.3.6
* python-3.4.3
* python-3.5.1
* ruby-1.8.7-p374
* ruby-1.9.3-p547
* ruby-2.0.0-p643
* ruby-2.1.5-apc1
* ruby-2.2.3
* ruby-2.2.4
* ruby-2.3.0

### Patches

Under the `patches` directory are various patches carried locally.
