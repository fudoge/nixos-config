{
  description = "Chaewoon's NixOS Flake";

  inputs = {
    # Nix
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # nix-darwin
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Determinate Nix (macOS only)
    determinate = {
      url = "github:DeterminateSystems/determinate";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Extras
    catppuccin.url = "github:catppuccin/nix";
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nix-darwin,
    determinate,
    nixos-wsl,
    home-manager,
    catppuccin,
    nvf,
    caelestia-shell,
    alejandra,
    ...
  } @ inputs: let
    username = "chaewoon";
    mkPkgs = system: src:
      import src {
        inherit system;
        config.allowUnfree = true;
      };
  in {
    # 🐧 NixOS
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs username;
          system = "x86_64-linux";
        };
        modules = [
          ({system, ...}: {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          })
          ./hosts/thinkpad/configuration.nix
          {
          }
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
              unstable = mkPkgs "x86_64-linux" inputs.nixpkgs-unstable;
            };
            home-manager.users.${username} = {
              imports = [
                ./home/profiles/thinkpad.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };
    };
    # 🍎 macOS
    darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      specialArgs = {
        inherit inputs username;
      };

      modules = [
        # Determinate manages Nix
        determinate.darwinModules.default

        # Home Manager
        home-manager.darwinModules.home-manager

        # Host-specific config
        ./hosts/macbook/configuration.nix

        # Inline glue
        {
          nix.enable = false;
          system.stateVersion = 5;

          users.users.${username} = {
            name = username;
            home = "/Users/${username}";
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = {
            inherit inputs username;
            platform = "darwin";
          };

          home-manager.users.${username}.imports = [
            ./home/profiles/macbook.nix
            catppuccin.homeModules.catppuccin
          ];

          home-manager.backupFileExtension = "flake-backup";
        }
      ];
    };
  };
}
