{ ... }:

{
  imports = [
    ./shared/media.nix
    ./shared/gaming.nix
  ];

  profiles.game-dev.enable = true;

  wallpaper = {
    enable = true;
    image = ../../wallpapers/deeptwilight.png;
  };
}
