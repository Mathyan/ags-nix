let
  name = "Mathyan";
in
{
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      github.user = name;
      push.autoSetupRemote = true;
    };
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    services.ssh-agent.enable = true;
    userEmail = "matijan.cvitanovic@outlook.com";
    userName = name;
  };
}
