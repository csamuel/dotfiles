{ lib, config, ... }:

lib.mkIf config.profiles.gaming.enable {
  homebrew = {
    casks = [
      "crossover"
      "retroarch-metal"
      "shadow"
      "whisky"
    ];
  };
}
