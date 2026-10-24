{ config, lib, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";

  configDirs = [
    "sway"
    "swaylock"
    "waybar"
    "mako"
    "fuzzel"
    "eww"
    "kitty"
    "fish"
    "nvim"
    "helix"
    "tmux"
    "zathura"
    "git"
  ];
in
{
  xdg.configFile = lib.genAttrs configDirs (name: { source = link "config/${name}"; });

  home.file = {
    "scripts".source = link "scripts";
    "wallpapers".source = link "wallpapers";
  };

  home.activation.tmuxPluginManager = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    tpm="$HOME/.tmux/plugins/tpm"
    [ -d "$tpm" ] || ${pkgs.git}/bin/git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm" || true
  '';

  home.stateVersion = "26.05";
}
