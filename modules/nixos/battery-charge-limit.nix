{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  systemd.services.battery-charge-limit = {
    description = "Battery charge limit";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/bash /home/${username}/.local/bin/setlimit.sh";
    };
  };
}
