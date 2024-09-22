{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enabling Steam with all required system settings
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Enable Steam Remote Play ports
    dedicatedServer.openFirewall = true; # Enable Source Dedicated Server ports
    localNetworkGameTransfers.openFirewall = true; # Enable Local Network Game Transfer ports
    gamescopeSession.enable = true; # Enable Gamescope session for Steam Deck-like experience
  };

  # Allow unfree packages necessary for Steam to function
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
    ];

  # Optional: Enable gamescope and other Steam-related packages
  programs.gamescope = {
    enable = true;
    capSysNice = true; # Enable real-time priority for Gamescope
  };

  # Optional: Enable support for Xbox controller USB dongle
  hardware.xone.enable = true;

  # Add steam-run for flexibility with proprietary games
  environment.systemPackages = with pkgs; [
    steam-run
    mangohud # Performance overlay tool
  ];

  # Optional: Auto-login to Steam on TTY1 with Gamescope
  # services.getty.autologinUser = "mathyan"; # Replace with your username

  environment.loginShellInit = ''
    [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
  '';
}
