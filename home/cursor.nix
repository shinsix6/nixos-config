{pkgs, ...}:

{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Breeze";
    package = pkgs.kdePackages.breeze;
    size = 20;
  };
}
