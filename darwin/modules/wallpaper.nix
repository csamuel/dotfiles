{
  config,
  lib,
  ...
}:

let
  cfg = config.wallpaper;
in
{
  options.wallpaper = lib.mkOption {
    type = lib.types.nullOr lib.types.path;
    default = null;
    description = "Path to wallpaper image file";
  };

  config = lib.mkIf (cfg != null) {
    homebrew.casks = [ "desktoppr" ];

    system.activationScripts.postActivation.text = ''
      sudo -u ${config.system.primaryUser} /usr/local/bin/desktoppr "${cfg}"
    '';
  };
}
