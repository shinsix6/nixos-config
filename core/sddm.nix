{ pkgs, inputs, ... }:

{
  imports = [inputs.silentSDDM.nixosModules.default];
  programs.silentSDDM = {
    enable = true;
    theme = "catppuccin-macchiato";
  };
}
