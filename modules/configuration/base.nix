{ inputs, self, ... }:
{
  flake.nixosModules.base =
    { pkgs, ... }:
    {
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

      hardware = {
        graphics.enable = true;
        graphics.enable32Bit = true;
      };

      services = {
        fwupd.enable = true;

        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        };
      };

      programs = {
        fish.enable = true;

        nh = {
          enable = true;
          clean.enable = true;
        };

        direnv = {
          enable = true;
          settings = {
            log_filter = "^$";
          };
        };
      };

      environment.systemPackages = with pkgs; [
        git
        rar
        wget
      ];

      security.rtkit.enable = true;
      networking.networkmanager.enable = true;
      time.timeZone = "Australia/Adelaide";
      system.stateVersion = "25.11";
    };
}
