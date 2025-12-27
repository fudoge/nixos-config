{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    overwrite.enable = true;
    theme = "catppuccin_frappe";
    settings = {
      theme.font = {
        name = "JetBrains Mono NF";
        size = "14px";
      };
    };
  };
}
