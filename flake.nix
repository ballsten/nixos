{
  description = "A flake for mangaing my various system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixos-wsl, nixvim, ... }@inputs: let
    helperLib = import ./lib/default.nix {inherit inputs;};
  in
  {
    nixosConfigurations = {
      dev-vm = helperLib.mkSystem ./hosts/dev-vm/configuration.nix ./hosts/dev-vm/home.nix;
      surface-laptop = helperLib.mkSystem ./hosts/surface-laptop/configuration.nix /hosts/surface-laptop/home.nix;

      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          nixos-wsl.nixosModules.wsl
          ./hosts/wsl/configuration.nix

	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.sharedModules = [
	      nixvim.homeManagerModules.nixvim
	    ];
	    home-manager.users.ballsten = import ./home;
	  }
        ];
      };
    };
  };
}
