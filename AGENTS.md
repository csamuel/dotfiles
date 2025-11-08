# Agent Guidelines

## Project Structure
- `flake.nix` - Main flake configuration with inputs and outputs
- `darwin/` - macOS system configurations
  - `hosts/` - Per-host configurations (higgins, benson, spaceblack, dunston)
  - `modules/` - Reusable Darwin modules
- `home-manager/` - User environment configurations
- `.config/` - Application-specific configs (ghostty, git, zed)
- `treefmt.toml` - Formatting configuration

## Build/Lint/Test Commands
- **Format code**: `nix develop -c treefmt` or `treefmt`
- **Check formatting (CI)**: `nix develop -c treefmt --ci`
- **Check for unused Nix code**: `nix run nixpkgs#deadnix -- --fail`
- **Show flake outputs**: `nix flake show`
- **Flake check**: `nix flake check --keep-going --print-build-logs`
- **Evaluate host config**: `nix eval --raw .#darwinConfigurations.<host>.config.system.build.toplevel.drvPath`
- **Build host config**: `nix build --keep-going --print-build-logs .#darwinConfigurations.<host>.config.system.build.toplevel`
- **Apply changes**: `sudo darwin-rebuild switch --flake .#<host>` (hosts: higgins, benson, spaceblack, dunston)
- **Update flake inputs**: `nix flake update` or `nix flake lock --update-input <input>`

## Testing Workflow
Before applying changes:
1. Check formatting: `treefmt --ci`
2. Check for dead code: `nix run nixpkgs#deadnix -- --fail`
3. Run flake check: `nix flake check --keep-going --print-build-logs`
4. Build specific host: `nix build .#darwinConfigurations.<host>.config.system.build.toplevel`
5. Apply if successful: `sudo darwin-rebuild switch --flake .#<host>`

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

## Common Patterns
- **Enable a module option**: `programs.foo.enable = true;`
- **Add packages**: `home.packages = with pkgs; [ package1 package2 ];`
- **Darwin packages**: `environment.systemPackages = with pkgs; [ ... ];`
- **Conditional config**: Use `lib.mkIf condition { ... }`
- **Override packages**: Use `pkgs.package.override { ... }`

## Important Constraints
- **No sudo in build commands**: Only use `sudo` for `darwin-rebuild switch`
- **Always format before commit**: Use `treefmt` or configure pre-commit hooks
- **Test host-specific changes**: Build and test on the specific host affected
- **Keep modules pure**: Avoid side effects in module definitions

## Troubleshooting
- **Build fails**: Check `nix flake check` output for specific errors
- **Format issues**: Run `treefmt` to auto-fix formatting
- **Unfree packages**: Already configured globally, no need to override
- **Update flake inputs**: `nix flake update` or `nix flake lock --update-input <input>`

## Quick Reference
- **Current hosts**: higgins, benson, spaceblack, dunston
- **Darwin state version**: 4
- **Home-manager state version**: "24.05"
- **Primary formatter**: nixfmt-rfc-style
- **Flake**: Uses `nixpkgs` and `darwin` + `home-manager` as inputs
