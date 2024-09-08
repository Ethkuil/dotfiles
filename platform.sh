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
