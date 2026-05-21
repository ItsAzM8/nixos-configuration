{
  ...
}:
{
  flake.nixosModules.gaming =
    {
      pkgs,
      ...
    }:
    {
      programs.steam.enable = true;
      programs.steam.gamescopeSession.enable = true;

      programs.gamemode.enable = true;
      programs.gamemode.settings.general.renice = 20;

      environment.systemPackages = with pkgs; [
        mangohud
        protonup-ng
      ];

      environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      };
    };
}
