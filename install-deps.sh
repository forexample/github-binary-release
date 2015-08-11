#!/bin/bash -e

set -x

if [ "`uname`" == "Darwin" ];
then
  brew install python3
fi
