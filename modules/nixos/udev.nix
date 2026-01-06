{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="BAT0", \
        RUN+="/bin/chmod g+w /sys/class/power_supply/BAT0/charge_control_*"
  '';
}
