{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprland = config.programs.hyprland.package;
  startHyprland = lib.getExe' hyprland "start-hyprland";
  hyprctl = lib.getExe' hyprland "hyprctl";
  dbusRunSession = lib.getExe' pkgs.dbus "dbus-run-session";

  regreetSession = pkgs.writeShellScript "regreet-session" ''
    export GDK_BACKEND=wayland
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=Hyprland

    ${pkgs.regreet}/bin/regreet --config /etc/greetd/regreet.toml
    ${hyprctl} dispatch exit
  '';
in {
  programs.hyprland.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${dbusRunSession} ${startHyprland} -- -c /etc/greetd/hyprland.conf";
        user = "greeter";
      };
    };
  };

  environment.etc."greetd/hyprland.conf".text = ''
    monitor = ,preferred,auto,1

    exec-once = ${regreetSession}

    misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
      disable_hyprland_guiutils_check = true
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
