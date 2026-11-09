{ config, lib, ... }:
{

options.my.hyprland.enableHyprpaper = lib.mkOption
{
	type = lib.types.bool;
	default = true;
	description = "Enable hyprpaper";
};

config = lib.mkIf (config.my.hyprland.enableHyprpaper && config.my.hyprland.enable)
{
	home-manager.users."${config.my.user.username}".services.hyprpaper =
	{
		enable = true;
		settings =
		{
			splash = false;
			wallpaper =
			{
				monitor = "";
				path = "/data/wallpaper.png";
				fit_mode = "cover";
			};
		};
	};
};

}
