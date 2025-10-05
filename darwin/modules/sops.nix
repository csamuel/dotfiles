{ config, pkgs, ... }:

{
  # System-level sops configuration for nix-darwin
  # This module sets up sops-nix for managing secrets on macOS

  # Add sops-nix package to system packages
  environment.systemPackages = with pkgs; [
    sops
    age
    ssh-to-age
  ];

  # Configure sops defaults
  # Uncomment and configure when you have keys set up:
  # sops.defaultSopsFile = ../secrets/secrets.yaml;
  # sops.age.keyFile = "/Users/${config.users.users.${config.networking.hostName}.name}/.config/sops/age/keys.txt";

  # Example system-level secret (uncomment to use):
  # sops.secrets.example-secret = {
  #   # This secret will be available at /run/secrets/example-secret
  #   # Mode and owner can be customized:
  #   # mode = "0440";
  #   # owner = config.users.users.myuser.name;
  # };
}
