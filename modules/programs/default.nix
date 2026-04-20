{
  config,
  pkgs,
  lib,
  inputs,
  unstable,
  ...
}: {
  imports = [
    ./git
    ./fetches
    ./other-tools
    ./infra-tools
    ./app
    ./catppuccin
    ./editors
    ./hypr
    ./terminals
    ./wayland
    ./filemanager
    ./kde
    ./rclone
    ./agent
    ./email
  ];
  home.packages = with pkgs; [
    # fetches
    fastfetch
    nitch
    pfetch
    onefetch

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
    parted
    fd
    pre-commit

    # networking
    mtr
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
    iotop
    iftop
    bottom

    # syscall monitoring
    lsof
    strace
    ltrace

    # system tools
    sysstat
    lm_sensors
    ethtool
    dnsutils
    pciutils
    usbutils

    # guis
    hyprland

    # shell configurations
    zsh-fast-syntax-highlighting
    zsh-autosuggestions

    # node
    yarn

    # wayland
    dart-sass
    wl-clipboard
    xclip

    # infra-tools
    unstable.terraform
    unstable.opentofu
    unstable.ansible
    terragrunt
    kubectl
    kubernetes-helm
    kubectx
    argocd
    cilium-cli
    awscli2
    ssm-session-manager-plugin
    google-cloud-sdk
    unstable.supabase-cli
    eksctl

    # dev
    go
    python3
    rustup
    nodejs

    # hyprpapers
    grim
    grimblast
    slurp
    libnotify

    # image rendering
    chafa
    # pdf rendering
    tdf

    # yazi
    ffmpegthumbnailer
    poppler
    imagemagick
    ueberzugpp

    # rclone
    rclone

    # google
    inputs.gws-cli.packages.${pkgs.stdenv.hostPlatform.system}.gws
  ];

  gtk = {
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

  xdg = {
    enable = true;

    portal = {
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
