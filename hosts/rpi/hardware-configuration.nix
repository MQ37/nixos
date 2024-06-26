# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  #boot.initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
  boot.initrd.availableKernelModules = [ "xhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  #boot.kernelParams = [
  #  "boot.shell_on_fail"
  #];

  #boot.initrd.luks.devices = {
  #  data = {
  #    device = "/dev/disk/by-uuid/47c51a19-c455-4f2d-b00e-d4ed7e2e9e16";
  #    #keyFile = "/mnt-root/keystore/47c51a19.key";
  #    keyFile = "/sysroot/keystore/47c51a19.key";
  #    fallbackToPassword = true;
  #  };
  #};

  environment.etc."crypttab".text = ''
    data /dev/disk/by-uuid/47c51a19-c455-4f2d-b00e-d4ed7e2e9e16 /keystore/47c51a19.key
    dataa /dev/disk/by-uuid/ea544a6a-ae53-4f71-9339-6cb66e633640 /keystore/ea544a6a.key
    datab /dev/disk/by-uuid/1d71f8ac-83c8-4094-bcd2-478751d3c597 /keystore/1d71f8ac.key
    datac /dev/disk/by-uuid/59468fec-9949-4db9-a4db-6453186bd554 /keystore/59468fec.key
  '';

  fileSystems."/" =
    { 
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  fileSystems."/disks/data" =
    {
      depends = [ "/" ];
      device = "/dev/mapper/data";
    };
  fileSystems."/disks/dataa" =
    {
      depends = [ "/" ];
      device = "/dev/mapper/dataa";
    };
  fileSystems."/disks/datab" =
    {
      depends = [ "/" ];
      device = "/dev/mapper/datab";
    };
  fileSystems."/disks/datac" =
    {
      depends = [ "/" ];
      device = "/dev/mapper/datac";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.end0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
