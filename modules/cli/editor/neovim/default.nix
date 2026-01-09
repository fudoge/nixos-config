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
}
