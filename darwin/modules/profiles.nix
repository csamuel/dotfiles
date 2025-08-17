{ lib, ... }:

{
  options.profiles = {
    audio.enable = lib.mkEnableOption "Enable audio production apps and tooling";
    gaming.enable = lib.mkEnableOption "Enable gaming-related apps and tooling";
    photography.enable = lib.mkEnableOption "Enable photography-related apps and tooling";
    video.enable = lib.mkEnableOption "Enable video-related apps and tooling";
  };
}
