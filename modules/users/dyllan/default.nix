{ ... }:
{
  flake.nixosModules.dyllan-module =
    { ... }:
    {
      users.users.dyllan.isNormalUser = true;
    };
}
