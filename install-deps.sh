#!/bin/bash -e

set -x

if [ "`uname`" == "Darwin" ];
then
  brew install python3
fi

if [ "`uname`" == "Linux" ];
then
  wget --no-check-certificate https://cmake.org/files/v3.4/cmake-3.4.0-Linux-x86_64.tar.gz
  tar xf cmake-3.4.0-Linux-x86_64.tar.gz
fi
