{ inputs, ... }:
{
  flake.nixosModules.dyllan-home-manager =
    { pkgs, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.default ];

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "bak";

      home-manager.users.dyllan = {
        programs.vscode = {
          enable = true;
        };

        home.stateVersion = "26.05";
        home.homeDirectory = "/home/dyllan";
      };
    };
}
