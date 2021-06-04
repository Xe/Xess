{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }@inputs:
    utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        defaultPackage = import ./default.nix { inherit pkgs; };
        devShell = import ./shell.nix { inherit pkgs; };
      }
    );
}
