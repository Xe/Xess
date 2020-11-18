{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodePackages.clean-css-cli

    # keep this line if you use bash
    bashInteractive
  ];
}
