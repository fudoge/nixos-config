{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  powerManagement.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  systemd.services.networkmanager-resume-recovery = {
    description = "Recover NetworkManager if networking stays down after suspend";
    wantedBy = ["suspend.target"];
    after = ["systemd-suspend.service"];
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.coreutils}/bin/sleep 15

      if [ "$(${pkgs.networkmanager}/bin/nmcli radio wifi)" != enabled ]; then
        exit 0
      fi

      if ${pkgs.networkmanager}/bin/nmcli -t -f TYPE,STATE device | ${pkgs.gnugrep}/bin/grep -qE '^(wifi|ethernet):connected$'; then
        exit 0
      fi

      ${pkgs.systemd}/bin/systemctl restart NetworkManager.service
    '';
  };
}
