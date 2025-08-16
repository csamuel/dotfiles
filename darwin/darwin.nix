{ pkgs, user, ... }:

{
  system.primaryUser = user;

  nixpkgs.config.allowUnfree = true;

  # Since we are using determinate nix distribution
  nix.enable = false;

  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;
  };

  system.stateVersion = 4;

  environment.systemPackages = with pkgs; [
    asitop
    autoconf
    autoconf-archive
    automake
    aws-nuke
    aws-iam-authenticator
    awscli2
    btop
    cmake
    ccache
    cocoapods
    deno
    direnv
    doctl
    doggo
    duckdb
    duf
    dust
    eksctl
    emacs
    fastfetch
    fd
    ffmpeg
    foreman
    fzf
    gh
    glab
    gnupg
    go
    google-cloud-sdk
    k9s
    kubernetes-helm
    heroku
    home-manager
    htop
    iftop
    iperf3
    jq
    kind
    lolcat
    neovim
    minikube
    nasm
    netcat
    ninja
    pinentry_mac
    podman
    pkg-config
    python313
    ripgrep
    rbenv
    qemu
    sesh
    sketchybar
    sketchybar-app-font
    socat
    terraform
    tmux
    ugrep
    unzip
    uv
    vim
    watchman
    yarn
    zellij
    zoxide
  ];

  fonts.packages = with pkgs; [
    atkinson-hyperlegible
    jetbrains-mono
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = [
      "gemini-cli"
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
      "gitkraken-cli"
      "google-chrome"
      "granola"
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
      "orion"
      "onyx"
      "orbstack"
      "pgadmin4"
      "postman"
      "raycast"
      "reactotron"
      "rectangle-pro"
      "setapp"
      "signal"
      "slack"
      "sloth"
      "spotify"
      "ssh-config-editor"
      "syncthing-app"
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
      AppleInterfaceStyle = "Dark";
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

    # TODO: Disable until I can determine why this inverts natural scrolling option
    # Following line should allow us to avoid a logout/login cycle to see changes
    # /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
