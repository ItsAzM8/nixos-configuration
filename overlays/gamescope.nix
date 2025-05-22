{ ... }: {
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
}