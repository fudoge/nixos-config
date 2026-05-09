{
  config,
  pkgs,
  lib,
  ...
}: let
  # Fonts copied into ~/.local/share/fonts/onlyoffice-nixos
  # These are for ONLYOFFICE compatibility.
  onlyofficeFonts = with pkgs; [
    # General
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji

    # Korean fonts
    nanum
    nanum-gothic-coding
    pretendard

    # Office compatibility
    corefonts
    liberation_ttf

    # Dev
    nerd-fonts.jetbrains-mono
  ];

  # Fonts registered system-wide.
  # Keep this smaller to avoid breaking browser font fallback.
  systemFonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    nanum
    nanum-gothic-coding
    pretendard

    liberation_ttf

    nerd-fonts.jetbrains-mono
  ];

  syncOnlyOfficeFonts = pkgs.writeShellApplication {
    name = "sync-onlyoffice-fonts";

    runtimeInputs = with pkgs; [
      coreutils
      findutils
      fontconfig
    ];

    text = ''
      set -euo pipefail

      target_dir="$HOME/.local/share/fonts/onlyoffice-nixos"

      echo "Syncing fonts for ONLYOFFICE..."
      mkdir -p "$target_dir"

      # Remove old copied font files
      find "$target_dir" -type f \( \
        -iname "*.ttf" -o \
        -iname "*.otf" -o \
        -iname "*.ttc" -o \
        -iname "*.otc" \
      \) -delete

      font_paths=(
        ${lib.concatMapStringsSep "\n        " (pkg: "\"${pkg}\"") onlyofficeFonts}
      )

      for font_path in "''${font_paths[@]}"; do
        if [ -d "$font_path/share/fonts" ]; then
          while IFS= read -r -d "" font_file; do
            rel_name="$(basename "$font_path")-$(basename "$font_file")"
            cp "$font_file" "$target_dir/$rel_name"
            chmod 644 "$target_dir/$rel_name"
          done < <(
            find "$font_path/share/fonts" -type f \( \
              -iname "*.ttf" -o \
              -iname "*.otf" -o \
              -iname "*.ttc" -o \
              -iname "*.otc" \
            \) -print0
          )
        fi
      done

      fc-cache -f "$HOME/.local/share/fonts"

      echo "Done. Fonts copied to: $target_dir"
    '';
  };
in {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "corefonts"
    ];

  environment.systemPackages = [
    syncOnlyOfficeFonts
  ];

  fonts.packages = systemFonts;

  fonts.fontconfig.defaultFonts = {
    sansSerif = [
      "Pretendard"
      "Noto Sans CJK KR"
      "Noto Sans"
    ];

    serif = [
      "Noto Serif CJK KR"
      "Noto Serif"
    ];

    monospace = [
      "JetBrainsMono Nerd Font"
      "NanumGothicCoding"
    ];

    emoji = [
      "Noto Color Emoji"
    ];
  };
}
