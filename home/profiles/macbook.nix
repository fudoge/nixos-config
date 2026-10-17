{
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../modules/programs
    ../../modules/shell
  ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";

  home.file.".tmux.conf".text = "set -g mouse on\n";

  # Keep Terraform's plugin cache and checkpoint preference from the old dotfiles.
  home.file.".terraformrc".text = ''
    plugin_cache_dir   = "$HOME/.terraform.d/plugin-cache"
    disable_checkpoint = true
  '';

  home.stateVersion = "26.05";
}
