{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  name = "gruvbox-css";
  version = "latest";
  src = ./.;
  phases = "installPhase";
  installPhase = ''
    mkdir -p $out
    cp -rf $src/gruvbox.css $out/gruvbox.css
    cp -rf $src/snow.css $out/snow.css
  '';
}
