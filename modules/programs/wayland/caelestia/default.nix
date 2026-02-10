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
    };

    cli = {
      enable = true;
      settings = {
        theme.enableGtk = false;
      };
    };
  };
}
