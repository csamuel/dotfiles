{ pkgs, lib, ... }:

{
  fonts.packages = lib.mkAfter [ pkgs.nerd-fonts.fira-code ];

  wallpaper = {
    enable = true;
    image = ../../wallpapers/deeptwilight.png;
  };

  dock.extraApps = [
    "/Applications/Figma.app"
    "/Applications/Linear.app"
    "/Applications/Notion.app"
    "/Applications/Notion Calendar.app"
  ];
}
