# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # tmp on tmpfs
  boot.tmp.useTmpfs = true;

  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "nixos-rpi"; # Define your hostname.
  #networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.interfaces."wlan0".useDHCP =
    let file = ../../local/wireless.nix;
      exists = builtins.pathExists file;
    in
      if exists then true else false;
  networking.wireless =
    let file = ../../local/wireless.nix;
      exists = builtins.pathExists file;
    in
      if exists then (import file) else {};

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "caps:escape";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mq = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    tree
    file
    which
    inetutils
    mtr
    sysstat
    htop
    ncdu
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  users.users."mq".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC209WbwtCosgO6EZJzlft1mpXsfhBmnb7MHgs6bkWCzbxxcXEbosY+7RzRyUOawjL6AjYBxsCCnXV2p9CZWGtyYHW/U7tAfHhUjgR2rr5uhpMBMy+BWN/4vA0rQI7yb6NANqpzt1ouidbUdGpDBgN6eY3fwoLP66bTVTHgjbadJn/D3fxvLKKfFgllzc700hhsRtVKeU8qA2hAa8KAoHIcFAol00RiNy72WoVm/NrGMpiK46uN9IFxCtwCKXRCYcZ2hnm1jeapB4yZceCOnL4tZIUTehtylOaoDj6zhA6fJo/M4r7zVWPm2FKPUAhW8zAU5SA2Hjz1d75yBDbaZ8Lt"
  ];

  services.ntp.enable = true;

  services.syncthing = {
    enable = true;
    user = "mq";
    dataDir = "/disks/data/syncthing";
  };

  services.transmission = { 
    enable = true;
    #Open firewall for RPC
    openRPCPort = true;
    # specify rpc-username and rpc-password in json
    credentialsFile = "/var/lib/secrets/transmission/settings.json";
    home = "/var/lib/transmission";
    settings = {
      rpc-authentication-required = true;
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1,10.0.0.10";
    };
  };
  # transmission bind mounts
  fileSystems."/var/lib/transmission/.incomplete" = {
    depends = [
        "/disks/data" 
    ];
    device = "/disks/data/torrent_incomplete";
    fsType = "none";
    options = [
      "bind"
    ];
  };
  fileSystems."/var/lib/transmission/Downloads/dataa" = {
    depends = [
        "/disks/dataa" 
    ];
    device = "/disks/dataa/torrent";
    fsType = "none";
    options = [
      "bind"
    ];
  };
  fileSystems."/var/lib/transmission/Downloads/datab" = {
    depends = [
        "/disks/datab" 
    ];
    device = "/disks/datab/torrent";
    fsType = "none";
    options = [
      "bind"
    ];
  };
  fileSystems."/var/lib/transmission/Downloads/datac" = {
    depends = [
        "/disks/datac" 
    ];
    device = "/disks/datac/torrent";
    fsType = "none";
    options = [
      "bind"
    ];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 51413 ];
  networking.firewall.allowedUDPPorts = [ 51413 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall.allowPing = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

