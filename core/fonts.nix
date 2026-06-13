## FONT CONFIG

{ config, pkgs, inputs, ...}:

{
  nixpkgs.overlays = [
    (final: prev: {
      sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
        pname = "sf-mono-liga-bin";
	version = "dev";
	src = inputs.sf-mono-liga-src;
	dontConfigure = true;
	dontBuild = true;
	installPhase = ''
	  mkdir -p $out/share/fonts/opentype
	  cp -R $src/*.otf $out/share/fonts/opentype/
	'';
      };
    })
  ];

  fonts = {
    packages = with pkgs; [
      sf-mono-liga-bin  
      nerd-fonts.monofur
      nerd-fonts.hack
      nerd-fonts.fantasque-sans-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji 
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [
	  "Liga SFMono Nerd Font"
	  "Noto Sans Mono CJK JP"
	];
	sansSerif = [
	  "Noto Sans"
	  "Noto Sans CJK JP"
	];
	serif = [
	  "Noto Serif"
	  "Noto Serif CJK JP"
	];
      };
    };
  };
}
