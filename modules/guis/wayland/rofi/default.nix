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

    terminal = "ghostty";
    show-icons = true;

    default = "drun";

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
