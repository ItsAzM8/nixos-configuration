{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=staging-26.05";
  };

  outputs = { self, nixpkgs }: {

  };
}
