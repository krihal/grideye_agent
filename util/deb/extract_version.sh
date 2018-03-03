#!/bin/sh

# Relative path to the changelog
CHANGELOG="../../CHANGELOG.md"

# Extract the version number
VERSION=`cat /grideye_agent/CHANGELOG.md | grep -e '^##' | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/'`

# Modify the control file
sed -i "s/VER/$VERSION/" /grideye-agent/DEBIAN/control
