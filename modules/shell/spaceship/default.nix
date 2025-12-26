{
  config,
  pkgs,
  lib,
  ...
}:
{

  # starship prompt
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      time.disabled = false;
      time.format = "$time ($style) ";
      cpp.disabled = false;
    };
  };
}
