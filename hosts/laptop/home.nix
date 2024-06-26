{ config
  , pkgs
  , pkgs-unstable
  , ...
}@inputs:

let common = import ../../common/home.nix { inherit config pkgs pkgs-unstable inputs; }; in
# update common with current
common // {
  dconf.settings = common.dconf.settings // {
    "org/gnome/shell" = common.dconf.settings."org/gnome/shell" // {
      enabled-extensions = common.dconf.settings."org/gnome/shell".enabled-extensions ++ [
        "thinkpad-battery-threshold@marcosdalvarez.org"
      ];
    };
  };

  home = common.home // {
    packages = common.home.packages ++ (with pkgs; [
      gnomeExtensions.thinkpad-battery-threshold
    ]);
  };
}
