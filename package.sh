#!/bin/bash
##
################################################################################
# generic packager script - package software as .rpm or .deb Linux package
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
DEPENDS="texlive-extra-utils"
URL=https://github.com/tobybreckon/pdfjam-extras/
DESCRIPTION="a set of additional utility scripts for pdfjam"
##
################################################################################
##
# files as source destination pairs (inc. wildcards), each pair on new line

FILES=( "bin/* /usr/bin"
        "man1/* /usr/man/man1"
      )
##
################################################################################
# Preset this script to fail on error
set -e
################################################################################

case $1 in

  rpm)

    # package as rpm, and sign using default key for current user following
    # convention for rpm based Linux distributions

    (test -e $PWD/$PACKAGE_NAME.spec) ||
      (echo "Error: $PACKAGE_NAME.spec file missing" && exit 1)

    BASE_DIR=$PWD

    rpmdev-setuptree
    ln -sf $PWD/$PACKAGE_NAME.spec ~/rpmbuild/SPECS/
    cd ~/rpmbuild/
    rpmbuild -bb SPECS/$PACKAGE_NAME.spec
    sudo rpmsign --addsign RPMS/noarch/$PACKAGE_NAME-$VERSION-$((RELEASE-1)).$ARCHITECTURE_RPM.rpm
    rpm --checksig RPMS/noarch/$PACKAGE_NAME-$VERSION-$((RELEASE-1)).$ARCHITECTURE_RPM.rpm
    cp ~/rpmbuild/RPMS/noarch/$PACKAGE_NAME-$VERSION-$((RELEASE-1)).$ARCHITECTURE_RPM.rpm $BASE_DIR
    ;;

  deb)

    # package as deb, but don't sign package following default for
    # .deb based based Linux distributions

    TARGET_DIR=${PACKAGE_NAME}_$VERSION-${RELEASE}_$ARCHITECTURE_DEB

    for PAIR in "${FILES[@]}"; do
      # ref: https://victorwyee.com/engineering/loop-over-tuples-in-bash/
      read -a strarr <<< "$PAIR"
      FILE=${strarr[0]}
      DIRECTORY=${strarr[1]}
      mkdir -p $TARGET_DIR/$DIRECTORY
      cp $FILE $TARGET_DIR/$DIRECTORY
    done

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

  clean)

    # remove built packages

    rm -f ${PACKAGE_NAME}_$VERSION-${RELEASE}_$ARCHITECTURE_DEB.deb
    rm -f $PACKAGE_NAME-$VERSION-$((RELEASE-1)).$ARCHITECTURE_RPM.rpm

    ;;
    
  *)
    echo
    echo "usage: package.sh [rpm | deb | clean]"
    echo
    echo "$PACKAGE_NAME packager script - Toby Breckon, 2022+ ]"
    echo
    exit 1
    ;;
esac

##
################################################################################
