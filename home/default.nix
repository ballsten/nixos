{ config, pkgs, inputs, ... }:

{
  home.username = "ballsten";
  home.homeDirectory = "/home/ballsten";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    git
    lazygit
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Andrew Theaker";
    userEmail = "andrew@theaker.name";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      lg = "lazygit";
    };
  };

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
