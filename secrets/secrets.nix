let
  # SSH public keys for accessing secrets
  chris-benson = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPlaceholderKeyForBenson";
  chris-higgins = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPlaceholderKeyForHiggins";
  chris-spaceblack = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPlaceholderKeyForSpaceBlack";
  chris-dunston = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPlaceholderKeyForDunston";

  # All keys for convenient access
  allKeys = [ chris-benson chris-higgins chris-spaceblack chris-dunston ];
in
{
  # Example secret files - these would be encrypted with agenix
  # "example-secret.age".publicKeys = allKeys;
  # "api-token.age".publicKeys = [ chris-benson chris-higgins ];
  # "database-password.age".publicKeys = allKeys;
}