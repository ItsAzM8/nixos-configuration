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
        version = "25.1";
        src = pkgs.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "mesa";
          repo = "mesa";
          rev = "${version}";
          hash = "sha256-sLdrB9Nfi0XJKZi1OORNXQUO9FeZ+WhbPJw+LJpgKSw=";
        };
        patches = [
          ./opencl.patch
        ];
      };

      bblauncher = pkgs.stdenv.mkDerivation rec {
        pname = "bblauncher";
        version = "8.6";

        src = pkgs.fetchFromGitHub rec {
          owner = "rainmakerv3";
          repo = "BB_Launcher";
          tag = "Release${version}";
          hash = "sha256-Z2g/zxLtN9C63xSiuxcXHAV5SEYs8Ur8psotj0xIJFU=";
        };

        buildInputs = with pkgs; [
          qt6.qtbase
        ];

        nativeBuildInputs = with pkgs; [
          cmake
          qt6.wrapQtAppsHook
        ];

      };
    })
  ];
}
