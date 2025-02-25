{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.home-manager
    pkgs.sesh
    pkgs.zoxide
    pkgs.fzf
    pkgs.neovim
  ];

  # Since we are using determinate nix distribution
  nix.enable = false;

  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;
  };

  system.stateVersion = 4;

  fonts.packages = [
    pkgs.atkinson-hyperlegible
    pkgs.jetbrains-mono
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = [
      "asitop"
      "aws-iam-authenticator"
      "aws-nuke"
      "awscli"
      "azure-cli"
      "azure/functions/azure-functions-core-tools@4"
      "bartycrouch"
      "bento4"
      "btop"
      "cmake"
      "cocoapods"
      "composer"
      "datasette"
      "deno"
      "derailed/k9s/k9s"
      "direnv"
      "doctl"
      "doggo"
      "duf"
      "dust"
      "eksctl"
      "emacs"
      "fastfetch"
      "fd"
      "FelixKratz/formulae/sketchybar"
      "ffmpeg"
      "foreman"
      "fzf"
      "gh"
      "glab"
      "gnupg"
      "go"
      "graphviz"
      "hashicorp/tap/consul-k8s"
      "hashicorp/tap/terraform"
      "helm"
      "heroku/brew/heroku"
      "htop"
      "iftop"
      "iperf3"
      "joshmedeski/sesh/sesh"
      "jq"
      "kind"
      "leg100/tap/pug"
      "lolcat"
      "mas"
      "minikube"
      "netcat"
      "ninja"
      "nvm"
      "pinentry-mac"
      "podman"
      "pulumi/tap/pulumi"
      "python@3.12"
      "qemu"
      "qt"
      "rbenv"
      "redis"
      "ripgrep"
      "rover"
      "socat"
      "sst/tap/sst"
      "ugrep"
      "unzip"
      "vim"
      "watchman"
      "yarn"
    ];
    casks = [
      "1password"
      "1password-cli"
      "alcove"
      "alfred"
      "amie"
      "android-file-transfer"
      "bartender"
      "betterdisplay"
      "bitwarden"
      "cleanshot"
      "crystalfetch"
      "cursor"
      "discord"
      "docker"
      "dropbox"
      "expo-orbit"
      "figma"
      "firefox"
      "flirc"
      "font-bitstream-vera-sans-mono-nerd-font"
      "font-hack-nerd-font"
      "font-meslo-lg-nerd-font"
      "ghostty"
      "gitkraken-cli"
      "google-chrome"
      "google-cloud-sdk"
      "granola"
      "iina"
      "istat-menus"
      "linear-linear"
      "meetingbar"
      "miniconda"
      "miro"
      "monarch"
      "ngrok"
      "orion"
      "onyx"
      "orbstack"
      "pgadmin4"
      "raycast"
      "reactotron"
      "rectangle-pro"
      "retroarch-metal"
      "setapp"
      "signal"
      "slack"
      "slack-cli"
      "sloth"
      "spotify"
      "ssh-config-editor"
      "the-unarchiver"
      "tidal"
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
      "derailed/k9s"
      "hashicorp/tap"
      "heroku/brew"
      "homebrew/bundle"
      "homebrew/services"
      "homebrew/test-bot"
      "joshmedeski/sesh"
      "leg100/tap"
      "pulumi/tap"
      "sst/tap"
      "FelixKratz/formulae"
    ];
    masApps = {
      "DaisyDisk" = 411643860;
      "Ice Cubes" = 6444915884;
      "Ivory" = 6444602274;
      "Keka" = 470158793;
      "MediaInfo" = 510620098;
      "Parcel" = 639968404;
      "Photomator" = 1444636541;
      "Pixelmator Pro" = 1289583905;
      "Prime Video" = 545519333;
      "Raw Convertor" = 1598580439;
      "Screens 5" = 1663047912;
      "Tailscale" = 1475387142;
      "WireGuard" = 1451685025;
      "Xcode" = 497799835;
    };
  };

  system.defaults = {
    NSGlobalDomain = {
      NSWindowShouldDragOnGesture = true;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      InitialKeyRepeat = 20;
      KeyRepeat = 1;
      AppleShowAllExtensions = true;
      "com.apple.springing.enabled" = true;
      "com.apple.springing.delay" = 0.1;
      "com.apple.swipescrolldirection" = false;
    };

    screencapture = {
      location = "~/Downloads";
      type = "png";
      disable-shadow = true;
    };

    finder = {
      CreateDesktop = false;
      QuitMenuItem = true;
      _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      ShowExternalHardDrivesOnDesktop = false;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowRemovableMediaOnDesktop = false;
      ShowStatusBar = true;
      # Current Folder
      FXDefaultSearchScope = "SCcf";
      NewWindowTarget = "Other";
      NewWindowTargetPath = "file://${builtins.getEnv "HOME"}";
    };

    dock = {
      autohide = true;
      show-recents = false;
      expose-animation-duration = 0.15;
      orientation = "left";
      tilesize = 32;
      magnification = true;
      largesize = 64;
    };

    ActivityMonitor = {
      OpenMainWindow = true;
      # All Processes
      ShowCategory = 100;
      SortColumn = "CPUUsage";
      # Descending
      SortDirection = 0;
    };

    CustomUserPreferences = {
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
      # Prevent Photos from opening automatically when devices are plugged in
      "com.apple.ImageCapture".disableHotPlug = true;
      # Turn on app auto-update
      "com.apple.commerce".AutoUpdate = true;
    };
  };

  # Disable skhd for now
  # services.skhd = {
  #   enable = true;
  #   skhdConfig = ''
  #     cmd - return : open --new -a ghostty.app
  #   '';
  # };

  system.activationScripts.extraActivation.text = ''
    # Show Library folder
    chflags nohidden ~/Library

    # Following line should allow us to avoid a logout/login cycle to see changes
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
