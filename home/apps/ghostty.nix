{ pkgs, config, ... }:

let
  colors = {
    bg = "#070707";
    fg = "#cacaca";
  };

in
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Black Metal (Venom)";
      font-size = 10.5;
      font-family = "FantasqueSansM Nerd Font Mono";
      font-synthetic-style = "bold,italic,bold-italic";
      window-padding-x = 3;
      window-padding-balance = true;

      # force working dir
      window-inherit-working-directory = false;
      working-directory = "home";

      link-url = true;

    };
  };
}
