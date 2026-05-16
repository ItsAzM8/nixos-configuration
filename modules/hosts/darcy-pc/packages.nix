{ ... }:
{
  flake.nixsoModules.darcyPcPackages =
    {
      pkgs,
    }:
    {
      environment.systemPackages = [ ];
    };
}
