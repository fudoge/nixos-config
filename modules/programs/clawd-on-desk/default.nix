{
  pkgs,
  lib,
  ...
}: let
  clawd-on-desk = pkgs.appimageTools.wrapType2 rec {
    pname = "clawd-on-desk";
    version = "1.0.0";

    src = pkgs.fetchurl {
      url = "https://github.com/rullerzhou-afk/clawd-on-desk/releases/download/v${version}/Clawd-on-Desk-${version}-x86_64.AppImage";
      hash = "sha256-CfECZCcfcJXGxgIb5L3luXe6FlAxwdiXC20iGdjZOU4=";
    };
  };
in {
  home.packages = [
    clawd-on-desk
  ];

  xdg.desktopEntries.clawd-on-desk = {
    name = "Clawd on Desk";
    exec = lib.getExe clawd-on-desk;
    terminal = false;
    categories = ["Utility"];
  };
}
