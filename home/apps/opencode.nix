{ config, pkgs, ... }:

{
  home.file.".config/opencode/opencode.json".text = ''
    {
      "provider": "gemini",
      "model": "gemini-1.5-pro",
      "shell": "fish",
      "theme": "catpuccin-mocha",
      "auto_confirm": false
    }
  '';
}
