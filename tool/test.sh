#!/bin/bash

# Fast fail the script on failures.
set -e

DART_VERSION=$(dart --version 2>&1)
DART_2_PREFIX="Dart VM version: 2"


if [[ $DART_VERSION = $DART_2_PREFIX* ]]; then
    echo -e 'pub run build_runner test -- -p vm -p chrome'
    pub run build_runner test -- -p vm -p chrome
else
    echo -e 'pub run test -p vm -p chrome'
    pub run test -p vm -p chrome
fi
