{
  description = "Biixie's NixOS configuration flake!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, lix-module, ... }:
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

      pkgs = pkgsFor.x86_64-linux;
    in
    {
      nixosConfigurations = {
        e495 = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          # pkgs = pkgsFor.x86_64-linux;
          specialArgs = { inherit inputs outputs; };

          modules = [
            ./system
            ./system/hosts/e495/configuration.nix

            lix-module.nixosModules.default

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.biixie = ./home/users/biixie/home.nix;

              home-manager.extraSpecialArgs = { inherit inputs outputs; };
            }
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          # pkgs = pkgsFor.x86_64-linux;
          specialArgs = { inherit inputs outputs; };

          modules = [
            ./system
            ./system/hosts/desktop/configuration.nix

            lix-module.nixosModules.default

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.biixie = ./home/users/biixie/home.nix;

              home-manager.extraSpecialArgs = { inherit inputs outputs; };
            }
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          inherit pkgs;

          specialArgs = { inherit inputs outputs; };

          modules = [
            ./system
            ./system/hosts/wsl/configuration.nix

            lix-module.nixosModules.default

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.biixie = ./home/users/biixie/home.nix;

              home-manager.extraSpecialArgs = { inherit inputs outputs; };
            }
          ];
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
