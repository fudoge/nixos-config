{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.hyprpanel = {
    enable = true;

    theme.font = {
      name = "JetBrains Mono NF";
      size = "14px";
    };
  };
}
