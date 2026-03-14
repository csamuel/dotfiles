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
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});

      darwinSystem =
        hostname:
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
              networking.hostName = hostname;
              networking.computerName = hostname;
              networking.localHostName = hostname;
              home-manager = {
                backupFileExtension = ".backup";
                users.${user} = import ./home-manager;
              };
              users.users.${user}.home = "/Users/${user}";
            }
          ]
          ++ configs;
        };
      # Helper to build the same dev shell for any target system
      devShellFor =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.mkShell {
          packages = with pkgs; [
            treefmt
            nixfmt
            nixd
            direnv
            git
          ];
          shellHook = ''
            git config core.hooksPath hooks
          '';
        };

      mkCheck =
        pkgs: name: nativeBuildInputs: command:
        pkgs.runCommand name
          {
            inherit nativeBuildInputs;
            src = ./.;
          }
          ''
            cp -r "$src" repo
            chmod -R +w repo
            cd repo
            ${command}
            touch "$out"
          '';
    in
    {
      darwinConfigurations = builtins.mapAttrs darwinSystem {
        # M2 MacBook Air
        higgins = {
          user = "chris";
          configs = [ ./darwin/hosts/higgins.nix ];
        };
        # M1 Mac Studio Ultra
        benson = {
          user = "chris";
          configs = [ ./darwin/hosts/benson.nix ];
        };
        # M4 MacBook Pro
        spaceblack = {
          user = "chris.samuel";
          configs = [ ./darwin/hosts/spaceblack.nix ];
        };
        # M4 MacBook Air
        dunston = {
          user = "chris";
          configs = [ ./darwin/hosts/dunston.nix ];
        };
        # M4 MacBook Pro Max
        mfourmax = {
          user = "chris.samuel";
          configs = [ ./darwin/hosts/mfourmax.nix ];
        };
      };

      formatter = forAllSystems (pkgs: pkgs.nixfmt);
      devShells.aarch64-darwin.default = devShellFor "aarch64-darwin";

      # For CI lint on linux runners
      devShells.x86_64-linux.default = devShellFor "x86_64-linux";
      checks = forAllSystems (pkgs: {
        treefmt =
          mkCheck pkgs "treefmt-check"
            [
              pkgs.treefmt
              pkgs.nixfmt
            ]
            ''
              treefmt --ci
            '';

        deadnix = mkCheck pkgs "deadnix-check" [ pkgs.deadnix ] ''
          deadnix --fail .
        '';
      });
    };
}
