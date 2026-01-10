{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.anki = {
    enable = true;
    language = "ko_KR";
  };
}
