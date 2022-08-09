#!/bin/sh
##
################################################################################
# generic packager script - package software as rpm and deb
#
# Copyright (c) 2022 Toby Breckon
################################################################################
##

PACKAGE_NAME=pdfjam-extras
VERSION=0.1
RELEASE=1
ARCHITECTURE_DEB=all
ARCHITECTURE_RPM=noarch
MAINTAINER="Toby Breckon, http://breckon.org/toby/"
DEPENDS="pdfjam"
URL=https://github.com/tobybreckon/pdfjam-extras/
DESCRIPTION="a set of additional utility scripts for pdfjam"

##
################################################################################
##

case $1 in

  rpm)

    # package as rpm

    BASE_DIR=$PWD

    rpmdev-setuptree
    ln -sf $PWD/$PACKAGE_NAME.spec ~/rpmbuild/SPECS/
    cd ~/rpmbuild/
    rpmbuild -bb SPECS/$PACKAGE_NAME.spec
    sudo rpmsign --addsign RPMS/noarch/$PACKAGE_NAME-$VERSION-0.$ARCHITECTURE_RPM.rpm
    rpm --checksig RPMS/noarch/$PACKAGE_NAME-$VERSION-0.$ARCHITECTURE_RPM.rpm
    cp ~/rpmbuild/RPMS/noarch/$PACKAGE_NAME-$VERSION-0.$ARCHITECTURE_RPM.rpm $BASE_DIR
    ;;

  deb)

    # package as deb

    TARGET_DIR=${PACKAGE_NAME}_$VERSION-${RELEASE}_$ARCHITECTURE_DEB
    mkdir -p $TARGET_DIR/usr/bin
    mkdir -p $TARGET_DIR/usr/man/man1

    cp bin/* $TARGET_DIR/usr/bin
    cp man1/* $TARGET_DIR/usr/man/man1

    mkdir -p $TARGET_DIR/DEBIAN

    echo "Package: ${PACKAGE_NAME}" > $TARGET_DIR/DEBIAN/control
    echo "Version: $VERSION" >> $TARGET_DIR/DEBIAN/control
    echo "Maintainer: $MAINTAINER" >> $TARGET_DIR/DEBIAN/control
    echo "Depends: $DEPENDS" >> $TARGET_DIR/DEBIAN/control
    echo "Architecture: $ARCHITECTURE_DEB" >> $TARGET_DIR/DEBIAN/control
    echo "Homepage: $URL" >> $TARGET_DIR/DEBIAN/control
    echo "Description: $DESCRIPTION" >> $TARGET_DIR/DEBIAN/control

    dpkg --build $TARGET_DIR
    
    rm -rf $TARGET_DIR

    dpkg-deb --info $TARGET_DIR.deb

    ;;

  *)
    echo
    echo "usage: package.sh [rpm | deb]"
    echo
    echo "$PACKAGE_NAME packager script - Toby Breckon, 2022+ ]"
    echo
    exit 1
    ;;
esac

##
################################################################################
