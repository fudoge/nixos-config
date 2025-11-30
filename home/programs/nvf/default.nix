{ config, pkgs, lib, ... }:
{
  programs.nvf = {
    enable = true;
		settings = {
			vim.theme.name = "gruvbox";
			vim.theme.style = "dark";

			vim.languages.nix.enable = true;
    };
  };
}
