{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    settings = {
      bar = {
        launcher.autoDetectIcon = true;
        workspaces = {
          show_icons = true;
          numbered_active_indicator = "underline";
        };
        customModules.cpuTemp.unit = "metric";
        customModules.storage.paths = [
          "/"
        ];
        notifications = {
          show_total = true;
          hideCountWhenZero = false;
        };
      };
      menus = {
        media = {
          hideAuthor = false;
          displayTime = false;
          hideAlbum = false;
          displayTimeTooltip = true;
        };
        clock = {
          time = {
            hideSeconds = true;
            military = true;
          };
          weather = {
            enabled = false;
          };
        };
        dashboard = {
          powermenu.avatar = {
            name = "chaewoon";
          };
          shortcuts = {
            left = {
              shortcut1.icon = "󰖟";
            };
          };
        };
      };
      theme = {
        bar = {
          menus.enableShadow = false;
          floating = false;
          buttons.enableBorders = false;
          border.location = "bottom";
          enableShadow = false;
        };
        font = {
          name = "JetBrains Mono NF";
          size = "14px";
        };
      };
    };
  };
}
