{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.rofi = {
    enable = true;
    cycle = true;
    font = "JetBrainsMono Nerd Font";
    location = "center";
    modes = [
      "window"
      "drun"
      "ssh"
      "calc"
      "filebrowser"
      "recursivebrowser"
    ];
    plugins = with pkgs; [
      rofi-calc
      rofi-file-browser
    ];
  };
}
