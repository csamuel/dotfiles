{ ... }:

{
  imports = [
    ./modules/base.nix
    ./modules/packages.nix
    ./modules/fonts.nix
    ./modules/nerd-fonts.nix
    ./modules/homebrew.nix
    ./modules/defaults.nix
    ./modules/dock.nix
    ./modules/activation.nix
    ./modules/determinate-nix.nix
    ./modules/profiles.nix
    ./modules/wallpaper.nix
    ./audio.nix
    ./gaming.nix
    ./photography.nix
    ./video.nix
  ];
}
