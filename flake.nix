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

    nur = {
      url = "github:nix-community/nur";
    };

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
    };

    blctl = {
      url = "github:imxela/blctl/refs/tags/v1.0.0";
    };

    ags.url = "github:Aylur/ags";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-upstream,
    home-manager,
    vscode-server,
    blctl,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;

      overlays = [
        (final: prev: {
          stable = nixpkgs.legacyPackages.${prev.system};
          unstable = nixpkgs-unstable.legacyPackages.${prev.system};
          upstream = nixpkgs-upstream.legacyPackages.${prev.system};
          
          blctl = inputs.blctl.packages.${prev.system}.default;
        })
      ];
    };

    # How do I hide this?
    username = "biixie";
    name = "Biixie";
  in {
    nixosConfigurations = {
      thinkpad-e495 = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          inherit pkgs;
        };

        modules = [
          vscode-server.nixosModules.default
          blctl.nixosModules.default

          ./hosts/thinkpad-e495/configuration.nix
          ./modules/nixos
        ];
      };
    };

    homeConfigurations = {
      "biixie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [
          ./hosts/thinkpad-e495/home.nix
          ./modules/home-manager
        ];
      };
    };
  };
}
