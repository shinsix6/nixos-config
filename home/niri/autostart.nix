{ lib, pkgs, ... }:

{
  programs.niri.settings.spawn-at-startup = [
    { command = ["noctalia"]; }
    # { command = ["swww-daemon"]; }
    # { command = ["swww" "img" "~/wallpapers/wallbr.png"]; }
  ];
}
