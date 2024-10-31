{ pkgs, ... }:
{
  imports = [
    ./modules/packages.nix
    ./scripts/blocks.nix
    ./scripts/nx-switch.nix
    ./scripts/vault.nix
  ];

  packages = with pkgs; {
    linux = [
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      spotify
      # gnome-secrets
      fragments
      figma-linux
      # yabridge
      # yabridgectl
      # wine-staging
      nodejs
      betterdiscordctl
      discord
      gh
      pueue
      jetbrains-toolbox
      jdk
      zed-editor
      mangohud
      lshw-gui
      ente-auth
    ];
    cli = [
      bat
      eza
      fd
      ripgrep
      fzf
      lazydocker
      lazygit
    ];
  };
}
