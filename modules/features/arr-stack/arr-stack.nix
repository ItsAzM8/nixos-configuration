{ ... }:
{
  flake.nixosModules.arrStack =
    {
      config,
      ...
    }:
    {
      services.jellyfin = {
        enable = true;
      };

      services.seerr = {
        enable = true;
      };

      services.radarr = {
        enable = true;
        group = config.services.jellyfin.group;
        user = config.services.jellyfin.user;
      };

      services.sonarr = {
        enable = true;
        group = config.services.jellyfin.group;
        user = config.services.jellyfin.user;
      };

      services.prowlarr = {
        enable = true;
      };

      services.sabnzbd = {
        enable = true;
        group = config.services.jellyfin.group;
        user = config.services.jellyfin.user;
      };

      services.deluge = {
        enable = true;
        group = config.services.jellyfin.group;
        user = config.services.jellyfin.user;
        web.enable = true;
      };

      services.homepage-dashboard = {
        enable = true;
        bookmarks = [
          {
            Arr = [
              { Jellyseerr = [ { href = "http://localhost:5055/"; } ]; }
              { Jellyfin = [ { href = "http://localhost:8096"; } ]; }
              { Sonarr = [ { href = "http://localhost:8989"; } ]; }
              { Radarr = [ { href = "http://localhost:7878"; } ]; }
              { Prowlarr = [ { href = "http://localhost:9696"; } ]; }
              { Deluge = [ { href = "http://localhost:8112"; } ]; }
            ];
          }
        ];
      };
    };
}
