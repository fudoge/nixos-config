{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
      "go"
      "python"
      "c"
      "cpp"
      "yaml"
      "hcl"
      "json"
      "lua"
      "make"
    ];
    vim_mode = true;
  };
}
