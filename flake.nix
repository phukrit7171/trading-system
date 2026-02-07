{
  description = "TypeScript development environment with Bun";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            bun
            nodePackages.typescript
            nodePackages.typescript-language-server
          ];

          shellHook = ''
            echo "--- TypeScript + Bun Dev Shell ---"
            echo "Bun version: $(bun --version)"
            echo "TS version:  $(tsc --version)"
          '';
        };
      }
    );
}
