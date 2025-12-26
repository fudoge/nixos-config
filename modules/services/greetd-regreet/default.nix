{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.regreet}/bin/regreet";
        user = "greeter";
      };
      initial_session = {
        command = "Hyprland";
        user = "chaewoon";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  environment.systemPackages = with pkgs; [
    adw-gtk3
    papirus-icon-theme
  ];

  environment.variables = {
    GTK_THEME = "adw-gtk3-dark";
  };
}
