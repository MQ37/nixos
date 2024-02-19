{ config
  , pkgs
  , pkgs-unstable
  , ...
}@inputs:

let common = import ../../common/home.nix { inherit config pkgs pkgs-unstable inputs; }; in
# update common with current
common // {

}
