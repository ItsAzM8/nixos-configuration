{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  packages = with pkgs; [
    nixfmt-tree
  ];

  scripts = {
    nixfmt = {
      description = "Runs treefmt over all .nix files in the repo, excluding devenv.nix.";
      packages =

        with pkgs; [

          nixfmt-tree
        ];
      exec = "treefmt modules/ flake.nix";
    };
  };

  git-hooks.hooks = {
    nixfmt.enable = true;
  };

}
