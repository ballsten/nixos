{inputs}: let
  helperLib = (import ./default.nix) {inherit inputs;};
  home-manager = inputs.home-manager;
  nixvim = inputs.nixvim;
  outputs = inputs.self.outputs;
in rec {

  # helper functions

  # buildables
  mkSystem = config: home:
    inputs.nixpkgs.lib.nixosSystem {
      
      specialArgs = {
        inherit inputs outputs helperLib;
      };
      modules = [
        config
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            nixvim.homeManagerModules.nixvim
          ];
          home-manager.users.ballsten = import home;
        }
      ];
    };
}
