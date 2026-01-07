{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./editors
    ./git
    ./fetches
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
    zoxide
    github-cli

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
    argocd
    helm
    cilium-cli
  ];
}
