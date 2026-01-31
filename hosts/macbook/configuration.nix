{ config, pkgs, lib, inputs, username, ... }:

{
  # Use Determinate Nix
  nix.enable = false;

  determinateNix = {
    enable = true;
    customSettings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" username ];
    };
  };

  system.stateVersion = 5;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  environment.systemPackages = with pkgs; [ git ];
}
