{ lib, config, ... }:

lib.mkIf config.profiles.game-dev.enable {
  homebrew = {
    casks = [
      "epic-games"
      "godot"
    ];
    masApps = {
      "Xcode" = 497799835;
    };
  };
}
