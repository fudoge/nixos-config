#!/usr/bin/env bash

TARGET_HOST=${1:-$(hostname)}
BIN_DIR="$HOME/.local/bin"

echo "🐣 Bootstrapping..."
if [ -d /etc/nixos ]; then
    echo "/etc/nixos already exists."
    while true; do
        read -rp "choose action: [o]verwrite, [b]ackup, [s]skip(Do not use this option in first use). (lowercase only) " ans
        case "$ans" in
        o | overwrite)
            sudo rm -rf /etc/nixos
            sudo ln -s $PWD /etc/nixos
            break
            ;;
        b | backup)
            TIME="$(date +"%T")"
            sudo mv /etc/nixos /etc/nixos.bak-${TIME}
            sudo ln -s $PWD /etc/nixos
            break
            ;;
        s | skip)
            sudo rm -rf /etc/nixos
            sudo ln -s $PWD /etc/nixos
            break
            ;;
        *)
            echo "invalid input"
            ;;
        esac
    done
fi

echo "📃 Setting up scripts..."
mkdir -p $BIN_DIR
cp -r ./scripts/* ~/.local/bin/
chmod +x $BIN_DIR/*

echo "🖼️ Setting default wallpaper..."
mkdir -p "$HOME/Pictures/wallpapers"
if [[ ! -f "$HOME/Pictures/wallpapers/nix-black-4k.png" ]]; then
    cp "assets/wallpapers/nix-black-4k.png" "$HOME/Pictures/wallpapers/nix-black-4k.png"
fi

echo "🪝 Adding Untracked files..."
git add . 2>/dev/null || true

echo "❄️ Rebuilding with flake: $TARGET_HOST"
if sudo nixos-rebuild switch --flake "/etc/nixos#$TARGET_HOST"; then
    echo "Bootstrapping Success! 😊"
else
    echo "Bootstrapping Failed.. 😿"
fi
