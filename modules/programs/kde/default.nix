{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."kdeglobals".source = ./kdeglobals;
  xdg.configFile."dolphinrc".source = ./dolphinrc;
  xdg.configFile."Kvantum/kvantum.kvconfig".source = ./kvantum.kvconfig;
  xdg.dataFile."color-schemes/RosePine.colors".source = ./RosePine.colors;
}
