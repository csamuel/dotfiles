{ lib, config, ... }:

lib.mkIf config.profiles.gaming.enable {
  homebrew = {
    taps = [
      "streetpea/streetpea"
    ];
    casks = [
      "crossover"
      "retroarch-metal"
      "shadow"
      "sony-ps-remote-play"
      "steam"
      "streetpea/streetpea/chiaki-ng"
    ];
  };
}
