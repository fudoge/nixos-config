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
    hyprqt6engine = {
      url = "github:hyprwm/hyprqt6engine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gws-cli = {
      url = "github:googleworkspace/cli";
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
    nixosConfigurations = {
      # 🐧 ThinkPad
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs username;
        };

        modules = [
          ({pkgs, ...}: {
            environment.systemPackages = [
              pkgs.alejandra
            ];
          })

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

      # 🍫 Windows
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs username;
        };

        modules = [
          nixos-wsl.nixosModules.default

          ({pkgs, ...}: {
            environment.systemPackages = [
              pkgs.alejandra
            ];
          })

          ./hosts/wsl/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = {
              inherit inputs username;
              platform = "linux-wsl";
              withGui = false;
              withHyprland = false;
              unstable = mkPkgs "x86_64-linux" inputs.nixpkgs-unstable;
            };

            home-manager.users.${username} = {
              imports = [
                ./home/profiles/wsl.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };
    };

    # 🍎 MacOS
    darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      specialArgs = {
        inherit inputs username;
      };

      modules = [
        determinate.darwinModules.default
        home-manager.darwinModules.home-manager
        ./hosts/macbook/configuration.nix

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
