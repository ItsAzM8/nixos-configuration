{ ... }:
{
  flake.nixosModules.darcyPcPackages =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [ sops ];
    };
}
