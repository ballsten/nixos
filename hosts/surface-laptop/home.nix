{ config, pkgs, inputs, ... }:

{
  home.username = "ballsten";
  home.homeDirectory = "/home/ballsten";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    lazygit
  ];

  imports = [
    ../../homeManagerModules/features/git.nix
    ../../homeManagerModules/features/nixvim
    ../../homeManagerModules/features/bash.nix
    ../../homeManagerModules/features/hyprland
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
