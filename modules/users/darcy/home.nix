{ inputs, self, ... }:
{
  flake.nixosModules.darcy-home-manager =
    { pkgs, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.default ];

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "bak";

      home-manager.users.darcy = {
        programs.fish.interactiveShellInit = ''
          set fish_greeting
        '';

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

        home.stateVersion = "26.05";
        home.homeDirectory = "/home/darcy";
      };
    };
}
