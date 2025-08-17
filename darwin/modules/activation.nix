{ ... }:

{
  system.activationScripts.extraActivation.text = ''
    # Show Library folder
    chflags nohidden ~/Library

    # TODO: Disable until I can determine why this inverts natural scrolling option
    # Following line should allow us to avoid a logout/login cycle to see changes
    # /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
