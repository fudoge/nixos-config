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
      icon_theme = Papirus-Dark
    }

    misc {
      menus_have_icons = true
    }
  '';
}
