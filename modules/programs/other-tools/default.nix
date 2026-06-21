{
  config,
  pkgs,
  lib,
  hostFeatures ? {},
  ...
}: let
  cfg = {withSpicetify = false;} // hostFeatures;
in {
  imports =
    [
      ./cava
    ]
    ++ lib.optionals cfg.withSpicetify [
      ./spicetify
    ];
}
