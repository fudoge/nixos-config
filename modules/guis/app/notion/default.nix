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

  xdg.desktopEntries.notion = {
    name = "Notion";
    exec = "notion-pwa";
    icon = "notion";
    categories = ["Office" "Utility"];
  };
}
