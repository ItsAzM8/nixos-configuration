{ ... }: {
  mesa = super.mesa.overrideAttrs rec {
    version = "25.1.1";
    src = pkgs.fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "mesa";
      repo = "mesa";
      rev = "mesa-${version}";
      hash = "sha256-Vk5sE7D8XHDOtxq0ax2a3FmQFWp7IDP4Y510EpnKWo4=";
    };
    patches = [
      ./opencl.patch
    ];
  };
}