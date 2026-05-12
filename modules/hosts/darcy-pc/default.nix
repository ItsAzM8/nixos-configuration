{ inputs, self, ... }:
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
        nixosModules.darcy-pc-hardware-configuration
        nixosModules.darcy-module
        nixosModules.dyllan-module
      ];

      nix = {
        settings = {
          trusted-users = [ "darcy" ];
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };

      nixpkgs = {
        config = {
          allowUnfree = true;
        };
      };

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        kernelPackages = pkgs.linuxPackages_6_18;
      };

      networking = {
        hostName = "darcy-pc";
        networkmanager.enable = true;
        firewall.allowedTCPPorts = [ 8096 ];
      };

      hardware = {
        bluetooth.enable = true;
        graphics.enable = true;
        graphics.enable32Bit = true;
        keyboard.qmk.enable = true;
        bluetooth.powerOnBoot = true;
        xone.enable = true;
      };

      services =
        let
          jellyfinGroup = "jellyfin";
        in
        {
          fwupd.enable = true;
          desktopManager.plasma6.enable = true;
          udev.packages = [ pkgs.via ];

          displayManager = {
            defaultSession = "plasma";

            sddm = {
              enable = true;
              wayland.enable = true;
            };
          };

          pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
          };

          seerr.enable = false;
          prowlarr.enable = false;
          flaresolverr.enable = false;

          jellyfin = {
            enable = true;
            group = jellyfinGroup;
          };

          radarr = {
            enable = true;
            group = jellyfinGroup;
          };

          sonarr = {
            enable = true;
            group = jellyfinGroup;
          };

          deluge = {
            enable = true;
            web.enable = true;
            group = jellyfinGroup;
          };

        };

      programs = {
        nix-ld.enable = true;
        fish.enable = true;
        firefox.enable = true;
        xwayland.enable = true;

        nh = {
          enable = true;
          clean.enable = true;
        };

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

        direnv = {
          enable = true;
          settings = {
            log_filter = "^$";
          };
        };
      };

      security = {
        rtkit.enable = true;
      };

      environment = {
        systemPackages = with pkgs; [
          vulkan-tools
          kdePackages.kde-gtk-config
          kdePackages.kcalc
          signal-desktop
          corectrl
          wget
          vscode
          git
          rar
          via
          discord
          libreoffice
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

      time.timeZone = "Australia/Adelaide";
      system.stateVersion = "26.05";
    };

}
