{
  pkgs,
  lib,
  ...
}:
{
  xdg = {
    #configFile.nvim.source = ../nvim;
    desktopEntries."nvim" = lib.mkIf pkgs.stdenv.isLinux {
      name = "NeoVim";
      comment = "Edit text files";
      icon = "nvim";
      exec = "wezterm start -- ${pkgs.neovim}/bin/nvim %F";
      categories = [ "TerminalEmulator" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
  };

  home.sessionVariables = {
    EDITOR = "\"nvim\"";
    VISUAL = "\"nvim\"";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    withRuby = true;
    withNodeJs = true;
    withPython3 = true;
    extraPython3Packages =
      ps: with ps; [
        pip
        pynvim
        unidecode
        black
        isort
      ];
    extraPackages = with pkgs; [
      nixfmt-rfc-style
      nodePackages.prettier
      nodePackages.sql-formatter
      python3
      python312Packages.pip
      fish
      git
      gcc
      gnumake
      unzip
      wget
      curl
      tree-sitter
      ripgrep
      fd
      fzf
      cargo

      nil
      lua-language-server
      stylua
      alejandra
      ruff
      python312Packages.python-lsp-ruff
      lua
      luajitPackages.luarocks
      lemminx
    ];
  };
}
