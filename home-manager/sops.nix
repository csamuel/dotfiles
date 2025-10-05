{ config, pkgs, ... }:

{
  # Home-manager sops configuration
  # This module sets up sops-nix for user-level secrets

  # Configure sops defaults for home-manager
  # Uncomment and configure when you have keys set up:
  # sops.defaultSopsFile = ./../secrets/secrets.yaml;
  # sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

  # Example user-level secret (uncomment to use):
  # sops.secrets.example-user-secret = {
  #   # This secret will be available at ${config.home.homeDirectory}/.config/sops-nix/secrets/example-user-secret
  #   # You can customize the path:
  #   # path = "${config.home.homeDirectory}/.ssh/my-secret-key";
  # };

  # Example: SSH key managed by sops
  # sops.secrets."ssh/private-key" = {
  #   path = "${config.home.homeDirectory}/.ssh/id_ed25519_sops";
  # };
}
