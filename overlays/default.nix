{ pkgs, lib, fetchFromGitHub, fetchFromGitLab, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      gamescope = super.gamescope.overrideAttrs rec {
        version = "15e0c638d16498f0fa00a13ce6f99559225c6584";
        src = pkgs.fetchFromGitHub {
          owner = "ValveSoftware";
          repo = "gamescope";
          rev = "${version}";
          fetchSubmodules = true;
          sha256 = "sha256-MZhIsnSp2uGMQds5zEhF8WZgGNHDGH+3A2TGjB6Vn10=";
        };
      };

      mesa = super.mesa.overrideAttrs rec {
        version = "25.1.1";
        src = pkgs.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "mesa";
          repo = "mesa";
          rev = "messuda-${version}";
          hash = "sha256-Vk5sE7D8XHDOtxq0ax2a3FmQFWp7IDP4Y510EpnKWo4=";
        };
        patches = [
          ./opencl.patch
        ];
      };
    })
  ];
}
