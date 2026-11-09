{ config, lib, pkgs, ...}:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{

options.my.kitty.enable = lib.mkEnableOption "Enable kitty";

config = lib.mkIf config.my.kitty.enable
{
	home-manager.users."${config.my.user.username}".programs.kitty =
	{
		enable = true;
		settings =
		{
			background_opacity = 0.5;
			background = "#${colorPalette.background}";
			# Shell integration via home manager appears broken
			shell_integration = "enabled";
		};
		shellIntegration.mode = null;
	};
};

}