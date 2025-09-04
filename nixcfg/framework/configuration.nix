# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ lib, config, pkgs, ... }:

{
	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		<nixos-hardware/framework/13-inch/7040-amd>
	];

	# Bootloader.
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
		# AMD GPU support
		kernelModules = [ "amdgpu" ];
		kernelParams = [ "amd_pstate=active" ];
	};

	networking = {
		hostName = "framework";
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
			xkb = {
				layout = "us";
				variant = "";
				options = "escape:swapcaps";
			};
		};
		
		logind.killUserProcesses = true;
		openssh.enable = true;
		
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};
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
	hardware = {
		# AMD microcode updates
		cpu.amd.updateMicrocode = true;
		bluetooth = {
			enable = true;
			powerOnBoot = true;
		};
	};
	security.rtkit.enable = true;

	users.users.payton = {
		isNormalUser = true;
		description = "Payton Webber";
		extraGroups = [ "networkmanager" "wheel" "video" "audio" "dialout" ];
		packages = with pkgs; [
			
			# Desktop
			hyprland
			libnotify
			waybar
			swww
			dunst
			light

			# Applications
			firefox
			discord
			zathura
      fuzzel

			# Misc
			bat
		];
	};

	nixpkgs.config.allowUnfree = true;
	nix = {
		package = pkgs.nix; # Updated from nixFlakes
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
    fastfetch
		tmux
		htop

	];

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
	];

	
	system.stateVersion = "25.05";
}
