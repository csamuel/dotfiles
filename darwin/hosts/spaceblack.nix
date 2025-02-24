{ pkgs, ... }:
# Packages just for spaceblack
{
  fonts.packages = [
    pkgs.nerd-fonts.fira-code
  ];
}
