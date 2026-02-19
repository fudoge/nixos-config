{inputs, ...}: {
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = true;

    systemd = {
      enable = true;
      target = "graphical-session.target";
      environment = [];
    };

    settings = {
      services = {
        useFahrenheit = false;
      };
    };

    cli = {
      enable = true;
      settings = {
        theme.enableGtk = false;
      };
    };
  };
}
