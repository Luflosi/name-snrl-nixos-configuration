{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    shlyupa.url = "github:ilya-fedin/nur-repository";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    dots = {
      url = "github:name-snrl/home";
      flake = false;
    };
    nvim = {
      url = "github:name-snrl/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-nightly = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    graphite-gtk = {
      url = "github:vinceliuice/graphite-gtk-theme";
      flake = false;
    };
    graphite-kde = {
      flake = false;
      url = "github:vinceliuice/graphite-kde-theme";
    };

    flake-registry = {
      url = "github:nixos/flake-registry";
      flake = false;
    };
    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    #snrl-lib.url = "github:name-snrl/nixos-ez-flake";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, flake-parts, ... }:
    (flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./hosts
        ./overlays
        ./pkgs
        ./shell.nix
      ];
    })
    // {
      # Filesystem-based attribute set of module paths
      nixosModules =
        let
          mkModuleTree =
            with nixpkgs.lib;
            dir:
            mapAttrs' (
              name: type:
              if type == "directory" then
                nameValuePair name (mkModuleTree /${dir}/${name})
              else if name == "default.nix" then
                nameValuePair "self" /${dir}/${name}
              else
                nameValuePair (removeSuffix ".nix" name) /${dir}/${name}
            ) (filterAttrs (name: type: type == "directory" || hasSuffix ".nix" name) (builtins.readDir dir));
        in
        mkModuleTree ./modules;
    };
}
