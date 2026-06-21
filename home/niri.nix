{ config, pkgs, inputs, lib, ... }:

{
  programs.niri =
    let
      niriPkgs = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system};
    in 
    {
      package = niriPkgs.niri-unstable;
      settings.xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

       # programs.niri.package = inputs.niri.packages.${pkgs.system}.niri-unstable;
  
      settings = {
        # includes = lib.mkAfter [
        #   (./niri/blur.kdl)
        # ];

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
            geometry-corner-radius = {
              top-left = 10.0;
              top-right = 10.0;
              bottom-left = 10.0;
              bottom-right = 10.0;
            };
            clip-to-geometry = true;
          }

          {
            default-column-width.proportion = 0.5;
          }
          {
            matches = [
              {
                app-id = "kitty";
              }
            ];
            background-effect = { 
                blur = true;
                xray = true;
            };
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
          {
            matches = [
              {
                namespace = "^noctalia-wallpaper";
              }
            ];
            place-within-backdrop = true;
          }
        ];

        # Binds
        binds = import ./niri/keybinds.nix;

    };
  };
}
