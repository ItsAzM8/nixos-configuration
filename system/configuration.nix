{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vulkan-tools # Khronos official Vulkan Tools and Utilities
  ];

  nix.settings = {
    trusted-users = [ "darcy" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_6_15;
  };

  networking = {
    hostName = "darcy-pc";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 8096 ];
  };

  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
    keyboard.qmk.enable = true;
  };

  users.users.darcy = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "gamemode" ];
  };

  services.fwupd.enable = true;
  services.udev.packages = [ pkgs.via ];
  programs.fish.enable = true;

  time.timeZone = "Australia/Adelaide";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}