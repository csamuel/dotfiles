{ lib, config, ... }:

lib.mkIf config.profiles.video.enable {
  homebrew = {
    brews = [
      "mkvtoolnix"
    ];
    casks = [
      "makemkv"
      "topaz-video"
    ];
    masApps = {
      "Compressor" = 424390742;
      "Final Cut Pro" = 424389933;
      "RAW Converter" = 1598580439;
    };
  };
}
