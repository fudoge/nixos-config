{
  config,
  pkgs,
  lib,
  withGui ? false,
  ...
}:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo =
        if withGui then
          {
            type = "kitty";
            source = "nixos";
          }
        else
          {
            type = "small";
          };
    };
  };
}
