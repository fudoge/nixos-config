{
  config,
  pkgs,
  lib,
  ...
}: let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in {
  imports = [
    ./fastfetch
  ];

  home.packages = with pkgs;
    [
      pfetch
      onefetch
    ]
    ++ lib.optionals isLinux [
      nitch
    ];
}
