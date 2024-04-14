#!/usr/bin/env sh

TARGET_HOSTNAME="$(uname -n)"
TARGET_REBUILD=$1

if [ -z "$1" ]; then
    echo "Specify hostname as first arg"
    exit 1
fi

if [ "$HOSTNAME" != "$TARGET_HOSTNAME" ]; then
    read -p "You are running from $HOSTNAME while this script targets $TARGET_HOSTNAME, are you sure? (y): ? " -n 1 -r
    if [ "$REPLY" != "y" ]; then
        exit
    fi
    echo
fi
nixos-rebuild switch --flake "path:.#$TARGET_REBUILD"

