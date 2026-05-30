{ lib, pkgs, ... }:

{
  programs.niri.settings.spawn-at-startup = [
    { command = ["waybar"]; }
    { command = ["swww-daemon"]; }
    { command = ["swww" "img" "~/wallpapers/wallbr.png"]; }
  ];
}
