{
  pkgs,
  ...
}:

{
  languages.nix = {
    enable = true;
    lsp.package = pkgs.nil;
  };

  packages = with pkgs; [
    nixfmt-tree
  ];

  git-hooks.hooks = {
    nixfmt.enable = true;
  };

}
