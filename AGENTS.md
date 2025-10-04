# Agent Guidelines

## Build/Lint/Test Commands
- **Format code**: `nix develop -c treefmt` or `treefmt`
- **Check formatting (CI)**: `nix develop -c treefmt --ci`
- **Check for unused Nix code**: `nix run nixpkgs#deadnix -- --fail`
- **Show flake outputs**: `nix flake show`
- **Flake check**: `nix flake check --keep-going --print-build-logs`
- **Evaluate host config**: `nix eval --raw .#darwinConfigurations.<host>.config.system.build.toplevel.drvPath`
- **Build host config**: `nix build --keep-going --print-build-logs .#darwinConfigurations.<host>.config.system.build.toplevel`
- **Apply changes**: `sudo darwin-rebuild switch --flake .#<host>` (hosts: higgins, benson, spaceblack, dunston)

## Code Style
- **Language**: Nix using RFC-style formatting (nixfmt-rfc-style)
- **Formatting**: Use `nixfmt` formatter (configured in treefmt.toml)
- **Imports**: Group imports in `imports = [ ... ];` blocks at the top of modules
- **Function signatures**: Use attribute sets with destructuring: `{ pkgs, lib, config, ... }:`
- **Unfree packages**: Already allowed via `nixpkgs.config.allowUnfree = true`
- **Module pattern**: Create modular configs in `darwin/modules/` and `home-manager/` directories
- **Host configs**: Per-host configurations go in `darwin/hosts/<hostname>.nix`
- **State version**: Current darwin state version is 4, home-manager is "24.05"
- **No unused code**: Ensure no dead Nix code (checked by deadnix)
