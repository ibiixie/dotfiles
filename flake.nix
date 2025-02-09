{
  description = "Biixie's NixOS system flake! (v3.0.0)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      inherit (self) outputs;

      systems = [
        "x86_64-linux"
      ];

      pkgsFor = nixpkgs.lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;

          config.allowUnfree = true;
        }
      );
    in
    {
      nixosConfigurations = {
        e495 = nixpkgs.lib.nixosSystem {
          pkgs = pkgsFor.x86_64-linux;
          specialArgs = { inherit inputs outputs; };

          modules = [
            inputs.stylix.nixosModules.stylix

            ./system
            ./system/hosts/e495/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        biixie = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;

          modules = [
            inputs.stylix.homeManagerModules.stylix
            inputs.nixvim.homeManagerModules.nixvim
            inputs.sops-nix.homeManagerModules.sops

            ./home
            ./home/users/biixie/home.nix
          ];

          extraSpecialArgs = { inherit inputs outputs; };
        };
      };

      devShells.x86_64-linux.default =
        let
          pkgs = pkgsFor.x86_64-linux;
        in
        pkgs.mkShell {
          buildInputs = [
            pkgs.nil
            pkgs.nixfmt-rfc-style
          ];
        };

      formatter.x86_64-linux =
        let
          pkgs = pkgsFor.x86_64-linux;
        in
        pkgs.nixfmt-rfc-style;
    };
}
