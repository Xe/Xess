{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }@inputs:
    utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = rec {
          default = import ./default.nix { inherit pkgs; };
          customized = cssFile:
            pkgs.stdenv.mkDerivation rec {
              name = "Xess-customized";
              version = "latest";
              src = ./.;
              buildInputs = with pkgs; [ nodePackages.clean-css-cli ];
              phases = "installPhase";
              installPhase = ''
                mkdir -p $out/static/css
                cleancss -o $out/static/css/xess.css ${cssFile} $src/xess-base.css
                ln -s $out/static/css/xess.css $out/gruvbox.css
                cp $src/sample.html $out
              '';
            };

          # example customized css files
          aoi = customized ./custom/aoi.css;
          cherry = customized ./custom/cherry.css;
          green = customized ./custom/green.css;
          kafon = customized ./custom/kafon.css;

          combined = pkgs.runCommand "combined" {} ''
            mkdir -p $out
            ln -s ${iaso}/static/css/xess.css $out/xess.css
            ln -s ${aoi}/static/css/xess.css $out/aoi.css 
            ln -s ${cherry}/static/css/xess.css $out/cherry.css 
            ln -s ${green}/static/css/xess.css $out/green.css 
            ln -s ${kafon}/static/css/xess.css $out/kafon.css 
          '';

          iaso = pkgs.stdenv.mkDerivation rec {
            name = "Xess";
            version = "latest";
            src = ./.;
            buildInputs = with pkgs; [ nodePackages.clean-css-cli ];
            phases = "installPhase";
            installPhase = ''
              mkdir -p $out/static/css
              cleancss -o $out/static/css/xess.css $src/classic/iaso.css
            '';
          };
        };
        devShell = import ./shell.nix { inherit pkgs; };
      });
}
