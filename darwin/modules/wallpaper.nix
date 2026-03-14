{
  config,
  lib,
  ...
}:

let
  cfg = config.wallpaper;
in
{
  options.wallpaper = {
    enable = lib.mkEnableOption "Apply a wallpaper for the primary user";

    image = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to wallpaper image file";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.image != null;
        message = "wallpaper.image must be set when wallpaper.enable is true.";
      }
    ];

    system.activationScripts.postActivation.text = ''
      # desktoppr cask installs the CLI at /usr/local/bin/desktoppr
      sudo -u ${config.system.primaryUser} /usr/local/bin/desktoppr "${cfg.image}"
    '';
  };
}
