# Secrets Management with agenix

This directory contains the configuration for managing secrets using [agenix](https://github.com/ryantm/agenix).

## Setup

1. **Generate SSH keys for each host** (if not already done):
   ```bash
   ssh-keygen -t ed25519 -C "your-email@example.com"
   ```

2. **Update `secrets.nix`** with the actual SSH public keys from each host:
   - Replace the placeholder keys with real SSH public keys from each machine
   - Keys can be found at `~/.ssh/id_ed25519.pub` or similar

3. **Create encrypted secrets**:
   ```bash
   # Add a secret file
   agenix -e example-secret.age
   
   # Re-key all secrets when adding new SSH keys
   agenix -r
   ```

4. **Configure secrets in `darwin/modules/secrets.nix`**:
   - Uncomment and configure the age.secrets section
   - Set appropriate file paths, owners, and permissions

## Usage

After setup, secrets will be automatically decrypted and available at runtime in the specified locations (typically `/run/agenix/`).

## Security Notes

- Never commit unencrypted secrets to the repository
- Only the `.age` files should be committed
- SSH private keys should be kept secure and backed up safely
- Each host needs its SSH private key to decrypt secrets intended for it