{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    (pkgs.writeShellScriptBin "notion-pwa" ''
      exec ${pkgs.vivaldi}/bin/vivaldi \
          --ozone-platform=wayland \
          --enable-features=UseOzonePlatform \
          --app=https://www.notion.so
    '')
  ];

  home.file.".local/share/icons/hicolor/256x256/apps/notion.png".source = ../../../../assets/icons/notion.png;

  xdg.desktopEntries.notion = {
    name = "Notion";
    exec = "notion-pwa";
    icon = "notion";
    categories = ["Office" "Utility"];
  };
}
