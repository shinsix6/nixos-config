{
  description = "shin6 Flake Config";

  # niri binary
  nixConfig = {
    extra-substituters = [ 
        "https://niri.cachix.org" 
        "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [ 
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    # Nix Official Package
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    
    niri = {
        url = "github:sodiboo/niri-flake";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-fork = {
        # url = "github:sodiboo/niri-flake";
        # epireyn forking from sodiboo (For background-effec)
        # could be changed to sodiboo later if they updated the niri
        url = "github:epireyn/niri-flake";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    # niri-pkgs = {
    #     url = "github:sodiboo/niri-flake";
    # };
    
    noctalia = {
        url = "github:noctalia-dev/noctalia";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    # SFMono w/ patches input
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    # home-manager, for user level configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # for avoid problems caused by different version of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, niri, niri-fork, sf-mono-liga-src, noctalia, ...}@inputs: {
    nixosConfigurations.shin6 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit self inputs; };
      modules = [
	    # Impor previos nixos config
	    ./configuration.nix
	    ./core/fonts.nix
    
        # import niri NixOS module from flake
        niri.nixosModules.niri
      ];
    };

    homeConfigurations."shin6" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { inherit inputs; };
      modules = [ 
        ./home/home.nix

        # import niri NixOS module from flake
        niri-fork.homeModules.niri
      ];
    };
  };
}
