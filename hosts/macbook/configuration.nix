{
  config,
  pkgs,
  lib,
  inputs,
  username,
  ...
}: {
  imports = [../../modules/programs/agent/codex/system.nix];

  # Keep macOS apps and tools that are not yet managed directly by Nix
  # reproducible without removing unrelated Homebrew installations.
  homebrew = {
    enable = true;
    user = username;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };

    taps = ["hashicorp/tap"];

    brews = [
      "cmake"
      "docker"
      "emacs"
      "ffmpeg"
      "icu4c@76"
      "jenv"
      "jupyterlab"
      "kafka"
      "libomp"
      "libpcap"
      "llvm"
      "mingw-w64"
      "minikube"
      "mole"
      "openjdk@21"
      "pandoc"
      "podman"
      "python@3.10"
      "python@3.11"
      "python@3.13"
      "python@3.9"
      "rust"
      "telnet"
      # Trust only this formula, not every package in the HashiCorp tap.
      "hashicorp/tap/terraform"
      "watchman"
      "zsh"
      "zsh-autocomplete"
    ];

    casks = [
      "anki"
      "antigravity"
      "codex"
      "db-browser-for-sqlite"
      "firefox"
      "font-meslo-lg-nerd-font"
      "font-zed-mono-nerd-font"
      "ghostty"
      "iterm2"
      "pgadmin4"
      "signal"
      "slack"
      "sourcetree"
      "spotify"
      "stats"
      "steam"
      "synology-chat"
      "tableplus"
      "vesktop"
      "visual-studio-code"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = [pkgs.pretendard];

  # Use Determinate Nix
  nix.enable = false;

  determinateNix = {
    enable = true;
    customSettings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" username];
    };
  };

  system.stateVersion = 5;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  environment.systemPackages = with pkgs; [git];
}
