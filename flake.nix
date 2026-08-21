{
  description = "shinsix6 Flake Config";

  inputs = {
    # Nix Official Package
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # CachyOs Kernel
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    
    # SilentDDM theme 
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SFMono w/ patches input
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    # home-manager, for user level configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      # for avoid problems caused by different version of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
 
 outputs = {self, nixpkgs, home-manager, sf-mono-liga-src, nix-cachyos-kernel, silentSDDM, ...}@inputs: {
    nixosConfigurations.shinsix6 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit self inputs; };
      modules = [
	    # Impor previos nixos config
	    ./configuration.nix
	    ./core/fonts.nix
        (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                nix-cachyos-kernel.overlays.pinned
              ];
            }
        )
      ];
    };

    homeConfigurations."shinsix6" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { inherit inputs; };
      modules = [ 
        ./home/home.nix

      ];
    };
  };
}
