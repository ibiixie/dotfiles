{
  description = "NixOS configuration";

  inputs = {
    # Default to stable for software and system
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    
    # But allow unstable software where needed
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # And directly from upstream too
    nixpkgs-upstream.url = "github:nixos/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, nixpkgs-upstream, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    pkgs-upstream = nixpkgs-upstream.legacyPackages.${system};
  in 
  {
    nixosConfigurations = {
      laptop-e495 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };

	modules = [
          ./hosts/laptop-e495/configuration.nix
	  ./modules
	];
      };
    };

    homeConfigurations."biixie" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home.nix
	./modules/home-manager
      ];
    ];
  };
}
