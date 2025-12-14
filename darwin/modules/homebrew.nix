{ ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = [
      "mcp-toolbox"
      "pulumi"
      "nvm"
      "sst/tap/sst"
      "sst/tap/opencode"
    ];
    casks = [
      "1password"
      "1password-cli"
      "alcove"
      "affinity-photo"
      "android-file-transfer"
      "balenaetcher"
      "bartender"
      "betterdisplay"
      "bitwarden"
      "claude"
      "cleanshot"
      "crystalfetch"
      "cursor"
      "discord"
      "docker-desktop"
      "dropbox"
      "elgato-stream-deck"
      "expo-orbit"
      "figma"
      "firefox"
      "flirc"
      "font-bitstream-vera-sans-mono-nerd-font"
      "font-hack-nerd-font"
      "font-meslo-lg-nerd-font"
      "ghostty"
      "gitkraken"
      "gitkraken-cli"
      "google-chrome"
      "iina"
      "inkscape"
      "istat-menus"
      "kiro"
      "legcord"
      "linear-linear"
      "lm-studio"
      "miro"
      "monarch"
      "notion"
      "notion-calendar"
      "ngrok"
      "onyx"
      "orbstack"
      "orion"
      "pgadmin4"
      "postman"
      "raycast"
      "reactotron"
      "rectangle-pro"
      "redis-insight"
      "rustdesk"
      "setapp"
      "signal"
      "slack"
      "sloth"
      "spotify"
      "ssh-config-editor"
      "syncthing-app"
      "the-unarchiver"
      "tidal"
      "tigervnc-viewer"
      "tower"
      "transmission"
      "visual-studio-code"
      "vlc"
      "wifiman"
      "xrg"
      "zed"
      "zoom"
    ];
    taps = [
      "azure/functions"
      "homebrew/test-bot"
      "sst/tap"
      "FelixKratz/formulae"
    ];
    masApps = {
      "DaisyDisk" = 411643860;
      "Hyperspace" = 6739505345;
      "Ice Cubes" = 6444915884;
      "Ivory" = 6444602274;
      "Keka" = 470158793;
      "MediaInfo" = 510620098;
      "Okta Verify" = 490179405;
      "Parcel" = 375589283;
      "Photomator" = 1444636541;
      "Pixelmator Pro" = 1289583905;
      "Screens 5" = 1663047912;
      "Tailscale" = 1475387142;
      "WireGuard" = 1451685025;
      "Xcode" = 497799835;
    };
  };
}
