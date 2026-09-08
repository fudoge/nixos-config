{
  config,
  pkgs,
  lib,
  ...
}: let
  uwsm = lib.getExe pkgs.uwsm;
  app = command: "${uwsm} app -- ${command}";
in {
  imports = [
    ./wlogout
    ./caelestia
  ];

  xdg.desktopEntries = {
    zen-beta = {
      name = "Zen Browser (Beta)";
      genericName = "Web Browser";
      exec = app "zen-beta --name zen-beta %U";
      icon = "zen-browser";
      terminal = false;
      startupNotify = true;
      categories = ["Network" "WebBrowser"];
      mimeType = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "application/vnd.mozilla.xul+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
      settings.StartupWMClass = "zen-beta";
    };

    thunderbird = {
      name = "Thunderbird";
      genericName = "Email Client";
      comment = "Read and write e-mails or RSS feeds, or manage tasks on calendars.";
      exec = app "thunderbird --name thunderbird %U";
      icon = "thunderbird";
      terminal = false;
      startupNotify = true;
      categories = ["Network" "Chat" "Email" "Feed" "GTK" "News"];
      mimeType = [
        "message/rfc822"
        "x-scheme-handler/mailto"
        "text/calendar"
        "text/x-vcard"
      ];
      settings.StartupWMClass = "thunderbird";
    };

    obsidian = {
      name = "Obsidian";
      comment = "Knowledge base";
      exec = app "obsidian %u";
      icon = "obsidian";
      terminal = false;
      categories = ["Office"];
      mimeType = ["x-scheme-handler/obsidian"];
      settings.StartupWMClass = "md.Obsidian";
    };

    vivaldi-stable = {
      name = "Vivaldi";
      genericName = "Web Browser";
      comment = "Access the Internet";
      exec = app "vivaldi %U";
      icon = "vivaldi";
      terminal = false;
      startupNotify = true;
      categories = ["Network" "WebBrowser"];
      mimeType = [
        "application/pdf"
        "application/rdf+xml"
        "application/rss+xml"
        "application/xhtml+xml"
        "application/xhtml_xml"
        "application/xml"
        "image/gif"
        "image/jpeg"
        "image/png"
        "image/webp"
        "text/html"
        "text/xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
    };

    spotify = {
      name = "Spotify";
      genericName = "Music Player";
      exec = app "spotify %U";
      icon = "spotify-client";
      terminal = false;
      categories = ["Audio" "Music" "Player" "AudioVideo"];
      mimeType = ["x-scheme-handler/spotify"];
      settings.StartupWMClass = "spotify";
    };

    discord = {
      name = "Discord";
      genericName = "All-in-one cross-platform voice and text chat for gamers";
      exec = app "Discord";
      icon = "discord";
      terminal = false;
      categories = ["Network" "InstantMessaging"];
      mimeType = ["x-scheme-handler/discord"];
      settings.StartupWMClass = "discord";
    };

    vesktop = {
      name = "Vesktop";
      genericName = "Internet Messenger";
      exec = app "vesktop %U";
      icon = "vesktop";
      terminal = false;
      categories = ["Network" "InstantMessaging" "Chat"];
      mimeType = ["x-scheme-handler/discord"];
      settings.StartupWMClass = "Vesktop";
    };

    "org.kde.dolphin" = {
      name = "Dolphin";
      genericName = "File Manager";
      comment = "Manage your files";
      exec = app "dolphin %u";
      icon = "org.kde.dolphin";
      terminal = false;
      categories = ["Qt" "KDE" "System" "FileTools" "FileManager"];
      mimeType = ["inode/directory"];
      settings.StartupWMClass = "dolphin";
    };

    "com.mitchellh.ghostty" = {
      name = "Ghostty";
      comment = "A terminal emulator";
      exec = app "ghostty --gtk-single-instance=true";
      icon = "com.mitchellh.ghostty";
      terminal = false;
      startupNotify = true;
      categories = ["System" "TerminalEmulator"];
      settings.StartupWMClass = "com.mitchellh.ghostty";
    };
  };
}
