{
  config,
  repoRoot,
  ...
}:

{
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${repoRoot}/.config/nvim";
}
