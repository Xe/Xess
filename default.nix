{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  name = "gruvbox-css";
  version = "latest";
  src = ./.;
  phases = "installPhase";
  installPhase = ''
    mkdir -p $out
    ${pkgs.nodePackages.clean-css-cli}/bin/cleancss -o $out/gruvbox.css $src/gruvbox.css
    ${pkgs.nodePackages.clean-css-cli}/bin/cleancss -o $out/snow.css $src/snow.css
  '';
}
