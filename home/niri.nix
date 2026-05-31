{ config, pkgs, ... }:

{
  programs.niri.settings = {
    layout = {
      gaps = 3;
      struts = {
	left = 5;
	right = 5;
	top = 5;
	bottom = 5;
      };
      background-color = "transparent";
      focus-ring.enable = false;
      border = {
	enable = true;
	width = 3;
	active.color = "#CACACA";
	inactive.color = "#1D313C";
      };  
    };

    prefer-no-csd = true;

    outputs."eDP-1".scale = 1.1;

    input = {
      touchpad = {
	click-method = "button-areas";
	dwt = true;
	dwtp = true;
	natural-scroll = true;
	scroll-method = "two-finger";
	tap = true;
	accel-profile = "adaptive";
      };
    };

    cursor = {
      size = 20;
      theme = "breeze_cursors";
    };

    ## RULES
    window-rules = [
      {
        geometry-corner-radius = null;
        clip-to-geometry = true;
      }

      {
	default-column-width.proportion = 0.5;
      }
    ];

    layer-rules = [
      {
        matches = [
	  {
	    namespace = "^swww-daemon$";
	  }
	];
	place-within-backdrop = true;
      }
    ];

    # Binds
    binds = import ./niri/keybinds.nix;

  };
}
