{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    (pkgs.writeShellScriptBin "synology-chat-apc" ''
      exec ${pkgs.vivaldi}/bin/vivaldi \
          --ozone-platform=wayland \
          --enable-features=UseOzonePlatform \
          --app=https://apclab-1336-hallym.direct.quickconnect.to:5001/?launchApp=SYNO.SDS.Chat.Application
    '')
  ];

  home.file.".local/share/icons/hicolor/256x256/apps/synochat.png".source = ../../../../assets/icons/synochat.png;

  xdg.desktopEntries.synology-chat-apc = {
    name = "Synology Chat - APCLab";
    exec = "synology-chat-apc";
    icon = "synochat";
    categories = ["Office" "Utility"];
  };
}
