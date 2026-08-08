{
  flake.nixosModules.shellConfig =
    { pkgs, ... }:
    {
      programs.fish = {
        interactiveShellInit = ''
          set fish_greeting
        '';
      };

      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        settings = pkgs.lib.importTOML ./_dotfiles/starship.toml;
      };
    };
}
