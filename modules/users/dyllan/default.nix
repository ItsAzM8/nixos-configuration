{ self, ... }:
{
  flake.nixosModules.dyllan-module =
    { ... }:
    {
      imports = [
        self.nixosModules.dyllan-home-manager
      ];
      users.users.dyllan.isNormalUser = true;
    };
}
