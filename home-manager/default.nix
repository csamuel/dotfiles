{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./tmux.nix
  ];

  nixpkgs.config.allowUnfree = true;

  xdg.enable = true;

  xdg.configFile."ghostty/config".source = ./../.config/ghostty/config;
  xdg.configFile."zed/settings.json.backup".source = ./../.config/zed/settings.json;

  home = {
    stateVersion = "24.05";

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      nixd
      cloudlens
      cmatrix
      nixfmt-rfc-style
      nil
    ];
  };

  programs = {
    zsh = {
      enable = true;
      plugins = [
        {
          name = "powerlevel10k-config";
          src = ./p10k;
          file = "p10k.zsh";
        }
        {
          name = "zsh-powerlevel10k";
          src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
          file = "powerlevel10k.zsh-theme";
        }
      ];
      shellAliases = {
        gauth = "gcloud auth login --update-adc --brief";
        ll = "ls -l";
        t = "gittower";
        switch = "darwin-rebuild switch --flake .";
        update = "nix flake update";
      };

      initExtraFirst = ''
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';

      initExtra = ''
        # fzf
        source <(fzf --zsh)

        # zoxide
        eval "$(zoxide init zsh)"

        export NVM_DIR="$HOME/.nvm"
        [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
        # [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
      '';
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

  services.ollama.enable = true;
}
