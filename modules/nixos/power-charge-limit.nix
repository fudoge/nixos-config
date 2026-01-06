{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  systemd.services.battery-charge-limit = {
    description = "ThinkPad battery charge limit";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/home/${username}/.local/bin/setlimit.sh";
    };
  };
}
