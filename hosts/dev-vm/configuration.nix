# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
    sha256 = "156hc11bb6xiypj65q6gzkhw1gw31dwv6dfh6rnv20hgig1sbfld";
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      (import "${home-manager}/nixos")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dev-vm"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.ballsten = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    hashedPassword = "$y$j9T$j7sI.mImrVEDMwWnG/Bxc1$bZ6S4C5wk3k7FndCS3jqYjbLchT//APgBpeMwtm4Ph4";
  };

  # some home-manager configuration
  home-manager.users.ballsten = { pkgs, ... } : {
    home.packages = with pkgs; [
      neovim
      git
      lazygit
    ];

    programs.bash.enable = true;

    home.shellAliases = {
      lg = "lazygit";
    };

    home.stateVersion = "24.11";
  };

  # programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # TODO: disable firewall for now, probably need to do something better
  networking.firewall.enable = false;

  system.stateVersion = "24.11";

}

