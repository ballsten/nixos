{ config, pkgs, inputs, ... }:

{
  home.username = "ballsten";
  home.homeDirectory = "/home/ballsten";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    lazygit
  ];

  programs.git = {
    enable = true;
    userName = "Andrew Theaker";
    userEmail = "andrew@theaker.name";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      lg = "lazygit";
    };
  };

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    globals.mapleader = " ";
    opts = {
      number = true;
      relativenumber = true;
      autoindent = true;
      expandtab = true;
      shiftwidth = 2;
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
