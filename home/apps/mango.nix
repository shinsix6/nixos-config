{ config, pkgs, inputs, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/nixos-config/home/apps/dotfiles";
in 
{
  xdg.configFile."mango".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/mango";
}
