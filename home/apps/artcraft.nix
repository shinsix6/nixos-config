{ pkgs, inputs, ... }:

{
  home.packages = [
    inputs.artcraft.packages.${pkgs.system}.default
  ];
  
  # home.packages = [
  #   (pkgs.appimageTools.wrapType2 {
  #     pname = "artcraft";
  #     version = "0.13.0";
  #     src = pkgs.fetchurl {
  #       url = "https://github.com/storytold/craft-launcher/releases/download/v0.13.0/artcraft-launcher-0.13.0-linux-x86_64.AppImage";
  #       hash = "sha256-Dd/MbHA7mlz3gpV1DhA7IHbVRLsmM8cs5Mq1ISMm2N4=";
  #     };
  #     extraPkgs = pkgs: with pkgs; [
  #       wayland
  #       libxkbcommon
  #       libGL
  #       fontconfig
  #       freetype
  #       xorg.libX11
  #       xorg.libXcursor
  #       xorg.libXi
  #       xorg.libXrandr
  #     ];
  #   })
  # ];
}
