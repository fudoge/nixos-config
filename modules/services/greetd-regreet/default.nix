{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
        user = "greeter";
      };
    };
  };

  environment.etc."greetd/regreet.toml".text = ''
    [command]
    reboot = ["systemctl", "reboot"]
    poweroff = ["systemctl", "poweroff"]
  '';
}
