{ config, lib, inputs, self, ... }:
let
	username = config.my.user.username;
in
{

config = lib.mkIf (config.my.platform-theme.enableGUIToolkitTheming)
{
	my.platform-theme.qt_colorscheme_path = "/home/${username}/.local/share/color-schemes/noctalia.colors";
};

}