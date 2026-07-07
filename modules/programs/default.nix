{
  config,
  pkgs,
  lib,
  inputs,
  unstable,
  hostFeatures ? {},
  ...
}: let
  cfg =
    {
      name = "unknown";
      platform = "unknown";
      isNixOS = false;
      isWsl = false;
      isDarwin = false;
      withGui = false;
      withWayland = false;
      withHyprland = false;
      withDesktopApps = false;
      withInfraTools = true;
      withRclone = false;
      withEmail = false;
      withSpicetify = false;
    }
    // hostFeatures;

  isLinuxTarget = cfg.isNixOS || cfg.isWsl;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  system = pkgs.stdenv.hostPlatform.system;
  gws = inputs.gws-cli.packages.${system}.gws or null;
in {
  imports =
    [
      ./git
      ./fetches
      ./catppuccin
      ./editors
      ./filemanager
      ./agent
    ]
    ++ lib.optionals cfg.withInfraTools [./infra-tools]
    ++ lib.optionals cfg.withDesktopApps [
      ./app
    ]
    ++ lib.optionals cfg.withGui [
      ./terminals
      ./kde
      ./other-tools
    ]
    ++ lib.optionals (isLinuxTarget && cfg.withWayland) [./wayland]
    ++ lib.optionals (isLinuxTarget && cfg.withHyprland) [./hypr]
    ++ lib.optionals (isLinuxTarget && cfg.withRclone) [./rclone]
    ++ lib.optionals (cfg.withEmail) [./email];

  home.packages = with pkgs;
    [
      # archives
      nnn
      zip
      xz
      unzip
      p7zip

      # utils
      ripgrep
      jq
      yq-go
      fzf
      skim
      github-cli
      fd
      pre-commit

      # networking
      iperf3
      dnsutils
      ldns
      aria2
      socat
      nmap
      ipcalc

      # misc
      cowsay
      file
      which
      tree
      gnused
      gnutar
      gawk
      zstd
      gnupg
      chafa

      # nix related
      nix-output-monitor

      # productivity
      unstable.hugo
      glow

      # monitoring
      btop
      bottom

      # shell configurations
      zsh-fast-syntax-highlighting
      zsh-autosuggestions

      # node
      yarn

      # dev
      go
      python3
      rustup
      nodejs
      unstable.devenv
      unstable.uv
      unstable.pipx
    ]
    ++ lib.optionals isLinux [
      # linux networking and system tools
      mtr
      parted
      iotop
      iftop
      lsof
      strace
      ltrace
      sysstat
      lm_sensors
      ethtool
      pciutils
      usbutils
    ]
    ++ lib.optionals isDarwin [
      mtr
      lsof
    ]
    ++ lib.optionals cfg.withInfraTools [
      unstable.terraform
      unstable.opentofu
      unstable.terragrunt
      unstable.ansible
      unstable.kubectl
      unstable.kubernetes-helm
      unstable.kubectx
      unstable.argocd
      unstable.cilium-cli
      unstable.istioctl
      unstable.kubeseal
      unstable.awscli2
      unstable.google-cloud-sdk
      unstable.supabase-cli
      unstable.eksctl
      unstable.wrangler
    ]
    ++ lib.optionals (isLinux && cfg.withInfraTools) [
      unstable.ssm-session-manager-plugin
    ]
    ++ lib.optionals (isLinux && cfg.withWayland) [
      dart-sass
      cliphist
      wl-clipboard
      xclip
      grim
      grimblast
      slurp
      libnotify
    ]
    ++ lib.optionals (isLinux && cfg.withHyprland) [
      hyprland
    ]
    ++ lib.optionals (isLinux && cfg.withGui) [
      # image/pdf rendering and preview helpers
      tdf
      ffmpegthumbnailer
      poppler
      imagemagick
      ueberzugpp

      # icons
      hicolor-icon-theme
      adwaita-icon-theme
    ]
    ++ lib.optionals (isLinux && cfg.withRclone) [
      rclone
    ]
    ++ lib.optionals (gws != null) [
      gws
    ];

  gtk = lib.mkIf (isLinux && cfg.withGui) {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard";
      package = pkgs.catppuccin-gtk;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
    gtk3.extraConfig = {
      "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
    };
  };

  xdg = lib.mkIf (isLinux && cfg.withGui) {
    enable = true;

    portal = lib.mkIf cfg.withWayland {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        "inode/directory" = ["org.kde.dolphin.desktop"];

        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["onlyoffice-desktopeditors.desktop"];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = ["onlyoffice-desktopeditors.desktop"];
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["onlyoffice-desktopeditors.desktop"];
      };
    };
  };
}
