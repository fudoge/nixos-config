{
  description = "Chaewoon's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      nixos-wsl,
      ...
    }@inputs:
    let
      username = "chaewoon";
    in
    {
      nixosConfigurations = {
        thinkpad = nixpkgs.lib.nixosSystem {

          specialArgs = { inherit inputs username; };
          modules = [
            ./hosts/thinkpad/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.backupFileExtension = "backup";
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs username;
                platform = "linux-desktop";
                withGui = true;
                withHyprland = true;
              };
              home-manager.users.${username} = {
                imports = [
                  ./home/profiles/thinkpad.nix
                ];
              };
            }
          ];
        };
      };
    };
}
