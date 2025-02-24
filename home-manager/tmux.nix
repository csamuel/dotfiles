{ pkgs, lib, ... }:
{
  programs.tmux = {
    enable = true;
    escapeTime = 10;
    prefix = "C-a";
    sensibleOnTop = false;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";

    extraConfig = ''
        # set shell
        # https://github.com/nix-community/home-manager/issues/5952#issuecomment-2409056750
        set -gu default-command
        set -g default-shell "$SHELL"

        # Enable mouse mode (tmux 2.1 and above)
        set -g mouse on

        # set vim-style pane navigation shortcuts
        bind -r k select-pane -U
        bind -r j select-pane -D
        bind -r h select-pane -L
        bind -r l select-pane -R

        # switch panes using Alt-arrow without prefix
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # split panes using | and -
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # use fzf to switch tmux sessions
        bind-key "T" run-shell "sesh connect \"$(
      	sesh list | fzf-tmux -p 55%,60% \
      		--no-sort --border-label ' sesh ' --prompt '⚡  ' \
      		--header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
      		--bind 'tab:down,btab:up' \
      		--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
      		--bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t)' \
      		--bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c)' \
      		--bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)' \
      		--bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
      		--bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
            )\""

        # reload config file
        bind r source-file ~/.config/tmux/tmux.conf

    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = dracula;
        extraConfig = ''
          # available plugins: battery, cpu-usage, git, gpu-usage, ram-usage, network, network-bandwidth, network-ping, weather, time
          set -g @dracula-plugins "git cpu-usage ram-usage"

          # available colors: white, gray, dark_gray, light_purple, dark_purple, cyan, green, orange, red, pink, yellow
          # set -g @dracula-[plugin-name]-colors "[background] [foreground]"
          # set -g @dracula-cpu-usage-colors "pink dark_gray"

          set -g @dracula-show-powerline true

          # it can accept `session`, `smiley`, `window`, or any character.
          set -g @dracula-show-left-icon window

          set -g @dracula-show-location false
        '';
      }
    ];
  };
}
