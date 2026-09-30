{ config, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      colors = {
	background = "002147ff";
	text = "e8e7d7ff";
	border = "1c2741ff";
      };

      border = {
	width = 3;
	radius = 0;
      };
    };
  };
}
