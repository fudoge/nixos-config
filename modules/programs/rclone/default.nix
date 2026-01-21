{
  config,
  pkgs,
  lib,
  ...
}: {
  systemd.user.services.gdrive-mount = {
    Unit = {
      Description = "Google Drive mount";
      After = ["network-online.target"];
    };
    Service = {
      Type = "notify";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/gdrive";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount gdrive: %h/gdrive \
          --vfs-cache-mode writes \
          --config %h/.config/rclone/rclone.conf
      '';
      ExecStop = "/run/wrappers/bin/fusermount -u %h/gdrive";
    };
    Install.WantedBy = ["default.target"];
  };
}
