{
 description = "earth (pc) nix flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
  };
  outputs = { self, nixpkgs, ... } @inputs: {
    nixosConfigurations.earth = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ 
        ./configuration.nix
      ];
    };
  };
}
