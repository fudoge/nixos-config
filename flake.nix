{
	description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};

	outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {

        modules = [
				  ./hosts/thinkpad/configuration.nix
					home-manager.nixosModules.home-manager {
				    home-manager.useGlobalPkgs = true;
						home-manager.backupFileExtension = "backup";
						home-manager.useUserPackages = true;
						home-manager.users.chaewoon = {
						  imports = [
								./home/home.nix
							];
						};
					}
				];
			};
    };
	};
}
