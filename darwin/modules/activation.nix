{ config, ... }:

{
  system.activationScripts.extraActivation.text = ''
    # Show Library folder
    chflags nohidden "/Users/${config.system.primaryUser}/Library"

    # Configure trusted-users for Determinate Nix
    if [ -f /etc/nix/nix.custom.conf ]; then
      if ! grep -q "trusted-users.*${config.system.primaryUser}" /etc/nix/nix.custom.conf; then
        echo "trusted-users = root ${config.system.primaryUser}" >> /etc/nix/nix.custom.conf
      fi
    fi

    # TODO: Disable until I can determine why this inverts natural scrolling option
    # Following line should allow us to avoid a logout/login cycle to see changes
    # /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
