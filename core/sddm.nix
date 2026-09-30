{ pkgs, inputs, ... }:

{
  imports = [inputs.silentSDDM.nixosModules.default];
  programs.silentSDDM = {
    enable = false;
    theme = "catppuccin-macchiato";
  };
}
