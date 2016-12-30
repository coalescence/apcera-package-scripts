# How to create the CentOS cntmp

This was written with Vagrant 1.8.5 and Virtualbox 5.1.4.

## Create a CentOS tarball

Everything has been scripted in `Vagrantfile`. Just run these commands.
Depending on your computer, you may want to adjust `v.memory` and `v.cpus`.

```
cd package-scripts/os
vagrant up --provider virtualbox
```

This will take about 1 hour to run. At the end of this, you should have a
`centos-7.tar.gz` in your current directory.

## Create cntmp

```
apc package from file centos-7.tar.gz "centos-7" --provides="os.centos-7, os.centos, os.linux"
apc package export centos-7
```
