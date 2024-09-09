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

  outputs = {
    self, nixpkgs, ...
  } @ inputs:
  let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstablel.legacyPackages.${system};
    pkgs-upstream = nixpkgs-upstream.legacyPackages.${system};

    # How do I hide this?
    username = "biixie";
    name = "Biixie";
  in 
  {
    nixosConfigurations = {
      thinkpad-e495 = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
	  inherit inputs;
          inherit pkgs;
	  inherit pkgs-unstable;
	  inherit pkgs-upstream;
        };

	modules = [
	  ./hosts/thinkpad-e495/configuration.nix
	  ./modules/nixos
	];
      };
    };

    homeConfigurations."biixie" = home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { 
        inherit inputs;
	inherit pkgs;
	inherit pkgs-unstable;
	inherit pkgs-upstream;
      };

      modules = [
        ./hosts/laptop-e495/home.nix
        ./modules/home-manager
      ];
    ];
  };
}
