{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  name = "Xess";
  version = "latest";
  src = ./.;
  phases = "installPhase";
  installPhase = ''
    mkdir -p $out
    ${pkgs.nodePackages.clean-css-cli}/bin/cleancss -o $out/xess.css $src/xess.css
    ${pkgs.nodePackages.clean-css-cli}/bin/cleancss -o $out/snow.css $src/snow.css
    ln -s $out/xess.css $out/gruvbox.css
  '';
}
