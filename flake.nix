{
  description = "Configurations of Aylur";

  outputs =
    inputs@{
      self,
      home-manager,
      nixpkgs,
      solaar,
      nixos-unstable-small,
      ...
    }:
    {
      packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.callPackage ./ags {
        inherit inputs;
      };

      # nixpkgs.overlays = [
      #   (final: prev: {
      #     xdg-desktop-portal-hyprland =
      #       nixos-unstable-small.legacyPackages.${final.system}.xdg-desktop-portal-hyprland;
      #   })
      # ];
      # nixos config
      nixosConfigurations = {
        "nixos" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            asztal = self.packages.x86_64-linux.default;
          };
          modules = [
            ./nixos/nixos.nix
            home-manager.nixosModules.home-manager
            solaar.nixosModules.default
            { networking.hostName = "nixos"; }
          ];
        };
      };

      # macos hm config
      homeConfigurations = {
        "demeter" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            (
              { pkgs, ... }:
              {
                nix.package = pkgs.nix;
                home.username = "demeter";
                home.homeDirectory = "/Users/demeter";
                imports = [ ./macos/home.nix ];
              }
            )
          ];
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-unstable-small = {
      url = "github:NixOS/nixpkgs/nixos-unstable-small";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    solaar = {
      url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";

    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };
}
