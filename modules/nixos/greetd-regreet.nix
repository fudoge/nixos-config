{
  config,
  pkgs,
  lib,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland --config /etc/greetd/hyprland.conf";
        user = "greeter";
      };
    };
  };

  programs.hyprland.enable = true;

  environment.etc."greetd/hyprland.conf".text = ''
    monitor = ,preferred,auto,1

    exec-once = ${pkgs.regreet}/bin/regreet; hyprctl dispatch exit

    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
    }
  '';

  environment.etc."greetd/regreet.toml".text = ''
    [background]
    fit = "Cover"

    [GTK]
    application_prefer_dark_theme = true
    theme_name = "catppuccin-frappe-blue-standard"
    icon_theme_name = "Papirus-Dark"

    [commands]
    reboot = ["systemctl", "reboot"]
    poweroff = ["systemctl", "poweroff"]
  '';
}
