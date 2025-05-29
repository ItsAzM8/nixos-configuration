{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mangohud # Vulkan / OpenGL Overlay for System Monitoring and FPS
    protonup # Install / Manage Proton-GE & Luxtorpeda for Steam  
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs.steam.override {
      extraPkgs = (pkgs: with pkgs; [
        gamemode
      ]);
    };
  };
  programs.gamemode.enable = true;
  programs.gamemode.settings = {
    general.renice = 20;
  };

  environment.sessionVariables = {
   STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
