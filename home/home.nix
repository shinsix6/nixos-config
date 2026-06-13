{ config, pkgs, inputs, ...}:

{
  home.username = "shin6";
  home.homeDirectory = "/home/shin6";

  nixpkgs.config.allowUnfree = true;

  imports = [
    inputs.niri.homeModules.niri
    ./niri.nix
    ./niri/autostart.nix
    ./cursor.nix
    ./apps/kitty.nix
    ./apps/fuzzel.nix
    ./apps/swaylock.nix
    ./apps/mako.nix
    ./apps/nvim.nix
    ./apps/swayidle.nix
    ./apps/ghostty.nix
    ./apps/vscode.nix
  ];

  # Packages that will be installed in the user profile.
  home.packages = with pkgs; [
    nnn
    neofetch
    joplin-desktop
    zed-editor
    wlr-randr
    wl-mirror
    zathura
    mako
    xwayland-satellite
    pavucontrol
    btop
    swayidle
    ghostty
    android-studio
    android-tools
    postman
    mongodb-compass
    feh
    obs-studio
    mpv
    filezilla
    quickshell
    nh
  ];

  # Configurations for pkgs
  
  # fish shell config
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';

    # Set alias
    shellAliases = {
      la = "ls -a";
      ll = "ls -l";
      snvim = "sudo nvim";
      svim = "sudo vim";
      nx = "cd ~/nixos-config/"; # cd to nixos conf folder
      nixre = "sudo nixos-rebuild switch --flake ~/nixos-config#shin6";
      neru = "systemctl suspend";
      nixconf = "nvim ~/nixos-config/configuration.nix";
      hmconf = "nvim ~/nixos-config/home/home.nix";
      flakeconf = "nvim ~/nixos-config/flake.nix";
      hmre = "home-manager switch --flake ~/nixos-config#shin6"; # rebuild home-manager
      
    };
  };

  # Home manage Version
  home.stateVersion = "25.11";
}
