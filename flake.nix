{
  description = "Biixie's NixOS system flake! (v3.0.0)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    blctl = {
      url = "github:ibiixie/blctl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:anyrun-org/anyrun";
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

          overlays = [
            inputs.nur.overlays.default
          ];

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
            inputs.blctl.nixosModules.default

            ./system
            ./system/hosts/e495/configuration.nix
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          pkgs = pkgsFor.x86_64-linux;
          specialArgs = { inherit inputs outputs; };

          modules = [
            inputs.stylix.nixosModules.stylix

            ./system
            ./system/hosts/desktop/configuration.nix
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
            inputs.anyrun.homeManagerModules.anyrun

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
            pkgs.vscode-langservers-extracted
          ];
        };

      formatter.x86_64-linux =
        let
          pkgs = pkgsFor.x86_64-linux;
        in
        pkgs.nixfmt-rfc-style;
    };
}
