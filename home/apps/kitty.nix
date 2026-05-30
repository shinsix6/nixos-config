{ config, pkgs, ... }:

let
  colors = {
    bg = "#070707";
    fg = "#cacaca";
    sbg = "#F6723A";
    sfg = "#50A3AB";
  };

in
{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 11;
      background = colors.bg;
      foreground = colors.fg;
      hide_window_decoration = true;
      window_padding_width = 5;

     #colors
     color0 = "#070707"; #black
     color8 = "#636363";
     color7 = "#d6d4a7"; #white
     color15 = "#d6d4a7";
     color1 = "#8e3433"; #red
     color9 = "#8e3433";
     color2 = "#387654"; #green
     color10 = "#387654"; 
     color3 = "#F6733A"; #Yellow
     color11 = "#E77843";
     color4 = "#79C39E"; #blue
     color12 = "#4FA3AB";
     color5 = "#b73d6E"; #magenta
     color13 = "#9F409A";
     color6 = "#69AFAD"; #cYan
     color14 = "#2ABA9E";
     selection_background = colors.sbg;
     selection_foreground = colors.sfg;

     #keybinds
     "map ctrl+shift+c" = "copy_to_clipboard";
     "map ctrl++" = "change_font_size all +2.0";
     "map ctrl+-" = "change_font_size all -2.0";
     "map ctrl+backspace" = "change_font_size all 0";
     "map ctrl+shift+enter" = "new_window";
     "map ctrl+shift+w" = "close_window";
    };
  };
}
