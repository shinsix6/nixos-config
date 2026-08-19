{ config, pkgs, inputs, ...}:

{
  home.username = "shinsix6";
  home.homeDirectory = "/home/shinsix6";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./cursor.nix
    ./apps/kitty.nix
    ./apps/fuzzel.nix
    ./apps/swaylock.nix
    #./apps/mako.nix
    ./apps/nvim.nix
    ./apps/swayidle.nix
    ./apps/ghostty.nix
    ./apps/vscode.nix
    ./apps/fish.nix
  ];

  # Insecure
  nixpkgs.config = {
    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };

  # Packages that will be installed in the user profile.
  home.packages = with pkgs; [
    nnn
    fastfetch
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
    # quickshell
    nh
    webcord
    foliate
    qbittorrent
    dict
    stirling-pdf
    bottles
    bruno
    starship
    tree
    deskflow
    ngrok
    gh
    lutris
    winetricks
    wineWow64Packages.staging
    palemoon-bin
    nodejs
  ];
  
  # Home manage Version
  home.stateVersion = "25.11";
}
