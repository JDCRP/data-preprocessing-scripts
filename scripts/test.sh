#!/bin/sh

cd ../tif
find . -iname '*.tif' -exec echo -n {} \; -exec echo ': Done' \;
