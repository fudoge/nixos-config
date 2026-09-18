{
  config,
  pkgs,
  lib,
  ...
}: {
  # zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    shellAliases = {
      ls = "eza --icons";
      k = "kubectl";
      kubectl = "kubecolor";
      tf = "terraform";
      cl = "clear";
      cd = "z";
      cat = "bat";
      sk = "sk --preview='bat {} --color=always'";
    };

    history.size = 10000;
    history.path = "$HOME/.zsh_history";
    history.ignoreAllDups = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "zoxide"
      ];
    };

    initContent = ''
      # kubecolor 0.7.1 does not register completion for its own command name.
      # Use kubectl's completion for both aliases as well as the real command.
      compdef _kubectl kubectl kubecolor k

      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
      export PATH=$PATH:~/.local/bin
    '';
  };
}
