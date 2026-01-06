{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.tlp.settings = {
    START_CHARGE_THRESH_BATO = 75;
    STOP_CHARGE_THRESH_BATO = 75;
  };
}
