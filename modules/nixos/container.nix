{
  config,
  pkgs,
  lib,
  ...
}: {
  virtualisation.containers.enable = true;
  virtualisation.docker = {
    enable = true;
  };
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
