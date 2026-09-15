{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."kdeglobals".text =
    lib.replaceStrings
    ["[KDE]\n"]
    ["[KDE]\nwidgetStyle=kvantum-dark\n"]
    (builtins.readFile ./RosePine.colors)
    + ''

      [Icons]
      Theme=Papirus-Dark
    '';
  xdg.configFile."dolphinrc".source = ./dolphinrc;
  xdg.configFile."Kvantum/kvantum.kvconfig".source = ./kvantum.kvconfig;
  xdg.configFile."Kvantum/rose-pine-iris".source = "${pkgs.rose-pine-kvantum}/share/Kvantum/themes/rose-pine-iris";
  xdg.dataFile."color-schemes/RosePine.colors".source = ./RosePine.colors;
}
