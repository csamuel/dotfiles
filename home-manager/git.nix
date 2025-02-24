{ ... }:
{
  home.file = {
    ".gitconfig".source = ../.config/git/.gitconfig;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
  };
}
