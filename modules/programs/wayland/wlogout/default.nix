{
  config,
  pkgs,
  lib,
  ...
}: let
  assets = "${config.programs.wlogout.package}/share/wlogout/icons";
  caelestia = "${config.programs.caelestia.cli.package}/bin/caelestia";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  systemctl = "${pkgs.systemd}/bin/systemctl";
in {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "${caelestia} shell lock lock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "suspend";
        action = "${caelestia} shell lock lock && ${systemctl} suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "logout";
        action = "${hyprctl} dispatch exit";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "hibernate";
        action = "${caelestia} shell lock lock && ${systemctl} hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "reboot";
        action = "${systemctl} reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "${systemctl} poweroff";
        text = "Shutdown";
        keybind = "s";
      }
    ];

    style = lib.mkForce ''
      * {
        background-image: none;
        box-shadow: none;
        font-family: "CaskaydiaCove Nerd Font", "Noto Sans", sans-serif;
      }

      window {
        background-color: rgba(35, 38, 52, 0.78);
      }

      button {
        color: #c6d0f5;
        background-color: rgba(48, 52, 70, 0.92);
        border: 1px solid rgba(198, 208, 245, 0.18);
        border-radius: 8px;
        background-repeat: no-repeat;
        background-position: center 42%;
        background-size: 30%;
        margin: 0;
        padding: 128px 32px 28px;
        font-size: 18px;
        font-weight: 700;
      }

      button:hover,
      button:focus {
        color: #232634;
        background-color: #99d1db;
        border-color: #99d1db;
        outline-style: none;
      }

      button:active {
        background-color: #85c1dc;
        border-color: #85c1dc;
      }

      #lock {
        background-image: image(url("${assets}/lock.png"));
      }

      #logout {
        background-image: image(url("${assets}/logout.png"));
      }

      #suspend {
        background-image: image(url("${assets}/suspend.png"));
      }

      #hibernate {
        background-image: image(url("${assets}/hibernate.png"));
      }

      #reboot {
        background-image: image(url("${assets}/reboot.png"));
      }

      #shutdown {
        background-image: image(url("${assets}/shutdown.png"));
      }
    '';
  };
}
