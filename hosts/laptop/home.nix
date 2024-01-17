{ config, pkgs, ... }@inputs:

let common = import ../../common/home.nix { inherit config pkgs inputs; }; in
# update common with current
common // {

}
