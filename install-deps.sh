#!/bin/bash -e

set -x

if [ "`uname`" == "Darwin" ];
then
  brew install python3
fi

if [ "`uname`" == "Linux" ];
then
  sudo apt-get -y update
  sudo apt-get -y install cmake
  sudo apt-get -y install python3
fi
