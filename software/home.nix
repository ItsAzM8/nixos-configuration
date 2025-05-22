{ self, pkgs, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";

  home-manager.users.darcy = {

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = pkgs.lib.importTOML ../dotfiles/starship.toml;
    };
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };

    home.stateVersion = "25.05";
    home.homeDirectory = "/home/darcy";
  };
}
