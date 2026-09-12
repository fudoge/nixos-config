{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."hypr/hyprqt6engine.conf".text = ''
    theme {
      font = Noto Sans CJK KR
      font_size = 14
      color_scheme = ${config.xdg.dataHome}/color-schemes/RosePine.colors
      icon_theme = Papirus-Dark
      style = kvantum-dark
    }

    misc {
      menus_have_icons = true
    }
  '';
}
