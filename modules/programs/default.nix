{
  config,
  pkgs,
  lib,
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
    eza
    fzf
    skim
    zoxide
    github-cli
    bat
    parted
    fd

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
    hugo
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

    # infra-tools
    terraform
    kubectl
    kubernetes-helm
    kubectx
    argocd
    cilium-cli
    awscli
    supabase-cli

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

    # yazi
    ffmpegthumbnailer
    poppler
    imagemagick
    ueberzugpp

    # rclone
    rclone
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard";
      package = pkgs.catppuccin-gtk;
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
