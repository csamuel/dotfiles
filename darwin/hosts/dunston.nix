{ pkgs, lib, ... }:

{
  profiles = {
    audio.enable = true;
    gaming.enable = true;
    photography.enable = true;
    video.enable = true;
  };

  wallpaper = ../../wallpapers/deeptwilight.png;

  fonts.packages = lib.mkAfter [ pkgs.nerd-fonts.fira-code ];
}
