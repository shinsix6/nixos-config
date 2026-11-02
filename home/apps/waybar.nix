{ config, pkgs, inputs, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/nixos-config/home/apps/dotfiles";
in
{
  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.system}.waybar.overrideAttrs(oldAttrs: { 
      mesonFlags = (oldAttrs.mesonFlags or[]) ++ ["-Dcava=disabled"]; 
    });
  };

  xdg.configFile."waybar".source = 
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/waybar";
}
