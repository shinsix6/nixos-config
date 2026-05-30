## FONT CONFIG

{ config, pkgs, ...}:

{
  fonts = {
    packages = with pkgs; [
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
	  "Monofur Nerd Font"
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
