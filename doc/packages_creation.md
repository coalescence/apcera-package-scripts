## Creating new packages for HCOS clusters
___
**Requirements**: 
* working HCOS cluster (to be able to test package) [setup docs](https://github.com/apcera/orchestrator/wiki/Local-Release-Building-and-Deployment)
___

   All packages configs are in **apcera/package-scripts** repository.
1. Find a source code of the app you want to make package of and download it. 
Find it’s install documentation for **Ubuntu-14 and above**.
2. Generate sha256 key for the file 
    * (like for ex. -> ```$shasum -a s256 path_to_file/file_name```)
3. Upload dowloaded file to trusted server _(amazons3.apcera.com)_    
4. Create a config file `<package_name>.conf` in folder named **packages** in **pacera/package-scripts** repository. Looking at the example `mysql-5.6.25.conf` further in this document, customize your config file for the package you want to create.
5. Test it in your test cluster and see if it succeeds 
    * to build use -> ```$apc package build path_to_conf_file/mysql-5.6.25.conf```
6. Find **manifest.json** in **continuum/testing/system/tmp/packages/manifest.json** and add your package names you specified in “provides” section in your_package.conf to relevant section in the `manifest.json` in following way: 
    * For ex. in `mysql-5.6.25.conf` case:
```json
# manifest.json
    "package”:{
    ….
    mysql:mysql-5.6.25.sntmp
    mysql-5.6:mysql-5.6.25.sntmp
    mysql-5.6.25:mysql-5.6.25.sntmp
    ….
    …. 
  }
```
7. Add sha256 key along with package.conf file name to ?????????????????????
8. Upload manifest with file in step 7 to _(amazons3.apcera.com)_
  
##### EXAMPLE _(mysql-5.6.25.conf)_ 

```json
# mysql-5.6.25.conf 
The structure of the conf file is following:
# name of the package you are creating
name:      “mysql”
version:   “5.6.25”
namespace: "/apcera/pkg/packages” # default namespace for packages is "/apcera/pkg/packages”

 # Resources section is the location of the file to be downloaded and its sha256 key for the verification for the security purposes. 
sources [
  { url: "https://s3.amazonaws.com/apcera-sources/mysql/mysql-5.6.25.tar.gz",
    sha256: "15079c0b83d33a092649cbdf402c9225bcd3f33e87388407be5cdbf1432c7fbd" },
]

build_depends [ { package: "build-essential" } ] # ???
depends       [ { os: "ubuntu" } ] # ???

# Provides section just sets the names package will respond to. For ex. $apc capsule create test-cap -p mysql-5.6 (<- here could be mysq or mysql-5.6.25, any would refer to this package)
provides      [ { package: "mysql" },
                { package: "mysql-5.6" },
                { package: "mysql-5.6.25" } ]  
 )

# Here you set the env variables and paths to executables
environment { "PATH": "/opt/apcera/mysql-5.6.25/bin:$PATH” }

# Build steps, which will be executed to install and setup application for the package. As an example below is mysql installation and setup taken from internet and slightly adjusted to ones needs.
build (
  export INSTALLPATH=/opt/apcera/mysql-5.6.25

  # Untar mysql.
  tar xvzf mysql-5.6.25.tar.gz
  cd mysql-5.6.25

  # Build mysql.
  cmake -DCMAKE_INSTALL_PREFIX=${INSTALLPATH} -DENABLE_DOWNLOADS=1 -DCMAKE_C_FLAGS="-O3 -g -Wall -Wextra -Wformat-security -Wvla -Wwrite-strings -Wdeclaration-after-statement" -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-O3 -g -DDBUG_OFF" -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci .
  make
  make install

  # Add users and groups.
  groupadd mysql
  useradd -r -g mysql mysql

  # Make sure data path is owned by mysql
  chown -R mysql:mysql /var/lib/mysql

  # Setup initial db.
  cd ${INSTALLPATH}
  ./scripts/mysql_install_db --user=mysql --basedir . --ldata=/var/lib/mysql/ --force

  # Make sure socket file is at default location.
  ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock

  # Allow external connectivity.
  sed -i "s/bind-address\t\t= 127.0.0.1/bind-address = 0.0.0.0/1" /etc/mysql/my.cnf

  # Start mysql.
  ./bin/mysqld_safe &

  # Set default passwords for all users, local and network based.
  ./bin/mysqladmin -u root password 'your_db_password'
  ./bin/mysqladmin -u root -h 127.0.0.1 password 'root'
  ./bin/mysqladmin -u root -h `ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'` password 'your_db_password'
  ./bin/mysql -u root -proot -e "CREATE USER 'root'@'%' IDENTIFIED BY 'root';"

  # Stop mysql.
  pkill -9 mysqld
)
```