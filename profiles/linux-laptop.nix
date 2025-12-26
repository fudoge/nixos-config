{ ... }:
{
  imports = [
    ../modules/services/docker.nix
    ../modules/editors/neovim
  ];

  services.printing.enable = true;
}
