{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kde-gtk-config
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    discover
    elisa
    khelpcenter
    gwenview
    kinfocenter
    kwallet
    kmenuedit
    okular
  ];

  qt = {
    enable = true;
    platformTheme = "kde";
  };

  services.desktopManager.plasma6.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  
  services.displayManager = {
    defaultSession = "plasma";

    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
