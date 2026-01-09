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
    skim
    zoxide
    github-cli
    bat

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

    # dev
    go
    python3
    rustup
    nodejs
  ];
}
