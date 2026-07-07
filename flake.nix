{
  description = "Chaewoon's NixOS Flake";

  inputs = {
    # Nix
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # nix-darwin
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
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
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Extras
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
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
    spicetify-nix,
    ...
  } @ inputs: let
    username = "chaewoon";
    uiTheme = "rose-pine";

    mkPkgs = system: src:
      import src {
        inherit system;
        config.allowUnfree = true;
      };

    mkHostFeatures = {
      name,
      platform,
      isNixOS ? false,
      isWsl ? false,
      isDarwin ? false,
      withGui ? false,
      withWayland ? false,
      withHyprland ? false,
      withDesktopApps ? false,
      withInfraTools ? true,
      withRclone ? false,
      withEmail ? false,
      withSpicetify ? false,
      theme ? uiTheme,
    }: {
      inherit
        name
        platform
        isNixOS
        isWsl
        isDarwin
        withGui
        withWayland
        withHyprland
        withDesktopApps
        withInfraTools
        withRclone
        withEmail
        withSpicetify
        theme
        ;
    };

    systems = [
      "x86_64-linux"
      "aarch64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystems (
      system: let
        pkgs = mkPkgs system nixpkgs;
      in
        pkgs.writeShellApplication {
          name = "nix-format";
          runtimeInputs = [
            pkgs.alejandra
          ];
          text = ''
            if [ "$#" -eq 0 ]; then
              exec alejandra .
            fi

            exec alejandra "$@"
          '';
        }
    );

    checks = forAllSystems (
      system: let
        pkgs = mkPkgs system nixpkgs;
      in {
        format =
          pkgs.runCommand "check-format"
          {
            nativeBuildInputs = [
              pkgs.alejandra
            ];
          }
          ''
            alejandra --check ${self}
            touch $out
          '';
      }
    );

    devShells = forAllSystems (
      system: let
        pkgs = mkPkgs system nixpkgs;
      in {
        default = pkgs.mkShell {
          packages = [
            pkgs.alejandra
            pkgs.pre-commit
          ];
        };
      }
    );

    nixosConfigurations = {
      # 🐧 ThinkPad
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs username;
          unstable = mkPkgs "x86_64-linux" inputs.nixpkgs-unstable;
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
              hostFeatures = mkHostFeatures {
                name = "thinkpad";
                platform = "linux-desktop";
                isNixOS = true;
                withGui = true;
                withWayland = true;
                withHyprland = true;
                withDesktopApps = true;
                withRclone = true;
                withEmail = true;
                withSpicetify = true;
              };
              unstable = mkPkgs "x86_64-linux" inputs.nixpkgs-unstable;
            };

            home-manager.users.${username} = {
              imports = [
                ./home/profiles/thinkpad.nix
                catppuccin.homeModules.catppuccin
                spicetify-nix.homeManagerModules.default
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
          unstable = mkPkgs "x86_64-linux" inputs.nixpkgs-unstable;
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
              hostFeatures = mkHostFeatures {
                name = "wsl";
                platform = "linux-wsl";
                isNixOS = true;
                isWsl = true;
              };
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
            hostFeatures = mkHostFeatures {
              name = "macbook";
              platform = "darwin";
              isDarwin = true;
              withGui = true;
              withDesktopApps = false;
              withInfraTools = true;
            };
            unstable = mkPkgs "aarch64-darwin" inputs.nixpkgs-unstable;
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
