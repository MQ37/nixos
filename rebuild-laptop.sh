#!/usr/bin/env sh
TARGET_HOSTNAME="nixos-laptop"
if [ "$HOSTNAME" != "$TARGET_HOSTNAME" ]; then
    read -p "You are running from $HOSTNAME while this script targets $TARGET_HOSTNAME, are you sure? (y): ? " -n 1 -r
    if [ "$REPLY" != "y" ]; then
        exit
    fi
    echo
fi
nixos-rebuild switch --flake path:.#nixos-laptop
