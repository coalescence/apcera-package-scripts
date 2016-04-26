#!/bin/bash

# parallel array with the name and directory of packages
#array=( "node-4.4.2" "node-5.10.0" "perl-5.22.1" "php-5.5.33" "php-5.6.19" "ruby-2.2.4" "ruby-2.3.0" "python-2.7.11" "python-3.5.1" "go-1.5.3" "go-1.6"   "erlang-otp-18.3" "apache-2.4.18" "subversion-1.9.3" "git-2.8.0" "postgres-9.4.7" "rsync-3.1.2" "redis-2.8.24" "apache-tomcat-8.0.33" )
#folder=("runtimes"   "runtimes"   "runtimes"     "runtimes"   "runtimes"   "runtimes"   "runtimes"   "runtimes"      "runtimes"     "runtimes" "runtimes" "runtimes"        "packages"      "packages"         "packages"  "packages"       "packages"    "packages"     "packages"  )

# update this portion to do package build for selective packages
array=( $1 )   # node-4.4.2
folder=( $2 )  # runtimes or packages

for ((i=0;i<${#array[@]};++i)); do
    printf "Building %s in %s folder.\n" "${array[i]}" "${folder[i]}"
    apc package delete package::/apcera/pkg/${folder[i]}::${array[i]} --batch
    apc package build ${folder[i]}/${array[i]}.conf --batch
    apc package export /apcera/pkg/${folder[i]}::${array[i]}
done




