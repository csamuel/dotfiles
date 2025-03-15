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
          system = arch;
          modules = [
            ./darwin/darwin.nix
            home-manager.darwinModules.home-manager
            {
              _module.args = { inherit inputs; };
              home-manager = {
                backupFileExtension = ".backup";
                users.${user} = import ./home-manager;
              };
              users.users.${user}.home = "/Users/${user}";
              nix.settings.trusted-users = [ user ];
            }
          ] ++ configs;
        };
    in
    {
      darwinConfigurations = {
        # M2 MacBook Air
        "higgins" = darwinSystem {
          user = "chris";
        };
        # M1 Mac Studio Ultra
        "benson" = darwinSystem {
          user = "chris";
        };
        # M4 MacBook Pro
        "spaceblack" = darwinSystem {
          user = "chris.samuel";
          configs = [ ./darwin/hosts/spaceblack.nix ];
        };
        # M4 MacBook Air
        "dunston" = darwinSystem {
          user = "chris";
          configs = [
            ./darwin/audio.nix
            ./darwin/gaming.nix
            ./darwin/photography.nix
            ./darwin/video.nix
          ];
        };
      };
    };
}
