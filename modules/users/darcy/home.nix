{ inputs, ... }:
{
  flake.nixosModules.darcy-home-manager =
    { pkgs, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.default ];

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
          settings = pkgs.lib.importTOML ./_dotfiles/starship.toml;
        };

        programs.neovim = {
          enable = true;
          viAlias = true;
          vimAlias = true;
        };

        programs.vscode = {
          enable = true;
        };

        home.stateVersion = "25.11";
        home.homeDirectory = "/home/darcy";
      };
    };
}
