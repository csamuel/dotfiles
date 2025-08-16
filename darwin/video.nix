{ lib, config, ... }:

lib.mkIf config.profiles.video.enable {
  homebrew = {
    brews = [
      "mkvtoolnix"
    ];
    casks = [
      "makemkv"
      "topaz-video-ai"
    ];
    masApps = {
      "Compressor" = 424390742;
      "Final Cut Pro" = 424389933;
      "Raw Convertor" = 1598580439;
    };
  };
}
