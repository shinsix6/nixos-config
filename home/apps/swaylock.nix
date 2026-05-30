{config, pkgs, ...}:

let
  src = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/1q/wallhaven-1qq37g.png";
    sha256 = "1knrs2hx815xm2cbyf81z4nwkf1jz75cvchqmkknyzx21zy4raw7";
  };

in
  {
    programs.swaylock = {
      enable = true;
      settings = {
        image = "${src}";
        color = "#000";
        font-size = 20;
        indicator-idle-visible = false;
        indicator-radius = 100;
        line-color = "#CACACA";
        show-failed-attemps = true;
      };
    };
}

