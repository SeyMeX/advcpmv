#!/bin/sh

set -e

ADVCPMV_VERSION=${1:-0.9}
CORE_UTILS_VERSION=${2:-9.3}

curl -LO http://ftp.gnu.org/gnu/coreutils/coreutils-$CORE_UTILS_VERSION.tar.xz
tar xvJf coreutils-$CORE_UTILS_VERSION.tar.xz
rm coreutils-$CORE_UTILS_VERSION.tar.xz
(
    cd coreutils-$CORE_UTILS_VERSION/
    curl -LO https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.9-9.4.patch
    patch -p1 -i advcpmv-0.9-9.4.patch
    ./configure FORCE_UNSAFE_CONFIGURE=1
    make
    cp ./src/cp ../advcp
    cp ./src/mv ../advmv
)
rm -rf coreutils-$CORE_UTILS_VERSION
