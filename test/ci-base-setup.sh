#!/bin/sh
# openrenoir is licensed under CC BY-SA 4.0.
# To view a copy of this license, visit
# https://creativecommons.org/licenses/by-sa/4.0/.

set -e -v
AUTOCONF="$*"
case "$OS" in
  *)
    apt-get update -y
    apt-get install -y coccinelle python3-dev python3-lz4 gcc ;;
esac
