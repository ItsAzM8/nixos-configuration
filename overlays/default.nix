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
        version = "25.2.0-devel";
        src = pkgs.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "DadSchoorse";
          repo = "mesa";
          rev = "radv-float8-hack3";
          hash = "sha256-2ZZZpZkCDey9hvrV3++NlDVrMNMJg8PBWJk43dh33xo=";
        };
        patches = [
          ./opencl.patch
        ];
        postPatch =
        let 
          rustc-hash = self.fetchCrate { 
            pname = "rustc-hash";
            version = "2.1.1";
            hash = "sha256-3rQidUAExJ19STn7RtKNIpZrQUne2VVH7B1IO5UY91k=";
          };
        in super.mesa.postPatch + ''
          cp -R --no-preserve=mode,ownership ${rustc-hash} subprojects/${rustc-hash.pname}-${rustc-hash.version}
          cp -R subprojects/packagefiles/${rustc-hash.pname}/* subprojects/${rustc-hash.pname}-${rustc-hash.version}/
        '';
      };

      directx-headers = super.directx-headers.overrideAttrs rec {
        src = pkgs.fetchFromGitHub {
          owner = "microsoft";
          repo = "DirectX-Headers";
          rev = "v1.614.1";
          hash = "sha256-CDmzKdV40EExLpOHPAUnytqG9x1+IGW4AZldfYs5YJk=";
        };
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
