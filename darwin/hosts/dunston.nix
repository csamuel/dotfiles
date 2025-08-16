{ pkgs, ... }:

{
  profiles = {
    audio.enable = true;
    gaming.enable = true;
    photography.enable = true;
    video.enable = true;
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
  ];
}
