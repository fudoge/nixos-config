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
      "drun"
      "emoji"
      "ssh"
    ];
    plugins = with pkgs; [
      rofi-calc
    ];
  };
}
