# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./core/fonts.nix
      ./core/tlp.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Java app
  environment.variables._JAVA_AWT_WM_NONREPARENTING = "1";

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable dbus
  services.dbus.enable = true;

  # Enable Polkit
  security.polkit.enable = true;

  # Enable the LXQT Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;
  programs.labwc.enable = true;

  # Enable niri
  programs.niri.enable = true;
  services.xserver.displayManager.startx.enable = true;
  
  # Enable greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
      	command = "
	  ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --remember \
          --remember-session \
          --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
	user = "greeter";
      };
    };
  };  

  # xdg portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };
 
  # environment.sessionVariables = {
  #   XDG_CURRENT_DESKTOP = "niri";
  # };  

  # hardware
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # i5 (Skylake/Kaby Lake)
      intel-vaapi-driver # Legacy support for older apps
      libvdpau-va-gl     # Helps bridge some video apps
    ];
  };

  # Enable graphics
  services.xserver.videoDrivers = [ "modesetting" ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      
      Policy = {
        AutoEnable = true;
      };
    };
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable fish
  programs.fish.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shin6 = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "shin6";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Allowed-user
  nix.settings.allowed-users = [ "root" "shin6" ];
  nix.settings.trusted-users = [ "root" "shin6" ];
  
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Database setup (MariaDB)
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # GPU and CPU
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  # Kernel ver
  # boot.kernelPackages = pkgs.linuxPackages_6_6;

  # Kernel param
  boot.kernelParams = [ 
      "i915.enable_psr=0" 
      "i915.enable_dc=0"
  ];
  boot.initrd.kernelModules = [ "i915" ];

  # Postgresql enable
  services.postgresql.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
   vim
   git
   kitty
   wget
   fuzzel
   xwayland
   waybar
   alacritty
   yazi
   unzip
   p7zip
   ffmpeg
   fish
   nautilus
   swayidle
   xdg-desktop-portal-gtk
   xdg-desktop-portal-wlr
   home-manager
   btop
   brightnessctl
   swww
   swaylock
   # inputs.quickshell.packages.${system}.default   
   # inputs.qml-niri.packages.${system}.quickshell
   qt6.qtbase
   qt6.qtdeclarative
   qt6.qttools
   just
   direnv
   xorg.xinit
   xorg.libxcb
   xorg.xcbutilcursor

   # development
   cmake
   gcc
   jdk21
   kotlin
   steam-run
   maven
   pgadmin4

   # PHP Setup
   php
   (php.withExtensions ({ enabled, all }: enabled ++ [
       all.pdo_mysql
       all.mbstring
       all.openssl
       all.tokenizer
       all.xml
   ]))
   phpPackages.composer
  ];

  environment.variables.EDITOR = "vim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
