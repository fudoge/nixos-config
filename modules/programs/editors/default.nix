{
  config,
  pkgs,
  lib,
  hostFeatures ? {},
  ...
}: let
  cfg = {withGui = false;} // hostFeatures;
in {
  imports =
    [
      ./nvf
    ]
    ++ lib.optionals cfg.withGui [
      ./vscode
      ./zed
    ];
}
