{ inputs, ...}: {

  imports = [
    ./options.nix
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    globals.mapleader = " ";
  };
}
