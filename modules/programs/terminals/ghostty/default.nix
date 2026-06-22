{
  config,
  pkgs,
  lib,
  ...
}: let
  settings = {
    font-size = 14;
    font-thicken = "true";
    font-thicken-strength = "10";
    theme = "Rose Pine";
    # theme = "Catppuccin Frappe";
    cursor-style = "block";
    background-opacity = "0.9";
    custom-shader = "${./shaders/cursor_frozen.glsl}";

    window-padding-x = "2, 2";
    window-padding-y = "2, 2";
  };

  toGhosttyConfig = lib.generators.toKeyValue {
    mkKeyValue = name: value: "${name} = ${toString value}";
  };
in {
  # Ghostty is not available from nixpkgs on Darwin. Manage only its config
  # there and install the app outside Nix, while Linux keeps the HM package.
  programs.ghostty = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    enable = true;
    inherit settings;
  };

  xdg.configFile = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    "ghostty/config" = {
      text = toGhosttyConfig settings;
    };
  };
}
