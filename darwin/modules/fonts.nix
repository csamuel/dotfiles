{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    atkinson-hyperlegible
    jetbrains-mono
  ];
}
