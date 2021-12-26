{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  name = "Xess";
  version = "latest";
  src = ./.;
  buildInputs = with pkgs; [ nodePackages.clean-css-cli ];
  phases = "installPhase";
  installPhase = ''
    mkdir -p $out/static/css
    cleancss -o $out/static/css/xess.css $src/xess.css
    cleancss -o $out/static/css/xess_snow.css $src/snow.css
    ln -s $out/static/css/xess.css $out/gruvbox.css
  '';
}
