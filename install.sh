#!/usr/bin/env bash 
##
################################################################################
# pdfjam-extras - basic manual install script
#
# Copyright (c) 2022 Toby Breckon
################################################################################
##
PREFIX=/usr/local
echo -n "installing into $PREFIX ...."
install -m 755  bin/* $PREFIX/bin/
install -m 755 man1/* $PREFIX/man/man1/
echo " Done"
##
################################################################################
