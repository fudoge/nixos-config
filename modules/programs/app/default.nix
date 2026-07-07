{
  config,
  pkgs,
  lib,
  ...
}: let
  runInUserScope = pkgs.writeShellScriptBin "run-in-user-scope" ''
    set -euo pipefail

    scope_name="$1"
    shift

    exec ${pkgs.systemd}/bin/systemd-run \
      --user \
      --scope \
      --collect \
      --quiet \
      --unit="app-''${scope_name}-$$" \
      -- "$@"
  '';
in {
  imports = [
    ./spotify-player
    ./vesktop
    ./sioyek
    ./anki
    ./notion
    ./synology-chat
  ];

  home.packages = [
    runInUserScope
  ];

  xdg.desktopEntries = {
    vivaldi-stable = {
      name = "Vivaldi";
      genericName = "Web Browser";
      exec = "run-in-user-scope vivaldi ${lib.getExe pkgs.vivaldi} %U";
      icon = "vivaldi";
      terminal = false;
      categories = ["Network" "WebBrowser"];
      mimeType = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
    };

    slack = {
      name = "Slack";
      exec = "run-in-user-scope slack ${lib.getExe pkgs.slack} -s %U";
      icon = "slack";
      terminal = false;
      categories = ["Network" "InstantMessaging"];
    };

    obsidian = {
      name = "Obsidian";
      exec = "run-in-user-scope obsidian ${lib.getExe pkgs.obsidian} %U";
      icon = "obsidian";
      terminal = false;
      categories = ["Office" "Utility"];
      mimeType = ["x-scheme-handler/obsidian"];
    };

    spotify = {
      name = "Spotify";
      exec = "run-in-user-scope spotify ${lib.getExe pkgs.spotify} %U";
      icon = "spotify-client";
      terminal = false;
      categories = ["Audio" "Music" "Player" "AudioVideo"];
    };
  };
}
