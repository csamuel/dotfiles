{
  config,
  lib,
  ...
}:
let
  baseDockApps = [
    { app = "/Applications/Slack.app"; }
    { app = "/System/Applications/Messages.app"; }
    { app = "/Applications/Signal.app"; }
    { app = "/Applications/Google Chrome.app"; }
    { app = "/Applications/Visual Studio Code.app"; }
    { app = "/Applications/Ghostty.app"; }
    { app = "/Applications/Zed.app"; }
    { app = "/Applications/Tower.app"; }
    { app = "/Applications/Docker.app/Contents/MacOS/Docker Desktop.app"; }
  ];

  mkApp = path: { app = path; };
in
{
  options.dock.extraApps = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "Additional apps to append to the Dock";
  };

  config = {
    system.defaults.dock.persistent-apps =
      baseDockApps
      ++ (map mkApp config.dock.extraApps)
      ++ [
        {
          spacer = {
            small = true;
          };
        }
      ];
  };
}
