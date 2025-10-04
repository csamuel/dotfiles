{ config, pkgs, lib, ... }:

{
  # Configure agenix for secret management
  age.secrets = {
    # Example secret configuration - uncomment and modify as needed
    # example-secret = {
    #   file = ../../secrets/example-secret.age;
    #   owner = "chris";
    #   group = "staff";
    #   mode = "0400";
    # };
  };

  # Add agenix CLI to environment
  environment.systemPackages = with pkgs; [
    age
  ];
}