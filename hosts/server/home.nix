{ config, pkgs, ... }@inputs:

{
  home.username = "mq";
  home.homeDirectory = "/home/mq";

  # Environment
  home.sessionVariables = {
    TERM = "xterm";
  };

  # User profile packages
  home.packages = with pkgs; [
    home-manager

    neofetch
    nnn # terminal file manager
    screen
    htop
    neofetch
    file
    which
    tree
    gnused
    gnutar
    gawk
    lsof
    ncdu

    httpie
    openssl

    # ssg
    zola

    # vim stuff
    fzf
    ripgrep

    # archives
    zip
    xz
    unzip
    p7zip

    # networking
    dnsutils  # `dig` + `nslookup`
    socat # openbsd-netcat alternative
    tcpdump
    tcpflow
  ];

  # git
  programs.git = {
    enable = true;
  };
  # readline
  programs.readline = {
    enable = true;
    extraConfig = ''
    # ctrl arrows
    "\e[1;5C": forward-word
    "\e[1;5D": backward-word
    "\eOc": forward-word
    "\eOd": backward-word

    # alt arrow
    "\e[1;3D": backward-word
    "\e[1;3C": forward-word
    "\e\e[D": backward-word
    "\e\e[C": forward-word

    ### ctrl+backspace
    "\C-h": backward-kill-word
    '';
  };
  # bash
  programs.bash = {
    enable = true;
    bashrcExtra =
    let file = ../local/bashrc.nix;
      exists = builtins.pathExists file;
    in
      if exists then "" + (import file) else "";
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
