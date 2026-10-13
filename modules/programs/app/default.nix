{
  lib,
  pkgs,
  unstable,
  ...
}: let
  chatgptWithIme = pkgs.writeShellScriptBin "chatgpt" ''
    export NIXOS_OZONE_WL=1
    exec ${lib.getExe unstable.chatgpt} --wayland-text-input-version=3 "$@"
  '';
in {
  imports = [
    ./spotify-player
    ./vesktop
    ./sioyek
    ./anki
    ./notion
    ./synology-chat
    ./minecraft
    ../clawd-on-desk
  ];

  home.packages = [
    unstable.chatgpt
    (lib.hiPrio chatgptWithIme)
  ];
}
