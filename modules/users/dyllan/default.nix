{
  flake.nixosModules.dyllan-module =
    { ... }:
    {
      users.users.dyllan.isNormalUser = true;
      programs.vscode.enable = true;
    };
}
