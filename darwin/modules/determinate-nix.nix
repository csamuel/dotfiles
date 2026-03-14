{
  config,
  lib,
  ...
}:

let
  cfg = config.determinateNix;
  trustedUsers = lib.concatStringsSep " " cfg.trustedUsers;
in
{
  options.determinateNix = {
    enable = lib.mkEnableOption "Determinate Nix compatibility tweaks";

    trustedUsers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ config.system.primaryUser ];
      description = "Users that should be written to /etc/nix/nix.custom.conf.";
    };
  };

  config = lib.mkIf cfg.enable {
    system.activationScripts.determinateNix.text = ''
      if [ -f /etc/nix/nix.custom.conf ]; then
        tmp="$(mktemp)"
        grep -Ev '^[[:space:]]*trusted-users[[:space:]]*=.*$' /etc/nix/nix.custom.conf > "$tmp" || true
        echo "trusted-users = root ${trustedUsers}" >> "$tmp"
        mv "$tmp" /etc/nix/nix.custom.conf
      fi
    '';
  };
}
