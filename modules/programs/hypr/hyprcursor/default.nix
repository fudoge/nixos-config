{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    bibata-cursors
    hyprcursor
  ];

  home.pointerCursor = {
    hyprcursor.enable = true;
    gtk.enable = true;
    x11.enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # ✅ 여기엔 Xcursor만 남기거나, 아예 비워도 됨
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}
