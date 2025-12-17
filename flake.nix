{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      wk-prompt = pkgs.callPackage ./default.nix {};
    in {
      packages = {
        default = wk-prompt;
        wk-prompt = wk-prompt;
      };
      devShells.default = pkgs.callPackage ./shell.nix {inherit wk-prompt;};
      formatter = pkgs.alejandra;
    })
    // {
      overlays.default = final: prev: {
        wk-prompt = final.callPackage ./default.nix {};
      };
    };
}
