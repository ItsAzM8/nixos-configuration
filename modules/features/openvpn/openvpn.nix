{ ... }:
let
  caCrt = builtins.readFile ./ca.crt;
in

{
  flake.nixosModules.openvpn = {
    services.openvpn.servers = {
      pia = {
        autoStart = true;
        # Note that this is bad security practise, because the details
        # will be available in the nix store for everyone to see.
        # https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes
        authUserPass = "/run/secrets/pia_env";
        # authUserPass = "./";
        # Most of these options came from the OVPN file from the generator
        config = ''
          client
          dev tun
          proto udp
          remote 173.244.62.73 1198
          resolv-retry infinite
          nobind
          persist-key
          persist-tun
          cipher aes-128-cbc
          auth sha1
          tls-client
          remote-cert-tls server

          auth-user-pass
          compress
          verb 1
          reneg-sec 0

          <ca>
          ${caCrt}
          </ca>

          disable-occ
        '';
      };
    };
  };
}
