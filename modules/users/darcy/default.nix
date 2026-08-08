{ self, ... }:
{
  flake.nixosModules.darcy-module =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.shellConfig
        self.nixosModules.darcyPcPackages
      ];

      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
      };

      programs.vscode.enable = true;

      users.users.darcy = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "gamemode"
        ];
      };
    };
}
