# Secrets Management with sops-nix

This directory contains encrypted secrets managed by [sops-nix](https://github.com/Mic92/sops-nix).

## Setup

### 1. Generate an age key

```bash
# Create age key directory
mkdir -p ~/.config/sops/age

# Generate a new age key
nix-shell -p age --run "age-keygen -o ~/.config/sops/age/keys.txt"

# Display your public key (needed for .sops.yaml)
age-keygen -y ~/.config/sops/age/keys.txt
```

### 2. Configure .sops.yaml

Edit `secrets/.sops.yaml` and add your age public key:

```yaml
keys:
  - &your-key age1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

creation_rules:
  - path_regex: secrets\.yaml$
    age: *your-key
```

### 3. Create and encrypt your secrets file

```bash
# Copy the example file
cp secrets/secrets.yaml.example secrets/secrets.yaml

# Edit and encrypt the file with sops
nix-shell -p sops --run "sops secrets/secrets.yaml"
```

## Usage

### System-level secrets (nix-darwin)

Configure in `darwin/modules/sops.nix`:

```nix
sops.defaultSopsFile = ../secrets/secrets.yaml;
sops.age.keyFile = "/Users/youruser/.config/sops/age/keys.txt";

sops.secrets.example-secret = {
  # Available at /run/secrets/example-secret
};
```

### User-level secrets (home-manager)

Configure in `home-manager/sops.nix`:

```nix
sops.defaultSopsFile = ./../secrets/secrets.yaml;
sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

sops.secrets.example-user-secret = {
  # Available at ~/.config/sops-nix/secrets/example-user-secret
  path = "${config.home.homeDirectory}/.ssh/my-key";
};
```

## Common Tasks

### Edit encrypted secrets

```bash
sops secrets/secrets.yaml
```

### Add a new secret

```bash
# Edit the file (sops will encrypt on save)
sops secrets/secrets.yaml

# Then reference it in your nix configuration
```

### Rotate keys

```bash
# Update .sops.yaml with new keys
# Then re-encrypt the file
sops updatekeys secrets/secrets.yaml
```

### Decrypt a file (for debugging)

```bash
sops -d secrets/secrets.yaml
```

## Security Notes

- Never commit unencrypted secrets
- Keep your age private key (`~/.config/sops/age/keys.txt`) secure and backed up
- The `.gitignore` file ensures only encrypted `.yaml` files are committed
- Age keys are more secure and easier to manage than GPG keys
- Each host should have its own age key for better security isolation

## Converting from SSH to age

If you want to use your existing SSH key:

```bash
# Convert SSH key to age format
nix-shell -p ssh-to-age --run "ssh-to-age < ~/.ssh/id_ed25519.pub"

# Use the output in .sops.yaml
```

Note: Using dedicated age keys is recommended over SSH keys for better security separation.
