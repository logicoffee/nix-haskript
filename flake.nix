{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = function:
        nixpkgs.lib.genAttrs supportedSystems (system: function (import nixpkgs { inherit system; }));
    in
      {
        devShells = forAllSystems (pkgs: {
          default = pkgs.mkShell {
            packages = [
              # you can pin the GHC version
              (pkgs.haskell.packages.ghc96.ghcWithPackages (p: with p; [
                haskell-language-server
                text
                # Add packages you want to use
              ]))
            ];
          };
        });
      };
}
