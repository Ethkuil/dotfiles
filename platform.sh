#!/bin/bash

os() {
  case $OSTYPE in
    cygwin | msys | win32) echo "Windows" ;;
    linux-gnu*) lsb_release --id --short ;;
    darwin*) echo "macOS" ;;
    freebsd*) echo "FreeBSD" ;;
    *) echo "Unknown" ;;
  esac
}

is_wsl() {
  if [ -e /etc/wsl.conf ]; then
    return 0
  else
    return 1
  fi
}
