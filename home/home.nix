{ config, pkgs, ... }:
{
	imports = [
		./programs
	];

	home.username = "chaewoon";
	home.homeDirectory = "/home/chaewoon";

	home.packages = with pkgs; [
		# editor
		neovim
		
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
	];

	# git configuration
	programs.git = {
		enable = true;
		userName = "Chaewoon Kang";
		userEmail = "kchawoon@naver.com";
		extraConfig.init.defaultBranch = "main";
	};

	# gh-cli configuration
	programs.gh = {
				enable = true;
				gitCredentialHelper = {
								enable = true;
				};
  };

	# starship prompt
	programs.starship = {
		enable = true;
		settings = {
			add_newline = true;
			truncate_to_repo = false;
			time.disabled = false;
			time.format = "$time ($style) ";
			cpp.disabled = false;
		};
	};

	# zsh configuration
	programs.zsh = {
		enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    shellAliases = {
				ls = "eza --icons";
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
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
    '';
	};

	# Ghostty
	programs.ghostty = {
    enable = true;
		settings = {
      font-size = 11;
			font-thicken = "true";
			font-thicken-strength = "10";
			theme = "catppuccin-frappe";
			cursor-style = "block";
			background-opacity = "0.9";

			window-padding-x = "2, 2";
			window-padding-y = "2, 2";
		};
	};

        # vscode
        programs.vscode = {
                enable = true;
        };

	home.stateVersion = "25.05";
}
