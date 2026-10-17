{
  config,
  pkgs,
  lib,
  hostFeatures ? {},
  ...
}: let
  cfg = {theme = "lumin";} // hostFeatures;
  validThemes = ["lumin" "rose-pine"];
  theme =
    if lib.elem cfg.theme validThemes
    then cfg.theme
    else throw "Unsupported theme '${cfg.theme}'. Expected one of: ${lib.concatStringsSep ", " validThemes}";
  isLumin = theme == "lumin";

  settings = {
    font-size = 14;
    font-thicken = "true";
    font-thicken-strength = "10";
    theme =
      if isLumin
      then "lumin"
      else "Rose Pine";
    # theme = "Catppuccin Frappe";
    cursor-style = "block";
    background-opacity = "0.72";
    custom-shader = "${./shaders/cursor_frozen.glsl}";

    window-padding-x = "2, 2";
    window-padding-y = "2, 2";
  };

  toGhosttyConfig = lib.generators.toKeyValue {
    mkKeyValue = name: value: "${name} = ${toString value}";
  };
  darwinConfig = ''
    font-family = "MesloLGS NF"
    font-family = "JetBrainsMono Nerd Font Mono"
    font-family = "Pretendard"
    background-blur = 50
    custom-shader-animation = always
    keybind = cmd+s>r=reload_config
    keybind = cmd+s>x=close_surface
    keybind = cmd+s>n=new_window
    keybind = cmd+s>c=new_tab
    keybind = cmd+s>shift+l=next_tab
    keybind = cmd+s>shift+h=previous_tab
    keybind = cmd+s>comma=move_tab:-1
    keybind = cmd+s>period=move_tab:1
    keybind = cmd+s>1=goto_tab:1
    keybind = cmd+s>2=goto_tab:2
    keybind = cmd+s>3=goto_tab:3
    keybind = cmd+s>4=goto_tab:4
  '';
in {
  # Ghostty is not available from nixpkgs on Darwin. Manage only its config
  # there and install the app outside Nix, while Linux keeps the HM package.
  programs.ghostty = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    enable = true;
    inherit settings;
  };

  xdg.configFile =
    lib.optionalAttrs isLumin {
      "ghostty/themes/lumin" = {
        source = ./themes/lumin;
      };
    }
    // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
      "ghostty/config" = {
        text = toGhosttyConfig settings + "\n" + darwinConfig;
      };
    };
}
