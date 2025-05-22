{ pkgs, lib, fetchFromGitHub, fetchFromGitLab, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      
      imports = [
        ./gamescope.nix
        ./mesa.nix
      ];

    })
  ];
}
