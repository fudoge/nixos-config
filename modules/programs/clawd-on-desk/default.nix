{
  pkgs,
  lib,
  ...
}: let
  clawd-on-desk = pkgs.appimageTools.wrapType2 rec {
    pname = "clawd-on-desk";
    version = "0.16.0";

    src = pkgs.fetchurl {
      url = "https://github.com/rullerzhou-afk/clawd-on-desk/releases/download/v${version}/Clawd-on-Desk-${version}-x86_64.AppImage";
      hash = "sha256-QUqEYW691fY5VxKpfp1RbhimAd35Y6nSLeF59WnIBgw=";
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
