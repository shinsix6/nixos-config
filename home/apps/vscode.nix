{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = (pkgs.vscode.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--ozone-platform=wayland"
        "--enable-features=WaylandWindowDecorations"
      ];
    });
    extensions = with pkgs.vscode-extensions; [
      vscjava.vscode-java-pack
    ];
  };
}
