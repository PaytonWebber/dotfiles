# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ lib, config, pkgs, ... }:

{
	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		./wireguard.nix
		<home-manager/nixos>
	];

	home-manager = {
	  useGlobalPkgs = true;
	  useUserPackages = true;
	  backupFileExtension = "backup";
	  users.payton = import ./home.nix;
	};

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

	# for firmware updates
	services.fwupd.enable = true;

	# fingerprint scanner
	services.fprintd.enable = true;
	services.fprintd.tod.enable = true;
	services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
	security.pam.services.login.fprintAuth = lib.mkForce true;
	security.pam.services.sudo.fprintAuth = true;
	security.pam.services.gdm.fprintAuth = true;
	security.pam.services.hyprlock = {
  text = ''
	    auth    [success=1 default=ignore] pam_fprintd.so max_tries=5
	    auth    required                   pam_unix.so
	  '';
	};


	# 1password
	programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "payton" ];
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
        services.xserver.xkb.options = "caps:swapescape";

	services = {
		xserver = {
			enable = true;
			displayManager.gdm.enable = true;
			xkb = {
				layout = "us";
				variant = "";
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
	
	xdg = {
	  portal = {
	    enable = true;
	    extraPortals = with pkgs; [
		    xdg-desktop-portal-wlr
		    xdg-desktop-portal-gtk
	  	];
  	};
	};
	
	programs = {
		hyprland.enable = true;
		waybar.enable = true;
		fish.enable = true;
		thunar.enable = true;
		light.enable = true;
	};

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
			# hyprland
			hyprlock
			hypridle
			libnotify
			swww
			eww
			dunst
			light

			# Applications
			firefox
			obsidian
			qutebrowser
			discord
			zathura
			fuzzel

			# Misc
			bat
			yazi
			hyprshot
			claude-code
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

	environment.sessionVariables.NIXOS_OZONE_WL = "1";
	environment.systemPackages = with pkgs; [

	  (pkgs.wrapOBS {
	    plugins = with pkgs.obs-studio-plugins; [
	      wlrobs
	      obs-backgroundremoval
	      obs-pipewire-audio-capture
	      obs-vaapi #optional AMD hardware acceleration
	      obs-gstreamer
	      obs-vkcapture
	    ];
	  })
	  mpv

		# Util Functions
		wireguard-tools
		magic-wormhole
		unzip
		wget
		curl
		wireplumber
		wl-clipboard
		fzf
		fd
		ripgrep
		pyenv
		zoxide
		acpi
		delta

		# Development Environment
		gh
		go
		gdb
		git
		eza
		clang
		neovim
		helix
		fish
		kitty
		gnumake
		nodejs_20
		jq
		socat
		cmake
		pkg-config
		clang-tools
		lldb_21

		# TUI Utils
		fastfetch
		tmux
		htop
		btop
		starship
		rose-pine-hyprcursor

		slack

	];

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];
	
	system.stateVersion = "25.05";
}
