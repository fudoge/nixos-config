{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BATO = 75;
      STOP_CHARGE_THRESH_BATO = 80;
    };
  };
}
