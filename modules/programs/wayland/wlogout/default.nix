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
  caelestiaLock = pkgs.writeShellScriptBin "caelestia-lock" ''
    set -euo pipefail

    runtime_dir="''${XDG_RUNTIME_DIR:-/tmp}"
    guard="$runtime_dir/caelestia-lock.guard"
    stamp="$runtime_dir/caelestia-lock.stamp"
    now="$(${pkgs.coreutils}/bin/date +%s)"

    exec 9>"$guard"
    ${pkgs.util-linux}/bin/flock -n 9 || exit 0

    if [ -r "$stamp" ]; then
      last="$(${pkgs.coreutils}/bin/cat "$stamp" 2>/dev/null || ${pkgs.coreutils}/bin/echo 0)"
      if [ "$((now - last))" -lt 5 ]; then
        exit 0
      fi
    fi

    ${pkgs.coreutils}/bin/printf '%s\n' "$now" > "$stamp"
    exec ${caelestia} shell lock lock
  '';
  lockCmd = "${caelestiaLock}/bin/caelestia-lock";
in {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = lockCmd;
        text = "Lock";
        keybind = "l";
      }
      {
        label = "suspend";
        action = "${lockCmd} && ${systemctl} suspend";
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
        action = "${lockCmd} && ${systemctl} hibernate";
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
