{
  config,
  pkgs,
  lib,
  ...
}: {
  # Ghostty
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 14;
      font-thicken = "true";
      font-thicken-strength = "10";
      theme = "Catppuccin Frappe";
      cursor-style = "block";
      background-opacity = "0.9";
      custom-shader = "${./shaders/cursor_frozen.glsl}";

      window-padding-x = "2, 2";
      window-padding-y = "2, 2";
    };
  };
}
