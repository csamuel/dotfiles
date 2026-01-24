{ pkgs, lib, ... }:

{
  fonts.packages = lib.mkAfter [ pkgs.nerd-fonts.fira-code ];
}
