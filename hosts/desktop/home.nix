{ config, pkgs, ... }@inputs:

let common = import ../../common/home.nix { inherit config pkgs inputs; }; in
# update common with current
common // {
  dconf.settings = common.dconf.settings // {
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };
  };
}
