#!/bin/bash

# Fast fail the script on failures.
set -e
set -x

DART_VERSION=$(dart --version 2>&1)
DART_2_PREFIX="Dart VM version: 2"


if [[ $DART_VERSION = $DART_2_PREFIX* ]]; then
    pub run build_runner test --release -- -p chrome
else
    pub run test -p vm -p chrome
fi
