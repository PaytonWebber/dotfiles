
{ lib, config, pkgs, ... }:

{
	imports =
		[ 
		./hardware-configuration.nix
		];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

	networking.hostName = "nixos-desktop";

	time.timeZone = "America/Vancouver";

	i18n.defaultLocale = "en_US.UTF-8";

	# graphics drivers / HW accel
	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};

	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		open = false;
		nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
	};

	# Bluetooth
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
	};
	services = {
		xserver = {
			enable = true; 
			displayManager.gdm.enable = true;
			layout = "us";
			xkbVariant = "";
            videoDrivers = ["nvidia"];
			xkbOptions = "escape:swapcaps";
		};
		gnome.gnome-keyring.enable = true;
		gvfs = {
			enable = true;
			package = lib.mkForce pkgs.gnome3.gvfs;
		};
		thermald.enable = true;
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
        shell = pkgs.fish;
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
