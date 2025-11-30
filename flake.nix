{
	description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		nvf.url = "github:notashelf/nvf";
	};

	outputs = inputs@{ nixpkgs, home-manager, nvf, ... }: {
    nixosConfigurations = {
      spaceship = nixpkgs.lib.nixosSystem {

        modules = [
				  ./configuration.nix
				  nvf.homeManagerModules.default
					home-manager.nixosModules.home-manager {
				    home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.chaewoon = import ./home/home.nix;
					}
				];
			};
    };
	};
}
