{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  name = "gruvboxcss";
  version = "latest";
  src = ./.;
  phases = "installPhase";
  installPhase = ''
    mkdir -p $out
    cp -rf $src/gruvbox.css $out/gruvbox.css
  '';
}
