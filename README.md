# Dotfiles

My WIP nix configuration for MacOS

## Prerequisites

#### Xcode Command Line Tools

`xcode-select --install`

#### Homebrew

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

#### Rosetta 2 (Optional)

`softwareupdate --install-rosetta --agree-to-license`

#### Mac App Store

Sign-in to Mac App Store with your Apple ID to install mas apps.

#### Rosetta 2 (Optional)

`softwareupdate --install-rosetta --agree-to-license`

## Install Nix

Install Nix using [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer).

## Bootstrap (run only first time)

`nix run nix-darwin -- switch --flake .#<host_name>`

## Update

`darwin-rebuild switch --flake .#<host_name>`
