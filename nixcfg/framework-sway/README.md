# Framework 13 (AMD) NixOS flake

Sway desktop on nixos-unstable, with Claude Code and the dev toolchain installed
system-wide. App configs in `~/dotfiles/config`, `scripts` and `wallpapers` are
symlinked into `$HOME` by Home Manager, so edits take effect without a rebuild.

## Install

1. Boot the NixOS installer, partition and mount to `/mnt`.
2. `nixos-generate-config --root /mnt`, then copy
   `/mnt/etc/nixos/hardware-configuration.nix` into this directory.
3. Clone this repo to `~/dotfiles` (Home Manager expects that path).
4. `git add hardware-configuration.nix` (flakes ignore untracked files).
5. `nixos-install --flake .#framework`, or later `sudo nixos-rebuild switch --flake .#framework`.

Set `system.stateVersion` / `home.stateVersion` to the release of the installer you used.

## After first login

- Restore `~/.ssh` (the git config signs commits with `~/.ssh/id_ed25519.pub`) and run `gh auth login`.
- Open tmux and press `prefix + I` to install plugins (TPM itself is cloned on activation).
- Run `rustup default stable`.
