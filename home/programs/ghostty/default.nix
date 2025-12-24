{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Ghostty
  programs.ghostty = {
    enable = true;
    settings = {
      custom-shader = "shaders/cursor_fronzen.glsl";
      font-size = 11;
      font-thicken = "true";
      font-thicken-strength = "10";
      theme = "catppuccin-frappe";
      cursor-style = "block";
      background-opacity = "0.9";

      window-padding-x = "2, 2";
      window-padding-y = "2, 2";
    };
  };
}
