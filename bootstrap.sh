#!/usr/bin/env bash

if [ $@ -ne 2]; then
    echo "Usage: bootstrap <your-hostname>"
fi

hostname=$1

echo "📃 Setting up scripts"
mkdir -p ~/.local/bin
cp scripts/* ~/.local/bin/

"❄️ Rebuilding with flake... "
sudo nixos-rebuild switch --flake .#${hostname}
