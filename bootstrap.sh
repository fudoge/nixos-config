#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

usage() {
  cat <<'EOF'
Usage: ./bootstrap.sh [thinkpad|wsl|macbook]

Rebuild the selected host from this repository. On macOS, the host defaults to
macbook; on Linux, it defaults to the current hostname.
EOF
}

if [[ ${1:-} == -h || ${1:-} == --help ]]; then
  usage
  exit 0
fi

if (( $# > 1 )); then
  usage >&2
  exit 2
fi

case $(uname -s) in
  Darwin)
    host=${1:-macbook}
    if [[ $host != macbook ]]; then
      printf 'Host %s is not a macOS configuration.\n' "$host" >&2
      exit 2
    fi
    ;;
  Linux)
    host=${1:-$(hostname)}
    if [[ $host != thinkpad && $host != wsl ]]; then
      printf 'Unknown Linux host: %s (choose thinkpad or wsl).\n' "$host" >&2
      exit 2
    fi
    ;;
  *)
    printf 'Unsupported operating system.\n' >&2
    exit 2
    ;;
esac

flake_ref="$repo_dir#$host"

if [[ $(uname -s) == Darwin ]]; then
  # The default sudo soft limit can be 256, which is too low for Nix evaluation.
  if [[ -x /run/current-system/sw/bin/darwin-rebuild ]]; then
    sudo -H /bin/zsh -lc \
      'ulimit -Sn 16384 && exec /run/current-system/sw/bin/darwin-rebuild switch --flake "$1"' \
      _ "$flake_ref"
  else
    # First activation, before darwin-rebuild is installed in the system profile.
    sudo -H /bin/zsh -lc \
      'ulimit -Sn 16384 && exec nix run nix-darwin/nix-darwin-26.05#darwin-rebuild -- switch --flake "$1"' \
      _ "$flake_ref"
  fi
  exit
fi

# Keep the one-time Linux helpers, but never overwrite existing user files.
bin_dir="$HOME/.local/bin"
mkdir -p -- "$bin_dir" "$HOME/Pictures/Wallpapers"
for script in "$repo_dir"/scripts/*; do
  target="$bin_dir/${script##*/}"
  if [[ -e $target || -L $target ]]; then
    if ! cmp -s -- "$script" "$target"; then
      printf 'Keeping existing %s (differs from repository copy).\n' "$target" >&2
    fi
  else
    install -m 0755 -- "$script" "$target"
  fi
done

wallpaper="$HOME/Pictures/Wallpapers/nix-black-4k.png"
if [[ ! -e $wallpaper && ! -L $wallpaper ]]; then
  cp -- "$repo_dir/assets/wallpapers/nix-black-4k.png" "$wallpaper"
fi

# Caelestia can replace Home Manager's cava config. Keep the previous backup
# before Home Manager tries to back up the replacement to the same path.
cava_config="$HOME/.config/cava/config"
cava_backup="$cava_config.backup"
if [[ -e $cava_config && ! -L $cava_config && ( -e $cava_backup || -L $cava_backup ) ]]; then
  cava_archive="$cava_backup.old-$(date +%Y%m%d%H%M%S)"
  suffix=1
  while [[ -e $cava_archive || -L $cava_archive ]]; do
    cava_archive="$cava_backup.old-$(date +%Y%m%d%H%M%S)-$suffix"
    (( suffix += 1 ))
  done
  mv -- "$cava_backup" "$cava_archive"
  printf 'Preserved existing cava backup as %s.\n' "$cava_archive"
fi

sudo nixos-rebuild switch --flake "$flake_ref"
printf 'To update OnlyOffice fonts, run sync-onlyoffice-fonts.\n'
