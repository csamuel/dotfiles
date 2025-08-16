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
}
