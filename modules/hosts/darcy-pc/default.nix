{ inputs, self, ... }:
let
  sopsFile = ../../../secrets/secrets.yaml;
in
{

  flake.nixosConfigurations.darcy-pc = inputs.nixpkgs.lib.nixosSystem {
    modules = with self; [
      nixosModules.darcy-pc-module
    ];
  };

  flake.nixosModules.darcy-pc-module =
    { pkgs, config, ... }:
    {
      imports = with self; [
        nixosModules.base
        nixosModules.darcy-pc-hardware-configuration
        nixosModules.darcy-module
        nixosModules.dyllan-module

        features.arrStack
        features.openvpn

        inputs.sops-nix.nixosModules.default
      ];

      sops.defaultSopsFile = sopsFile;
      sops.defaultSopsFormat = "yaml";
      sops.age.keyFile = "/home/darcy/.config/sops/age/keys.txt";
      sops.secrets.pia_env = { };

      networking = {
        hostName = "darcy-pc";
        firewall.allowedTCPPorts = [ 8096 ];
      };

      hardware = {
        bluetooth.enable = true;
        keyboard.qmk.enable = true;
        bluetooth.powerOnBoot = true;
        xone.enable = true;
      };

      services = {
        desktopManager.plasma6.enable = true;
        udev.packages = [ pkgs.via ];

        displayManager = {
          defaultSession = "plasma";

          sddm = {
            enable = true;
            wayland.enable = true;
          };
        };
      };

      programs = {
        firefox.enable = true;
        xwayland.enable = true;

        steam = {
          enable = true;
          gamescopeSession.enable = true;
          package = pkgs.steam.override {
            extraPkgs = (
              pkgs: with pkgs; [
                gamemode
              ]
            );
          };
        };

        gamemode = {
          enable = true;
          settings.general.renice = 20;
        };

      };

      environment = {
        systemPackages = with pkgs; [
          vulkan-tools
          kdePackages.kde-gtk-config
          kdePackages.kcalc
          signal-desktop
          corectrl
          via
          discord
          libreoffice
          bottom
        ];

        plasma6.excludePackages = with pkgs.kdePackages; [
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

        sessionVariables = {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
        };
      };

      qt = {
        enable = true;
        platformTheme = "kde";
      };

      fonts = {
        packages = with pkgs; [
          nerd-fonts.hack
        ];
      };
    };

}
