{
  pkgs,
  lib,
  ...
}: let
  clawd-on-desk = pkgs.appimageTools.wrapType2 rec {
    pname = "clawd-on-desk";
    version = "0.15.0";

    src = pkgs.fetchurl {
      url = "https://github.com/rullerzhou-afk/clawd-on-desk/releases/download/v${version}/Clawd-on-Desk-${version}-x86_64.AppImage";
      hash = "sha256-uZMrLnaKRaBniveEo4SrCCVx2x3D5F2NdN2JKBv1s1E=";
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
