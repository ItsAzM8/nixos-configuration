{ self, ... }:
{
  flake.nixosModules.darcy-module =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.darcy-home-manager
      ];

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
