{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = import nixpkgs { inherit system; };

        # you can pin the GHC version
        ghc = (pkgs.haskell.packages.ghc96.ghcWithPackages (p: with p; [
          haskell-language-server
          text
          # Add packages you want to use
        ]));
      in
        {
          devShell = pkgs.mkShell {
            packages = [ ghc ];
          };

          packages.default = pkgs.stdenv.mkDerivation {
            name = "";
            buildInputs = [ ghc ];
            src = ./.;
            buildPhase = ''
              ghc main.hs
            '';
            installPhase = ''
              mkdir -p $out/bin
              cp main $out/bin
            '';
          };
        }
    );
}
