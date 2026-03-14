{ pkgs, lib, ... }:

{
  profiles = {
    audio.enable = true;
    gaming.enable = true;
    photography.enable = true;
    video.enable = true;
  };

  wallpaper = {
    enable = true;
    image = ../../wallpapers/deeptwilight.png;
  };

  fonts.packages = lib.mkAfter [ pkgs.nerd-fonts.fira-code ];
}
