{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  name = "Xess";
  version = "latest";
  src = ./.;
  inputs = with pkgs; [ nodePackages.clean-css-cli ];
  phases = "installPhase";
  installPhase = ''
    mkdir -p $out/static
    cleancss -o $out/static/xess.css $src/xess.css
    cleancss -o $out/static/xess_snow.css $src/snow.css
    ln -s $out/static/xess.css $out/gruvbox.css
  '';
}
