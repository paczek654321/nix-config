{config, lib, ...}:
{

config = lib.mkIf (config.my.platform-theme.enableGUIToolkitTheming && config.my.hyprland.enable)
{
	home-manager.users."${config.my.user.username}" =
	{
		home.pointerCursor.hyprcursor.enable = true;
	};
};

}