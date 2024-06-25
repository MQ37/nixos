{ config, lib, pkgs, ... }@inputs:

{
  nixpkgs.config.allowUnfree = true;
  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # tmp on tmpfs
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "50%";

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.extraHosts = let file = ../local/extraHosts.nix;
      exists = builtins.pathExists file;
    in
      if exists then (import file) else "";

  networking.nameservers = [ "127.0.0.1" "::1" ];
  networking.networkmanager.dns = "none";
  #networking.dhcpcd.extraConfig = "nohook resolv.conf";
  # DoH
  services.stubby = {
    enable = true;
    settings = pkgs.stubby.passthru.settingsExample // {
      upstream_recursive_servers = [{
        address_data = "1.1.1.1";
        tls_auth_name = "cloudflare-dns.com";
      } {
        address_data = "1.0.0.1";
        tls_auth_name = "cloudflare-dns.com";
      }];
    };
   };

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  #services.xserver.libinput.enable = true;
  services.libinput.enable = true;

  # fonts
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerdfonts
    powerline-fonts
    powerline-symbols
  ]; 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mq = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "kvm" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
    ];
  };

  # virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "mq" ];
  # libvirtd
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  # docker
  virtualisation.docker.enable = true;
  # podman
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = false;
    # Required for containers under podman-compose to be able to talk to each other.
    defaultNetwork.settings.dns_enabled = true;
  };

  # flatpak
  services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    tree
    file
    which
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

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22000 # syncthing
  ];
  networking.firewall.allowedUDPPorts = [
    22000 # syncthing quic
    21027 # syncthing discovery
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    DBX_CONTAINER_MANAGER = "podman";
  };
}
