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

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt;
      devShells.aarch64-darwin.default = devShellFor "aarch64-darwin";

      # For CI lint on linux runners
      devShells.x86_64-linux.default = devShellFor "x86_64-linux";
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    };
}
