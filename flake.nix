{
  description = "shin6 Flake Config";

  inputs = {
    # Nix Official Package
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    
    niri.url = "github:sodiboo/niri-flake";

    # quickshell = {
    #   url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # }; 

    # qml-niri = {
    #   url = "github:imiric/qml-niri/main";
    # };   

    # home-manager, for user level configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # for avoid problems caused by different version of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, niri, ...}@inputs: {
    nixosConfigurations.shin6 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit self inputs; };
      modules = [
	# Impor previos nixos config
	./configuration.nix
      ];
    };

    homeConfigurations."shin6" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { inherit inputs; };
      modules = [ 
	./home/home.nix 
      ];
    };
  };
}
