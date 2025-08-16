{ pkgs, user, ... }:

{
  imports = [
    ./modules/base.nix
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/homebrew.nix
    ./modules/defaults.nix
    ./modules/activation.nix
    ./modules/profiles.nix
    ./audio.nix
    ./gaming.nix
    ./photography.nix
    ./video.nix
  ];
}
