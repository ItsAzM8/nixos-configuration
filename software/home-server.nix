{ ... }:
{
    services = {

        jellyseerr.enable = true;
        prowlarr.enable = true;
        flaresolverr.enable = true;

        jellyfin.enable = true;
        jellyfin.group = "jellyfin";

        radarr.enable = true;
        radarr.group = "jellyfin";

        sonarr.enable = true;
        sonarr.group = "jellyfin";

        deluge = {
            enable = true;
            web.enable = true;
            group = "jellyfin";
        };
    };
}