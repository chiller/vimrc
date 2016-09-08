{ config, lib, pkgs, ... }:
{
 boot.loader.grub.device = "/dev/sda";
 boot.loader.grub.fsIdentifier = "provided";
 fileSystems."/".device = "/dev/disk/by-label/nixos";
 virtualisation.virtualbox.guest.enable = true;
 services.xserver = {
   enable = true;
   videoDrivers = [ "virtualbox" ];
   displayManager.slim.enable = true;
   windowManager.i3.enable = true;
   synaptics.enable = true;
 };
 users.extraUsers.demo = { 
   isNormalUser = true;
   description = "Demo user account";
   extraGroups = [ "wheel"  "vboxsf" ];
   password = "demo";
   uid = 1000;
 };
}
