{
  pkgs,
  ...
}:

{
  languages.nix = {
    enable = true;
    lsp.package = pkgs.nil;
  };

  scripts = {
    nixfmt = {
      description = "Runs treefmt over all .nix files in the repo, excluding devenv.nix.";
      exec = "treefmt .";

      packages = with pkgs; [
        nixfmt-tree
      ];
    };

    nixbuild = {
      description = "Builds the NixOS configuration using `nh`.";
      exec = "nh os build --accept-flake-config";

      packages = with pkgs; [
        nh
      ];
    };

    nixswitch = {
      description = "Builds the NixOS configuration using `nh` and switches the system to it.";
      exec = "nh os switch --accept-flake-config";

      packages = with pkgs; [
        nh
      ];
    };
  };

  git-hooks.hooks = {
    nixfmt.enable = true;
  };

}
