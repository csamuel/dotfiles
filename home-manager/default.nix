{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./git.nix
    ./tmux.nix
  ];

  xdg.enable = true;

  xdg.configFile."ghostty/config".source = ./../.config/ghostty/config;
  xdg.configFile."direnv/direnv.toml".source = ./../.config/direnv/direnv.toml;
  xdg.configFile."zed/settings.json.backup".source = ./../.config/zed/settings.json;
  xdg.configFile."starship.toml".source = ./../.config/starship.toml;

  home = {
    stateVersion = "24.05";

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      nixd
      cloudlens
      cmatrix
      nixfmt
      nil
      tree
      starship
    ];
  };

  # Append to PATH in generated hm-session-vars
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  programs = {
    zoxide.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      dotDir = config.home.homeDirectory;
      plugins = [
        {
          name = "powerlevel10k-config";
          src = ./p10k;
          file = "p10k.zsh";
        }
      ];
      shellAliases = {
        gauth = "gcloud auth login --update-adc --brief";
        ll = "ls -l";
        t = "gittower";
        switch = "sudo darwin-rebuild switch --flake .";
        update = "nix flake update";
        j = "z"; # autojump muscle memory
        # https://github.com/DeterminateSystems/nix-installer/issues/1479
        kick-nix = ''
          sudo launchctl kickstart -k system/systems.determinate.nix-store && \
          sudo launchctl kickstart -k system/systems.determinate.nix-daemon && \
          sudo launchctl kickstart -k system/systems.determinate.nix-installer.nix-hook
        '';
      };
      initContent = lib.mkMerge [
        (lib.mkBefore ''
          # Enable Powerlevel10k instant prompt (skipped when using starship).
          # Initialization code that may require console input (password prompts, [y/n]
          # confirmations, etc.) must go above this block; everything else may go below.
          if [[ ''${PROMPT_THEME:-p10k} == p10k ]]; then
            if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
              source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi
          fi

          export NVM_DIR="$HOME/.nvm"
          [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
          [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
        '')
        ''
          # Load p10k theme only when selected (keeps starship shell clean)
          if [[ ''${PROMPT_THEME:-p10k} == p10k ]]; then
            source "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
          else
            eval "$(starship init zsh)"
          fi

          # Helper functions to switch prompts in the current shell session
          prompt-starship() { PROMPT_THEME=starship exec zsh; }
          prompt-p10k() { PROMPT_THEME=p10k exec zsh; }
        ''
      ];

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    vscode = {
      enable = false;
    };
  };

  # Optional services like ollama can be enabled per-host via nix-darwin host modules
}
