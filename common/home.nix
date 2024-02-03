{ config, pkgs, ... }@inputs:

{
  home.username = "mq";
  home.homeDirectory = "/home/mq";

  # User profile packages
  home.packages = with pkgs; [
    home-manager

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

    httpie
    openssl

    ansible
    sshpass

    devbox

    # devel
    gcc

    # vim stuff
    fzf
    xclip
    ripgrep

    # langs
    (python3.withPackages (ps: with ps; [
      jedi python-lsp-server
      requests
    ])) poetry
    rustc cargo rust-analyzer # rust stuff
    nodejs_21
    nodePackages.typescript-language-server # ts lsp
    nodePackages.svelte-language-server # svelte lsp
    tailwindcss-language-server # tailwindcss lsp

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
    tcpdump
    tcpflow

    # nix stiff
    manix

    # comms
    skypeforlinux
    teams-for-linux
    thunderbird

    # passwords
    keepassxc
    enpass

    # multimedia
    gimp
    audacity
    vlc
    yt-dlp
    ffmpeg

    # docs
    libreoffice

    # haxy stuff
    wireshark
    #ghidra
    dsniff

    # tools
    onionshare-gui

    # rss
    rssguard

    # wallets
    sparrow

    # torrent
    transmission
    transmission-remote-gtk

    # games
    prismlauncher

    # gnome
    gnomeExtensions.tray-icons-reloaded
  ];

  # git
  programs.git = {
    enable = true;
    #userName = "";
    #userEmail = "";
  };
  # urxvt fix
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
  # urxvt terminal
  programs.urxvt = {
    enable = true;
    keybindings = {
     "Shift-Control-C" = "eval:selection_to_clipboard";
     "Shift-Control-V" = "eval:paste_clipboard";
   };
   fonts = [
     "xft:Liberation Mono:size=10"
     "xft:DejaVu Sans Mono for Powerline:size=10"
   ];
   iso14755 = false;
   extraConfig = {
     "geometry" = "100x24";
     "metaSendsEscape" = true; "vt100.metaSendsEscape" = true;
     #"foreground" = "white";
     #"background" = "black";
     "background" = "#000000";
     "foreground" = "#B2B2B2";
     "color0" =  "#000000";
     "color8" =  "#686868";
     "color1" =  "#B21818";
     "color9" =  "#FF5454";
     "color2" =  "#18B218";
     "color10" = "#54FF54";
     "color3" =  "#B26818";
     "color11" = "#FFFF54";
     "color4" =  "#1818B2";
     "color12" = "#5454FF";
     "color5" =  "#B218B2";
     "color13" = "#FF54FF";
     "color6" =  "#18B2B2";
     "color14" = "#54FFFF";
     "color7" =  "#B2B2B2";
     "color15" = "#FFFFFF";
   };
  };
  # neovim
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraLuaConfig = import ./home/neovim/init.lua.nix;
    plugins = with pkgs.vimPlugins; [
      vim-airline                           # nice statusbar
      telescope-nvim                        # fuzzy search
      plenary-nvim
      (nvim-treesitter.withPlugins (p: [    # nice syntax highlight
        p.c p.cpp p.python p.rust p.javascript p.typescript p.svelte
        p.nix
      ]))
      vim-fugitive                          # git
      vim-slime                             # interactive repl

      # LSP section
      lsp-zero-nvim
      nvim-lspconfig
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      luasnip
      friendly-snippets
      cmp-buffer

      # copilot
      copilot-lua
    ];
  };
  # bash
  programs.bash = {
    enable = true;
    bashrcExtra =
    let file = ../local/bashrc.nix;
      exists = builtins.pathExists file;
      common = import ./home/bash/bashrc.nix;
    in
      if exists then common + (import file) else common;
  };
  # direnv - persistent envs
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  programs.chromium.enable = true;
  programs.zellij = {
    enable = true;
    settings = {
      keybinds = {
        unbind = "Ctrl b";
        normal = {
          "bind \"Ctrl a\"" = {
            SwitchToMode = "tmux";
          };
        };
      };
    };
  };

  # syncthing
  services.syncthing.enable = true;

  # GNOME settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Shift><Alt>c" ];
      maximize=["<Shift><Alt>Up"];
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
      command = "urxvt";
      name = "Terminal";
    };
    # laptop touchpad tap to click
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
      natural-scroll = false;
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
    "org/gnome/desktop/input-sources" = {
      sources = [ [ "xkb" "us" ] ];
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
