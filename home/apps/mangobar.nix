{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.mangobar.homeManagerModules.default ];

  services.mangobar = {
    enable = true;
    systemdTarget = "mango.target";
    settings = {
      modules-left = [ "workspaces"];
      modules-center = [ "window" ];
      modules-right = [ "cpu" "memory" "battery" "clock#time" ];
      height = 24.0;
    };
  };
}
