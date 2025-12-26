{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.hyprpanel = {
    enable = true;
    settings = {
      theme.font = {
        name = "JetBrains Mono NF";
        size = "14px";
      };
    };
  };
}
