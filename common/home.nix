{ config, pkgs, ... }@inputs:

{
  home.username = "mq";
  home.homeDirectory = "/home/mq";

  # User profile packages
  home.packages = with pkgs; [
    neofetch
    nnn # terminal file manager
    tmux
    htop
    neofetch
    file
    which
    tree
    gnused
    gnutar
    gawk
    gnupg
    lsof
    ncdu

    # langs
    python3

    # terminals
    gnome-console

    # archives
    zip
    xz
    unzip
    p7zip

    # networking
    dnsutils  # `dig` + `nslookup`
    socat # openbsd-netcat alternative
    nmap
    ipcalc  # it is a calculator for the IPv4/v6 addresses
    openvpn

    # nix stiff
    manix

    # comms
    skypeforlinux
    teams-for-linux

    # passwords
    keepassxc
    enpass

    # multimedia
    gimp
    audacity

    # video
    vlc

    # docs
    libreoffice

    # haxy stuff
    wireshark
    #ghidra

    # tools
    onionshare-gui

    # rss
    rssguard

    # wallets
    sparrow

    # torrent
    transmission

    gnomeExtensions.tray-icons-reloaded
  ];

  # git
  programs.git = {
    enable = true;
    #userName = "";
    #userEmail = "";
  };
  # alacritty terminal
  programs.alacritty = {
    enable = true;
  };
  # neovim
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      set number relativenumber
    '';
  };
  # bash
  programs.bash = {
    enable = true;
    bashrcExtra =
    let file = ../local/bashrc.nix;
      exists = builtins.pathExists file;
    in
      if exists then (import file) else "";
  };
  # vscode
  programs.vscode.enable = true;

  # syncthing
  services.syncthing.enable = true;

  # GNOME settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Shift><Alt>c" ];
      move-to-workspace-1 = ["<Shift><Alt>1"];
      move-to-workspace-2 = ["<Shift><Alt>2"];
      move-to-workspace-3 = ["<Shift><Alt>3"];
      move-to-workspace-4 = ["<Shift><Alt>4"];
      move-to-workspace-5 = ["<Shift><Alt>5"];
      move-to-workspace-6 = ["<Shift><Alt>6"];
      move-to-workspace-7 = ["<Shift><Alt>7"];
      move-to-workspace-8 = ["<Shift><Alt>8"];
      move-to-workspace-9 = ["<Shift><Alt>9"];
      switch-to-workspace-1 = ["<Alt>1"];
      switch-to-workspace-2 = ["<Alt>2"];
      switch-to-workspace-3 = ["<Alt>3"];
      switch-to-workspace-4 = ["<Alt>4"];
      switch-to-workspace-5 = ["<Alt>5"];
      switch-to-workspace-6 = ["<Alt>6"];
      switch-to-workspace-7 = ["<Alt>7"];
      switch-to-workspace-8 = ["<Alt>8"];
      switch-to-workspace-9 = ["<Alt>9"];
    };
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
      num-workspaces = 9;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
       custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
       search = ["<Alt>p"];
       www = ["<Control><Alt>b"];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Alt>Return";
      command = "kgx"; # gnome-console
      name = "Terminal";
    };
    # laptop touchpad tap to click
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/mutter" = {
      workspaces-only-on-primary = true;
      edge-tiling = true;
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "trayIconsReloaded@selfmade.pl"
      ];
    };
  };


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
