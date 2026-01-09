{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim.lsp = {
        enable = true;
      };
    };
  };
  vim = {
    languages = {
      rust.enable = true;
      clang.enable = true;
      ts.enable = true;
      nix.enable = true;
      go.enable = true;
      lua.enable = true;
      html.enable = true;
      markdown.enable = true;
      css.enable = true;
      hcl.enable = true;
      helm.enable = true;
      yaml.enable = true;
      bash.enable = true;
      python.enable = true;
    };
  };
}
