{ config, pkgs, ... }:

{
  programs.fuzzel = {
    enable = false;
    settings = {
      colors = {
	background = "070707ff";
	text = "e8e7d7ff";
	border = "CFCFCFff";
      };

      border = {
	width = 3;
	radius = 0;
      };
    };
  };
}
