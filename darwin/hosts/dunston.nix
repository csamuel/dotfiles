{ ... }:

{
  imports = [
    ./shared/media.nix
    ./shared/gaming.nix
  ];

  wallpaper = {
    enable = true;
    image = ../../wallpapers/deeptwilight.png;
  };
}
