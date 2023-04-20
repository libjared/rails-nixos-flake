{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
    rubyEnv = pkgs.bundlerEnv {
      name = "env";
      gemdir = ./.;
    };
  in {
    # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [
        pkgs.bundler
        pkgs.bundix
        rubyEnv
        rubyEnv.wrappedRuby
      ];
    };
  };
}
