# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

	# Bootloader.
	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true; 		
	};

	networking = {
		hostName = "t480";
		networkmanager.enable = true;
	};

	# Set your time zone.
	time.timeZone = "America/Vancouver";
	location.provider = "geoclue2";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_CA.UTF-8";

	services = {
		xserver = {
			enable = true; 
			displayManager.gdm.enable = true;
			layout = "us";
			xkbVariant = "";
			xkbOptions = "escape:swapcaps";
		};
		gnome.gnome-keyring.enable = true;
		gvfs = {
			enable = true;
			package = lib.mkForce pkgs.gnome3.gvfs;
		};
		thermald.enable = true;
		tlp = {
			enable = true;
			settings = {
				PCIE_ASPM_ON_BAT = "powersupersave";
				CPU_SCALING_GOVERNOR_ON_AC = "performance";
				CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
				CPU_MAX_PERF_ON_AC = "100";
				CPU_MAX_PERF_ON_BAT = "30";
				STOP_CHARGE_THRESH_BAT1 = "95";
				STOP_CHARGE_THRESH_BAT0 = "95";
			};
		};
		logind.killUserProcesses = true;
		openssh.enable = true;
	};
	xdg.portal = {
		enable = true;
	};
	programs = {
		hyprland.enable = true; 
		waybar.enable = true;
		fish.enable = true;
		thunar.enable = true;
		light.enable = true;
	};

	sound.enable = true;
	hardware.pulseaudio.enable = true;
	security.rtkit.enable = true;

	users.users.payton = {
		isNormalUser = true;
		description = "Payton Webber";
		extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
		packages = with pkgs; [
			
			# Desktop
			hyprland
			rofi-power-menu
			libnotify
			waybar
			swww
			dunst
			light

			# Applications
			firefox
			discord
			zathura
			rofi
		];
	};

	nixpkgs.config.allowUnfree = true;
	nix = {
		package = pkgs.nixFlakes;
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 90d";
		};
		settings = {
			auto-optimise-store = true;
			experimental-features = [ "nix-command" "flakes" ];
		};
	};

	environment.systemPackages = with pkgs; [

		# Util Functions
		magic-wormhole
		unzip
		wget
		curl
		wireplumber
		wl-clipboard

		# Development Environment
		gh
		go
		gdb
		git
		eza
		clang
		neovim
		ranger
		fish
		kitty
		gnumake
		nodejs_20

		# TUI Utils
		neofetch
		tmux
		htop
	];

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
	];

	system.stateVersion = "23.11";
}
