{
  description = "A flake for mangaing my various system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs: {

    nixosConfigurations.dev-vm = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/dev-vm/configuration.nix
      ];
    };

    nixosConfigurations.surface-laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/surface-laptop/configuration.nix
      ];
    };
  };
}
