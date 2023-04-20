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

    # how I set this up:
    # nix shell 'nixpkgs#bundler' 'nixpkgs#bundix'
    # export BUNDLE_FORCE_RUBY_PLATFORM=true
    # rm -f gemset.nix
    # bundler lock
    # bundix
    # direnv reload
    # rails new . --skip-bundle
    # direnv reload
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [
        pkgs.bundler
        pkgs.bundix
        rubyEnv
        rubyEnv.wrappedRuby
      ];
      BUNDLE_FORCE_RUBY_PLATFORM = "true";
    };
  };
}
