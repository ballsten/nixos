# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

