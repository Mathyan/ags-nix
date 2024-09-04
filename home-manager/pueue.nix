{ config, pkgs, ... }:

let
  configFile = "${config.home.homeDirectory}/.config/pueue/pueue.yml";
in
{
  home.packages = [ pkgs.pueue ];

  systemd.user.services.pueued = {
    Unit = {
      Description = "Pueue Daemon - CLI process scheduler and manager";
    };

    Service = {
      Restart = "on-failure";
      ExecStart = "${pkgs.pueue}/bin/pueued -v -c ${configFile}";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
