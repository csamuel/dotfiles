{ lib, config, ... }:

lib.mkIf config.profiles.photography.enable {
  homebrew = {
    masApps = {
      "Adobe Lightroom" = 1451544217;
    };
  };
}
