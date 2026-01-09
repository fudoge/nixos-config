{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.rofi = {
    enable = true;

    font = "JetBrainsMono Nerd Font 14";
    location = "center";
    cycle = true;

    modes = [
      "drun"
      "window"
      "ssh"
      "calc"
      "filebrowser"
    ];

    plugins = with pkgs; [
      rofi-calc
      rofi-file-browser
    ];

    extraConfig = {
      drun-display-format = "{icon} {name}";
      window-format = "{w} · {c}";
      matching = "fuzzy";
      sort = true;
    };
  };
}
