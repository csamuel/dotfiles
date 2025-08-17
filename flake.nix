{
  description = "Nix Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      darwin,
      home-manager,
      ...
    }@inputs:
    let
      darwinSystem =
        {
          user,
          arch ? "aarch64-darwin",
          configs ? [ ],
        }:
        darwin.lib.darwinSystem {
          specialArgs = { inherit user inputs; };
          system = arch;
          modules = [
            ./darwin/darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                backupFileExtension = ".backup";
                users.${user} = import ./home-manager;
              };
              users.users.${user}.home = "/Users/${user}";
              nix.settings.trusted-users = [ user ];
            }
          ]
          ++ configs;
        };
    in
    {
      darwinConfigurations = {
        # M2 MacBook Air
        "higgins" = darwinSystem {
          user = "chris";
          configs = [ ./darwin/hosts/higgins.nix ];
        };
        # M1 Mac Studio Ultra
        "benson" = darwinSystem {
          user = "chris";
          configs = [ ./darwin/hosts/benson.nix ];
        };
        # M4 MacBook Pro
        "spaceblack" = darwinSystem {
          user = "chris.samuel";
          configs = [ ./darwin/hosts/spaceblack.nix ];
        };
        # M4 MacBook Air
        "dunston" = darwinSystem {
          user = "chris";
          configs = [ ./darwin/hosts/dunston.nix ];
        };
      };

      # flake extras
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;

      devShells.aarch64-darwin.default =
        let
          system = "aarch64-darwin";
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.mkShell {
          packages = [
            pkgs.treefmt
            pkgs.nixfmt-rfc-style
            pkgs.nixd
            pkgs.nil
            pkgs.direnv
            pkgs.git
            pkgs.home-manager
            inputs.darwin.packages.${system}.darwin-rebuild
          ];
        };

      # evaluation-only syntax checks to avoid building macOS system
      checks.aarch64-darwin.syntax =
        let
          system = "aarch64-darwin";
          pkgs = nixpkgs.legacyPackages.${system};
          isDarwinModule = builtins.isFunction (import ./darwin/darwin.nix);
          isHomeModule = builtins.isFunction (import ./home-manager/default.nix);
        in
        (
          assert isDarwinModule && isHomeModule;
          pkgs.runCommand "syntax-ok" { } ''
            echo ok > $out
          ''
        );
    };
}
