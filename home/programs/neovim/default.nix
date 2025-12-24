{config, pkgs, lib, ... }:

{
	programs.neovim = {
		enable = true;
		extraPackages = with pkgs; [
			lua-language-server
			nil
			stylua
			nodePackages.typescript-language-server
			nodePackages.prettier
		];
		extraLuaConfig = builtins.readFile ./nvim/init.lua;
	};
	xdg.configFile."nvim".source = ./nvim;
}
