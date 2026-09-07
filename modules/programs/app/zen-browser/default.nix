{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
  };

  xdg.desktopEntries.zen-beta = {
    name = "Zen Browser (Beta)";
    genericName = "Web Browser";
    exec = "run-in-user-scope zen-beta ${lib.getExe config.programs.zen-browser.package} %U";
    icon = "zen-browser";
    terminal = false;
    categories = ["Network" "WebBrowser"];
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "application/x-xpinstall"
      "application/pdf"
      "application/json"
    ];
  };
}
