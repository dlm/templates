{
  description = "Template for flakifying a go project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # this tool allows us use nix-shell and nix shell
    # and is used for our shell.nix
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.git
            pkgs.go
            pkgs.gotools # for tools like goimports
            pkgs.golangci-lint # for linting go files
            pkgs.nixfmt-rfc-style # for tools like nix fmt
          ];

          shellHook = ''
            echo "This was setup using flakify-go, but you are not done:"
            echo "- Go into the flake.nix and update the 'description'"
            echo ""
            echo "If this is a new project:"
            echo "- run `go mod init`"
            echo ""
            echo "If this is an existing project:"
            echo "- add additional project dependencies"
          '';
        };
      }
    );
}
