{ pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "framework";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  nixpkgs.config.allowUnfree = true;
  nix = {
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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services = {
    fwupd.enable = true;
    fprintd.enable = true;
    openssh.enable = true;
    tailscale.enable = true;
    mullvad-vpn.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };
  security.rtkit.enable = true;
  security.pam.services.swaylock = { };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    fish.enable = true;
    dconf.enable = true;
    # Lets prebuilt binaries (rustup toolchains, Mason LSPs, npm packages) run.
    nix-ld.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  users.users.payton = {
    isNormalUser = true;
    description = "Payton Webber";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "dialout" ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  environment.systemPackages = with pkgs; [
    # AI
    claude-code

    # Sway desktop
    swayidle
    swaylock
    waybar
    mako
    fuzzel
    eww
    autotiling
    cliphist
    wl-clipboard
    grim
    slurp
    libnotify
    brightnessctl
    playerctl
    pulseaudio # pactl, used by ~/scripts/volume.sh
    udiskie
    nautilus

    # Languages and toolchains
    rustup
    go
    zig
    nodejs
    bun
    pnpm
    typescript
    typescript-language-server
    uv
    python3

    # C/C++ and debugging
    gcc
    clang
    clang-tools
    lldb
    gdb
    cmake
    gnumake
    meson
    ninja
    pkg-config
    openssl
    zlib

    # Embedded
    gcc-arm-embedded
    espflash
    android-tools

    # Editors and terminal
    neovim
    helix
    kitty
    tmux
    tree-sitter

    # CLI utilities
    git
    gh
    delta
    jq
    ripgrep
    fd
    fzf
    bat
    eza
    zoxide
    starship
    yazi
    btop
    htop
    fastfetch
    tree
    unzip
    wget
    curl
    socat
    whois
    nmap
    gnupg
    wireguard-tools
    magic-wormhole
    yt-dlp

    # Containers and cloud
    dive
    podman-tui
    podman-compose
    doctl
    cloudflared
    packer

    # Applications
    firefox
    chromium
    slack
    discord
    obsidian
    zathura
    mpv
    obs-studio
    libreoffice-fresh
    hunspell
    hunspellDicts.en-ca-large
    remmina
  ];

  system.stateVersion = "26.05";
}
